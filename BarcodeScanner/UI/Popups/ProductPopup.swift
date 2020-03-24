//
//  ProductPopup.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 22/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import SwiftEntryKit

final class ProductPopup: UIView {
    @IBOutlet var productImageBackView: UIView!
    @IBOutlet var productImage: UIImageView!
    
    @IBOutlet var productClass: UILabel!
    @IBOutlet var productName: UILabel!
    
    @IBOutlet var barcodeBackView: UIView!
    @IBOutlet var barcodeLabel: UILabel!
    
    @IBAction func dismissPressed(_ sender: Any) -> Void {
        SwiftEntryKit.dismiss()
    }
    
    public func setProductImage(whereImage image : UIImage) -> Void {
        DispatchQueue.main.async {
            self.productImageBackView.layer.cornerRadius = 20
            
            self.productImageBackView.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                                  withOpacity: 0.2,
                                                  withOffset: CGSize(width: 0,
                                                                     height: 1))
            
            self.productImage.layer.cornerRadius = 15
            
            self.productImage.image = image
        }
    }
    
    public func setProductBarcode(whereBarcode barcode : String) -> Void {
        DispatchQueue.main.async {
            self.barcodeBackView.layer.cornerRadius = 15
            
            self.barcodeBackView.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                             withOpacity: 0.2,
                                             withOffset: CGSize(width: 0,
                                                                height: 1))
            
            self.barcodeLabel.text = barcode
        }
    }
    
    public func setProductClass(whereClass classification : String) -> Void {
        DispatchQueue.main.async {
            self.productClass.text = classification
        }
    }
    
    public func setProductName(whereName name : String) -> Void {
        DispatchQueue.main.async {
            self.productName.text = name
        }
    }
}
