//
//  ViewController.swift
//  BarcodeMVP
//
//  Created by onl1ner onl1ner on 01.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol MainViewControllerProtocol: AnyObject {
    func startInput() -> ()
    func stopInput() -> ()
}

final class MainViewController: UIViewController, MainViewControllerProtocol {
    
    @IBOutlet private weak var toggleFlashlightButton : UIButton!
    
    @IBOutlet private weak var blurEffectView : UIVisualEffectView!
    @IBOutlet private weak var activityIndicator : UIActivityIndicatorView!
    
    private lazy var camera : CameraProtocol = Camera(frame: self.view.layer.bounds, delegate: self)
    
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
    
    public func startInput() -> () {
        self.camera.start()
        
        UIView.animate(withDuration: 0.2) {
            self.blurEffectView.alpha = 0.0
        } completion: { _ in
            self.blurEffectView.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    public func stopInput() -> () {
        self.activityIndicator.startAnimating()
        
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

extension MainViewController: CameraDelegate {
    
    public func scanned(barcode: String) -> () {
        self.presenter.product(for: barcode)
    }
    
}
