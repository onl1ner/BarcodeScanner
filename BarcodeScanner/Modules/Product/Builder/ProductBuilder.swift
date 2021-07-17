//
//  ProductBuilder.swift
//  BarcodeScanner
//
//  Created by Tamerlan Satualdypov on 17.07.2021.
//  Copyright © 2021 onl1ner onl1ner. All rights reserved.
//

import Foundation

final class ProductBuilder {
    
    public static func build(with product: Product, delegate: STModalDelegate?) -> STModal {
        let view = ProductViewController()
        let presenter = ProductPresenter(view: view, product: product)
        
        view.presenter = presenter
        
        return .init(view: view, delegate: delegate)
            .set(width: .offset(value: 16.0))
            .set(height: .intrinsic)
            .set(verticalOffset: 32.0)
            .set(position: .bottom)
    }
    
}
