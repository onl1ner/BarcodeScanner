//
//  MainBuilder.swift
//  BarcodeScanner
//
//  Created by Tamerlan Satualdypov on 17.07.2021.
//  Copyright © 2021 onl1ner onl1ner. All rights reserved.
//

import Foundation

final class MainBuilder {
    
    public static func build() -> MainViewController {
        let view = MainViewController()
        let router = MainRouter(view: view)
        let presenter = MainPresenter(view: view, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
}
