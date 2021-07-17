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

protocol MainPresenterProtocol {
    func product(for barcode: String) -> ()
    
    init(view: MainViewControllerProtocol, router: MainRouterProtocol)
}

final class MainPresenter: MainPresenterProtocol {
    
    private weak var view: MainViewControllerProtocol?
    private var router: MainRouterProtocol
    
    public func product(for barcode: String) -> () {
        self.view?.stopInput()
        self.view?.startLoading()
        
        NetworkService.shared.product(for: barcode) { result in
            self.view?.stopLoading()
            
            switch result {
                case .success(let product): self.router.show(product: product)
                case .failure(let error): self.router.show(error: error)
            }
        }
    }
    
    init(view: MainViewControllerProtocol, router: MainRouterProtocol) {
        self.view = view
        self.router = router
    }
}
