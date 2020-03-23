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
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productClass: UILabel!
    @IBOutlet var productName: UILabel!
    
    @IBAction func dismissPressed(_ sender: Any) -> Void {
        SwiftEntryKit.dismiss()
    }
    
    public func setProductImage(whereImage image : UIImage) -> Void {
        DispatchQueue.main.async {
            self.productImage.image = image
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
    
    func configurePopup(productImage image : UIImage?,
                              productClass classification : String?,
                              productName name : String?) -> Void {
        DispatchQueue.main.async {
            self.productImage.image = image
            self.productClass.text = classification
            self.productName.text = name
        }
    }
}
