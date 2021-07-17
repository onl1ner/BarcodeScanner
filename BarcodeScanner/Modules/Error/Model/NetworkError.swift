//
//  NetworkError.swift
//  BarcodeScanner
//
//  Created by Tamerlan Satualdypov on 17.07.2021.
//  Copyright © 2021 onl1ner onl1ner. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case notFound
    case transportError(Error)
    case badRequest
    case unexpected
    
    public var title: String {
        return "Произошла ошибка"
    }
    
    public var message: String {
        switch self {
            case .notFound: return "Похоже, что в базе данных не нашлось продуктов с подходящим штрихкодом."
            case .transportError(let error as NSError): return "Произошла ошибка при отправке данных на сервер. Код: \(error.code)"
            case .badRequest, .unexpected: return "Произошла непредвиденная ошибка."
        }
    }
    
    public var image: UIImage? {
        switch self {
            case .notFound: return .init(systemName: "tray.and.arrow.up")
            case .transportError(_): return .init(systemName: "wifi.exclamationmark")
            case .badRequest, .unexpected: return .init(systemName: "barcode.viewfinder")
        }
    }
    
}
