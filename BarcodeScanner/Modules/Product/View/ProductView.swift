//
//  ProductView.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 22/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import SwiftEntryKit

final class ProductPopup: UIView {
    
    @IBOutlet private weak var productImageBackView: UIView!
    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productClass: UILabel!
    @IBOutlet private weak var productName: UILabel!
    
    @IBOutlet private weak var barcodeBackView: UIView!
    @IBOutlet private weak var barcodeLabel: UILabel!
    
    @IBAction private func dismissPressed(_ sender: UIButton) -> () {
        SwiftEntryKit.dismiss()
    }
    
    public func configure(barcode : String, classification : String,
                          name : String, image : UIImage?) -> () {
        productClass.text = classification
        productName.text = name
        
        barcodeLabel.text = barcode
        
        productImageView.image = image
    }
    
    override func awakeFromNib() -> () {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15
        
        self.productImageBackView.layer.cornerRadius = 20
        
        self.barcodeBackView.layer.cornerRadius = 15
        self.productImageView.layer.cornerRadius = 15
        
        self.productImageBackView.setupShadow(withColor: .black, withOpacity: 0.2, withOffset: .zero)
        self.barcodeBackView.setupShadow(withColor: .black, withOpacity: 0.2, withOffset: .zero)
    }
}
