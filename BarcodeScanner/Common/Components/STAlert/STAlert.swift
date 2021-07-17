//
//  STAlert.swift
//  BarcodeScanner
//
//  Created by Tamerlan Satualdypov on 17.07.2021.
//  Copyright © 2021 onl1ner onl1ner. All rights reserved.
//

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
