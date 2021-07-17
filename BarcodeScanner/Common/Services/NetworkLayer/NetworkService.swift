//
//  NetworkService.swift
//  BarcodeMVP
//
//  Created by onl1ner onl1ner on 01.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

protocol NetworkServiceProtocol {
    static func getProduct(withBarcode barcode : String, completion: @escaping (Product?, NetworkError?) -> ()) -> ()
}

final class NetworkService : NetworkServiceProtocol {
    
    private static let dataLocation : String = "https://barcodes.olegon.ru/api/card"
    private static let googleAPILocation : String = "https://www.googleapis.com/customsearch/v1"
    
    private static let googleAPIKey : String = "AIzaSyBoqHyHDVZugSUI6fan-fqnbl_ieR01yNs"
    private static let googleSearchEngineKey : String = "007337280464247857418:hgpmffeg34k"
    
    private static func createDataTask(with url : URL?, completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> () {
        guard let url = url else {
            print("\(#function) on \(#line) received URL which is nil")
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private static func retrieveAndSerialize<T : Decodable>(_ objectType : T.Type, from url : URL?,
                                                            completion: @escaping (Result<T, NetworkError>) -> ()) -> () {
        createDataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            let response = response as! HTTPURLResponse
            switch response.statusCode {
                case 400: completion(.failure(.badRequest)); return
                case 404: completion(.failure(.notFound)); return
                case 429: completion(.failure(.unexpected)); return
                default: break
            }
            
            if let data = data {
                if let serializedData = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(serializedData))
                }
            }
        }
    }
    
    private static func downloadImage(from url : URL?, completion: @escaping (UIImage?) -> ()) -> () {
        createDataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            completion(UIImage(data: data))
        }
    }
    
    /// Функция получает ссылку на картинку из гугла и скачивает её.
    private static func getProductImage(barcode : String, completion: @escaping (UIImage?) -> ()) -> () {
        let queryParameters = [URLQueryItem(name: "key", value: googleAPIKey),
                               URLQueryItem(name: "cx", value: googleSearchEngineKey),
                               URLQueryItem(name: "searchType", value: "image"),
                               URLQueryItem(name: "q", value: barcode),
                               URLQueryItem(name: "fields", value: "items(link)")]
        
        var components = URLComponents(string: googleAPILocation)
        components?.queryItems = queryParameters
        
        retrieveAndSerialize(GoogleResponse.self, from: components?.url) { (result) in
            switch result {
                case .success(let response):
                    if !response.items.isEmpty {
                        guard let url = URL(string: response.items[0].link) else { completion(nil); return }
                        downloadImage(from: url) { image in completion(image) }
                    } else { completion(nil) }
                case .failure(_): completion(nil)
            }
        }
    }
    
    /// Функция получает наименование продукта.
    private static func getProductName(barcode : String, completion: @escaping (String?, NetworkError?) -> ()) -> () {
        let url = URL(string: dataLocation + "/name/\(barcode)")
        
        retrieveAndSerialize(Product.Name.self, from: url) { (result) in
            switch result {
                case .success(let productName): completion(productName.names[0], nil)
                case .failure(let error): completion(nil, error)
            }
        }
    }
    
    /// Функция получает классификатор продукта.
    private static func getProductClass(barcode: String, completion: @escaping (String) -> ()) {
        let url = URL(string: dataLocation + "/class/\(barcode)")
        
        retrieveAndSerialize(Product.Class.self, from: url) { (result) in
            switch result {
                case .success(let productClass): completion(productClass.classification[0])
                
                // АPI может выдывать пустые массивы с 404 кодом даже когда
                // продукт имеется в базе данных. Связано это с тем что
                // продукт просто может быть не классифицирован.
                case .failure(_): completion("Не классифицирован")
            }
        }
    }
    
    public static func getProduct(withBarcode barcode : String, completion: @escaping (Product?, NetworkError?) -> ()) -> () {
        var classification : String = "Не классифицирован"
        var name : String = "Наименование продукта"
        var image : UIImage?
        
        var error : NetworkError?
        
        let group : DispatchGroup = .init()
        
        group.enter()
        getProductClass(barcode: barcode) { (productClass) in
            classification = productClass
            group.leave()
        }
        
        group.enter()
        getProductName(barcode: barcode) { (productName, httpError) in
            if let httpError = httpError {
                error = httpError
            } else {
                name = productName!
            }
            group.leave()
        }
        
        group.enter()
        getProductImage(barcode: barcode) { (downloadedImage) in
            image = downloadedImage
            group.leave()
        }
        
        group.notify(queue: .main) {
            DispatchQueue.main.async {
                if error == nil {
                    let product = Product(classification: classification,
                                          name: name,
                                          barcode: barcode,
                                          image: image)
                    
                    completion(product, nil)
                } else { completion(nil, error) }
            }
        }
    }
}
