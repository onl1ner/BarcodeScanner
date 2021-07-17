//
//  ProductViewController.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 22/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol ProductViewControllerProtocol: AnyObject {
    func set(image: UIImage?) -> ()
    func set(classification: String) -> ()
    func set(name: String) -> ()
    func set(barcode: String) -> ()
}

final class ProductViewController: UIViewController, ProductViewControllerProtocol {
    
    @IBOutlet private weak var imageBackView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var classLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var barcodeBackView: UIView!
    @IBOutlet private weak var barcodeLabel: UILabel!
    
    public var presenter: ProductPresenterProtocol!
    
    @IBAction private func dismissPressed(_ sender: UIButton) -> () {
        SwiftEntryKit.dismiss()
    }
    
    public func set(image: UIImage?) -> () {
        self.imageView.image = image
    }
    
    public func set(classification: String) -> () {
        self.classLabel.text = classification
    }
    
    public func set(name: String) -> () {
        self.nameLabel.text = name
    }
    
    public func set(barcode: String) -> () {
        self.barcodeLabel.text = barcode
    }
    
    override public func viewDidLoad() -> () {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 16
        
        self.imageBackView.layer.cornerRadius = 20
        
        self.barcodeBackView.layer.cornerRadius = 16
        self.imageView.layer.cornerRadius = 16
        
        self.imageBackView.setupShadow(withColor: .black, opacity: 0.2, offset: .zero)
        self.barcodeBackView.setupShadow(withColor: .black, opacity: 0.2, offset: .zero)
        
        self.presenter.viewDidLoad()
    }
}
