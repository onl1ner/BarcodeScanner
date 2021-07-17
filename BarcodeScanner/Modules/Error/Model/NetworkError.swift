//
//  MIT License
//
//  Copyright (c) 2021 Tamerlan Satualdypov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
