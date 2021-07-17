//
//  UIView.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 24/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

extension UIView {
    
    public func setupShadow(withColor color : UIColor, opacity : Float, offset : CGSize) -> () {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
    }
    
}
