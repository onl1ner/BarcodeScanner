//
//  NetworkService.swift
//  BarcodeMVP
//
//  Created by onl1ner onl1ner on 01.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

protocol NetworkServiceProtocol {
    func product(for barcode : String, completion: @escaping (Result<Product, NetworkError>) -> ()) -> ()
}

final class NetworkService : NetworkServiceProtocol {
    
    public static let shared : NetworkServiceProtocol = NetworkService()
    
    private let barcodeBase : String = "https://barcodes.olegon.ru/api/card/"
    
    private let imageBase : String = "https://www.googleapis.com/customsearch/v1"
    private let imageKey : String = "YOUR-API-KEY"
    private let imageEngineKey : String = "YOUR-SEARCH-ENGINE-KEY"
    
    private func deserialize<T: Codable>(data : Data, as objectType : T.Type) -> T? {
        return try? JSONDecoder().decode(objectType, from: data)
    }
    
    private func createDataTask(with url: URL?, completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> () {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func processDataTask<T: Codable>(data: Data?, response: URLResponse?, error: Error?) -> Result<T, NetworkError> {
        if let error = error {
            return .failure(.transportError(error))
        }
        
        switch (response as! HTTPURLResponse).statusCode {
            case 400: return .failure(.badRequest)
            case 404: return .failure(.notFound)
            case 429: return .failure(.unexpected)
            default: break
        }
        
        if let data = data {
            if let deserialized = self.deserialize(data: data, as: T.self) {
                return .success(deserialized)
            }
        }
        
        return .failure(.unexpected)
    }
    
    private func image(from url: URL?, completion: @escaping (UIImage?) -> ()) -> () {
        self.createDataTask(with: url) { data, _, error in
            guard error == nil, let data = data else { return completion(nil) }
            completion(.init(data: data))
        }
    }
    
    private func productImage(for barcode : String, completion: @escaping (UIImage?) -> ()) -> () {
        let queryParameters = [URLQueryItem(name: "key", value: self.imageKey),
                               URLQueryItem(name: "cx", value: self.imageEngineKey),
                               URLQueryItem(name: "searchType", value: "image"),
                               URLQueryItem(name: "q", value: barcode),
                               URLQueryItem(name: "fields", value: "items(link)")]
        
        var components = URLComponents(string: self.imageBase)
        components?.queryItems = queryParameters
        
        self.createDataTask(with: components?.url) { data, response, error in
            if let data = data {
                guard let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                      let dictionary = object as? [String : Any],
                      let items = dictionary["items"] as? NSArray,
                      let item = items.firstObject as? [String : String],
                      let link = item["link"]
                else { return completion(nil) }
                
                self.image(from: URL(string: link), completion: completion)
            }
        }
    }
    
    private func productName(for barcode: String, completion: @escaping (Result<String, NetworkError>) -> ()) -> () {
        let url = URL(string: self.barcodeBase + "name/\(barcode)")
        
        self.createDataTask(with: url) { data, response, error in
            completion(self.processDataTask(data: data, response: response, error: error))
        }
    }
    
    private func productClass(for barcode: String, completion: @escaping (Result<String, NetworkError>) -> ()) -> () {
        let url = URL(string: self.barcodeBase + "class/\(barcode)")
        
        self.createDataTask(with: url) { data, response, error in
            completion(self.processDataTask(data: data, response: response, error: error))
        }
    }
    
    public func product(for barcode : String, completion: @escaping (Result<Product, NetworkError>) -> ()) -> () {
        var classification : String = "Не классифицирован"
        var name : String = "Наименование продукта"
        var image : UIImage?
        
        var error : NetworkError?
        
        let group : DispatchGroup = .init()
        
        group.enter()
        
        self.productClass(for: barcode) { result in
            switch result {
                case .success(let response): classification = response
                case .failure(_): classification = "Не классифицирован"
            }
            
            group.leave()
        }
        
        group.enter()
        
        self.productName(for: barcode) { result in
            switch result {
                case .success(let response): name = response
                case .failure(let response): error = response
            }
            
            group.leave()
        }
        
        group.enter()
        
        self.productImage(for: barcode) { response in
            image = response
            group.leave()
        }
        
        group.notify(queue: .main) {
            if let error = error {
                completion(.failure(error))
            } else {
                let product : Product = .init(classification: classification, name: name, barcode: barcode, image: image)
                completion(.success(product))
            }
        }
    }
    
    private init() { }
}
