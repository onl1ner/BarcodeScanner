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
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBAction private func dismissPressed(_ sender: UIButton) -> () {
        SwiftEntryKit.dismiss()
    }
    
    public func configure(title : String, description : String, image : UIImage?) -> () {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.imageView.image = image
    }
    
    override func awakeFromNib() -> () {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15
    }
}

