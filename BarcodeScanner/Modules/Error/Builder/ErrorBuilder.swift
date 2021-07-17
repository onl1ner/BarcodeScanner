//
//  ErrorBuilder.swift
//  BarcodeScanner
//
//  Created by Tamerlan Satualdypov on 17.07.2021.
//  Copyright © 2021 onl1ner onl1ner. All rights reserved.
//

import Foundation

final class ErrorBuilder {
    
    public static func build(with error: NetworkError, delegate: STModalDelegate?) -> STModal {
        let view = ErrorViewController()
        let presenter = ErrorPresenter(view: view, error: error)
        
        view.presenter = presenter
        
        return .init(view: view, delegate: delegate)
            .set(width: .offset(value: 16.0))
            .set(height: .intrinsic)
            .set(verticalOffset: 32.0)
            .set(position: .bottom)
    }
    
}
