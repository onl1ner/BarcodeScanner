//
//  Product.swift
//  BarcodeMVP
//
//  Created by onl1ner onl1ner on 01.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

struct Product {
    let classification : String
    let name : String
    let barcode : String
    
    let image : UIImage?
    
    /// Структура для сериализации JSON-a возвращающий название продукта
    struct Name : Decodable {
        let status : Int
        let names : [String]
    }
    
    /// Структура для сериализации JSON-a возвращающий классификатор продукта
    struct Class : Decodable {
        let status : Int
        let classification : [String]
        
        enum CodingKeys : String, CodingKey {
            case status
            case classification = "class"
        }
    }
}
