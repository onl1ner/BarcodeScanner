//
//  Product.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 22/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import Foundation

final class Product{
    var barcode : String?
    
    private func getData(from url: URL,
                               completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> Void{
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url : URL, completion: @escaping ((_ image : UIImage?) -> Void)) -> Void {
        getData(from: url){ (data, response, error) in
            guard let data = data, error == nil else { return }
            completion(UIImage(data: data))
        }
    }
    
    public func checkIfExist(completion: @escaping ((_ status : Int) -> Void )) -> Void {
        let url = URL(string: BarcodeDataBase.url + "/name/" + barcode!)
        
        getData(from: url!) { (data, response, error) in
            if let data = data{
                if let jsonData = try? JSONDecoder().decode(Name.self, from: data){
                    completion(jsonData.status)
                }
            }
        }
    }
    
    public func getProductImage(completion: @escaping ((_ image : UIImage?) -> Void)) -> Void {
        let url = URL(string: "https://www.googleapis.com/customsearch/v1?q=\(barcode!)&searchType=image&cx=\(GoogleSearch.engineKey)&key=\(GoogleSearch.apiKey)")
        
        getData(from: url!) { (data, response, error) in
            if let data = data{
                if let jsonData = try? JSONDecoder().decode(GoogleResponse.self, from: data){
                    self.downloadImage(from: URL(string: jsonData.items[1].image!.thumbnailLink)!){ (image) in
                        completion(image) }
                }
            }
        }
    }
    
    public func getProductClass(completion: @escaping ((_ classifaction : String?) -> Void)) -> Void {
        let url = URL(string: BarcodeDataBase.url + "/class/" + barcode!)
        
        getData(from: url!) { (data, response, error) in
            if let data = data{
                if let jsonData = try? JSONDecoder().decode(Class.self, from: data){
                    completion(jsonData.class[0])
                }
            }
        }
    }
    
    public func getProductName(completion: @escaping ((_ name : String?) -> Void)) -> Void {
        let url = URL(string: BarcodeDataBase.url + "/name/" + barcode!)
        
        getData(from: url!) { (data, response, error) in
            if let data = data{
                if let jsonData = try? JSONDecoder().decode(Name.self, from: data){
                    completion(jsonData.names[0])
                }
            }
        }
    }
    
    init(barcode code : String) {
        self.barcode = code
    }
}
