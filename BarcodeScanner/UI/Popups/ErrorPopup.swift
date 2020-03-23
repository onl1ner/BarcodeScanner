//
//  ErrorPopup.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 23/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import SwiftEntryKit

class ErrorPopup: UIView {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBAction func dismissPressed(_ sender: Any) {
        SwiftEntryKit.dismiss()
    }
    
    public func show(withError error : Int) -> Void {
        switch error {
            case 404:
                imageView.image = UIImage(named: "notFound")
                
                titleLabel.text = "Уупс!"
                descriptionLabel.text = "Похоже, что в базе данных не нашлось продуктов с подходящим штрихкодом."
            default:
                imageView.image = UIImage(named: "sthWentWrong")
                
                titleLabel.text = "О нет!"
                descriptionLabel.text = "Произошла непредвиденная ошибка, мы уже занимаемся над её исправлением."
        }
    }
}

