//
//  MIT License
//
//  Copyright (c) 2021 Tamerlan Satualdypov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
