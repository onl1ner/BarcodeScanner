//
//  ErrorViewController.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 23/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol ErrorViewControllerProtocol: AnyObject {
    func set(image : UIImage?)
    func set(title : String) -> ()
    func set(message : String) -> ()
}

final class ErrorViewController: UIViewController, ErrorViewControllerProtocol {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    
    public var presenter : ErrorPresenterProtocol!
    
    @IBAction private func dismissPressed(_ sender: UIButton) -> () {
        SwiftEntryKit.dismiss()
    }
    
    public func set(image: UIImage?) -> () {
        self.imageView.image = image
    }
    
    public func set(title: String) -> () {
        self.titleLabel.text = title
    }
    
    public func set(message: String) -> () {
        self.messageLabel.text = message
    }
    
    override public func viewDidLoad() -> () {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 16
        self.presenter.viewDidLoad()
    }
    
}

