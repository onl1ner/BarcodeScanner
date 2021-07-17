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
        
        NetworkService.shared.product(for: barcode) { result in
            self.view?.stopLoading()
            
            switch result {
                case .success(let product): self.router.show(product: product)
                case .failure(let error): self.router.show(error: error)
            }
        }
    }
    
    init(view: MainViewControllerProtocol, router: MainRouterProtocol) {
        self.view = view
        self.router = router
    }
}
