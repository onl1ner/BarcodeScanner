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

