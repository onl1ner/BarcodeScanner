//
//  ErrorPresenter.swift
//  BarcodeScanner
//
//  Created by Tamerlan Satualdypov on 17.07.2021.
//  Copyright © 2021 onl1ner onl1ner. All rights reserved.
//

import Foundation

protocol ErrorPresenterProtocol {
    func viewDidLoad() -> ()
    init(view : ErrorViewControllerProtocol, error : NetworkError)
}

final class ErrorPresenter : ErrorPresenterProtocol {
    
    private weak var view: ErrorViewControllerProtocol?
    private var error: NetworkError
    
    public func viewDidLoad() -> () {
        self.view?.set(image: self.error.image)
        self.view?.set(title: self.error.title)
        self.view?.set(message: self.error.message)
    }
    
    init(view: ErrorViewControllerProtocol, error: NetworkError) {
        self.view = view
        self.error = error
    }
}
