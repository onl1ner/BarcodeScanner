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

protocol MainViewControllerProtocol: AnyObject, STModalDelegate {
    func stopInput() -> ()
    
    func startLoading() -> ()
    func stopLoading() -> ()
}

final class MainViewController: UIViewController, MainViewControllerProtocol {
    
    @IBOutlet private weak var toggleFlashlightButton : UIButton!
    
    @IBOutlet private weak var blurEffectView : UIVisualEffectView!
    @IBOutlet private weak var activityIndicator : UIActivityIndicatorView!
    
    private lazy var camera : STCameraProtocol = STCamera(frame: self.view.layer.bounds, delegate: self)
    
    public var presenter : MainPresenterProtocol!
    
    @IBAction private func toggleFlashlight(_ sender: UIButton) -> () {
        let status = self.camera.toggleFlashlight()
        
        switch status {
            case .on: sender.setImage(UIImage(systemName: "bolt.slash.circle.fill"), for: .normal)
            case .off: sender.setImage(UIImage(systemName: "bolt.circle.fill"), for: .normal)
            case .notFound: self.showAlert(title: "Произошла ошибка", message: "Похоже, что на вашем устройстве нет фонарика.")
            case .notInitialized: self.showAlert(title: "Произошла ошибка", message: "Не удалось переключить фонарик. Попробуйте еще раз.")
        }
    }
    
    private func createCamera() -> () {
        guard let cameraLayer = self.camera.layer else { return }
        self.view.layer.addSublayer(cameraLayer)
        
        self.camera.start()
    }
    
    private func startInput() -> () {
        self.camera.start()
        
        UIView.animate(withDuration: 0.2) {
            self.blurEffectView.alpha = 0.0
        } completion: { _ in
            self.blurEffectView.isHidden = true
        }
    }
    
    public func startLoading() -> () {
        self.activityIndicator.startAnimating()
    }
    
    public func stopLoading() -> () {
        self.activityIndicator.stopAnimating()
    }
    
    public func stopInput() -> () {
        self.blurEffectView.isHidden = false
        
        UIView.animate(withDuration: 0.2) {
            self.blurEffectView.alpha = 1.0
        }
        
        self.camera.stop()
    }
    
    override public func viewDidLoad() -> () {
        super.viewDidLoad()
        
        self.createCamera()
        
        self.view.bringSubviewToFront(self.toggleFlashlightButton)
        self.view.bringSubviewToFront(self.blurEffectView)
    }
    
    override public func viewDidLayoutSubviews() -> () {
        super.viewDidLayoutSubviews()
        self.camera.frame = view.layer.bounds
    }
}

extension MainViewController: STCameraDelegate {
    
    public func scanned(barcode: String) -> () {
        self.presenter.product(for: barcode)
    }
    
}

extension MainViewController: STModalDelegate {
    
    public func modalDidDisappear() -> () {
        self.startInput()
    }
    
}
