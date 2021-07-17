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

final class STAlert {
    
    private var actionSheetController : UIAlertController
    
    public func prepared() -> UIAlertController {
        return self.actionSheetController
    }
    
    public func addAction(title: String, style: UIAlertAction.Style, actionHandler: ((UIAlertAction) -> ())?) -> Self {
        let action = UIAlertAction(title: title, style: style, handler: actionHandler)
        self.actionSheetController.addAction(action)
        return self
    }
    
    public func addCancel(title: String = "Cancel") -> Self {
        let cancelAction = UIAlertAction(title: title, style: .cancel, handler: nil)
        self.actionSheetController.addAction(cancelAction)
        return self
    }
    
    public convenience init(error: NSError) {
        self.init(title: "Error", message: "\(error.domain). Code: \(error.code)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            self.actionSheetController.dismiss(animated: true, completion: nil)
        })
        
        self.actionSheetController.addAction(action)
    }
    
    public init(title: String? = nil, message: String? = nil, preferredStyle: UIAlertController.Style) {
        self.actionSheetController = .init(title: title, message: message, preferredStyle: preferredStyle)
    }
}
