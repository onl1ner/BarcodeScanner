//
//  ProductPresenter.swift
//  BarcodeScanner
//
//  Created by Tamerlan Satualdypov on 17.07.2021.
//  Copyright © 2021 onl1ner onl1ner. All rights reserved.
//

import Foundation

protocol ProductPresenterProtocol {
    func viewDidLoad() -> ()
    init(view: ProductViewControllerProtocol, product: Product)
}

final class ProductPresenter : ProductPresenterProtocol {
    
    private weak var view: ProductViewControllerProtocol?
    private var product: Product
    
    public func viewDidLoad() -> () {
        self.view?.set(image: self.product.image)
        self.view?.set(classification: self.product.classification)
        self.view?.set(name: self.product.name)
        self.view?.set(barcode: self.product.barcode)
    }
    
    init(view: ProductViewControllerProtocol, product: Product) {
        self.view = view
        self.product = product
    }
}
