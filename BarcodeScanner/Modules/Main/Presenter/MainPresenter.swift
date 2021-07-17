//
//  MainPresenter.swift
//  BarcodeMVP
//
//  Created by onl1ner onl1ner on 01.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

protocol MainPresenterProtocol : CameraDelegate {
    func product(for barcode : String) -> ()
    
    init(view : MainViewControllerProtocol)
}

final class MainPresenter : MainPresenterProtocol {
    
    private weak var view : MainViewControllerProtocol?
    
    public func product(for barcode: String) -> () {
        NetworkService.getProduct(withBarcode: barcode) { [weak self] (product, error) in
            if let httpError = error {
                self?.view?.show(error: httpError)
                return
            }
            
            guard let product = product else {
                fatalError("Product is nil at \(#function) on \(#line)")
            }
            
            self?.view?.show(product: product)
        }
    }
    
    init(view : MainViewControllerProtocol) {
        self.view = view
    }
}

extension MainPresenter : CameraDelegate {
    
    public func scanned(barcode: String) -> () {
        self.product(for: barcode)
    }
    
}
