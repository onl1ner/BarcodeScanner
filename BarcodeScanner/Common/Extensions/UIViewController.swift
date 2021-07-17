//
//  UIViewController.swift
//  BarcodeMVP
//
//  Created by onl1ner onl1ner on 02.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func showAlert(title: String, message: String) -> () {
        let alert = STAlert(title: title, message: message, preferredStyle: .alert)
            .addCancel(title: "Понятно")
            .prepared()
        
        self.present(alert, animated: true)
    }
    
}
