//
//  UIViewController.swift
//  BarcodeMVP
//
//  Created by onl1ner onl1ner on 02.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

extension UIViewController {
    
    internal func showAlert(title : String, message : String) -> () {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "Понятно", style: .cancel) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(closeAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
