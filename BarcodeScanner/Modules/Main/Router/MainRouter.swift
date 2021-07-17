//
//  MainRouter.swift
//  BarcodeScanner
//
//  Created by Tamerlan Satualdypov on 17.07.2021.
//  Copyright © 2021 onl1ner onl1ner. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol MainRouterProtocol {
    func show(product: Product) -> ()
    func show(error: HTTPError) -> ()
    
    init(view: MainViewController)
}

final class MainRouter: MainRouterProtocol {
    
    private weak var view : MainViewController?
    
    public func show(product: Product) -> () {
        
    }
    
    public func show(error: HTTPError) -> () {
        
    }
    
    init(view: MainViewController) {
        self.view = view
    }
    
}
