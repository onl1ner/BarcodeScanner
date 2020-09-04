//
//  SceneDelegate.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 21/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let mainVC = MainViewController()
        
        let mainPresenter = MainPresenter(view: mainVC)
        let popupBuilder = PopupBuilder(root: mainVC)
        
        mainVC.presenter = mainPresenter
        mainVC.popupBuilder = popupBuilder
        
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}

