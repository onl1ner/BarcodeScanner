//
//  MainPresenter.swift
//  BarcodeMVP
//
//  Created by onl1ner onl1ner on 01.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

protocol MainPresenterProtocol {
    func product(for barcode: String) -> ()
    
    init(view: MainViewControllerProtocol, router: MainRouterProtocol)
}

final class MainPresenter: MainPresenterProtocol {
    
    private weak var view: MainViewControllerProtocol?
    private var router: MainRouterProtocol
    
    public func product(for barcode: String) -> () {
        self.view?.stopInput()
        self.view?.startLoading()
        
        NetworkService.getProduct(withBarcode: barcode) { [weak self] (product, error) in
            self?.view?.stopLoading()
            
            if let error = error {
                self?.router.show(error: error)
                return
            }
            
            guard let product = product else {
                self?.router.show(error: .unexpected)
                return
            }
            
            self?.router.show(product: product)
        }
    }
    
    init(view: MainViewControllerProtocol, router: MainRouterProtocol) {
        self.view = view
        self.router = router
    }
}
