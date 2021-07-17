//
//  ViewController.swift
//  BarcodeMVP
//
//  Created by onl1ner onl1ner on 01.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol MainViewControllerProtocol : AnyObject {
    func show(product : Product) -> ()
    func show(error : HTTPError) -> ()
    
    func startInput() -> ()
}

class MainViewController: UIViewController, MainViewControllerProtocol {
    
    @IBOutlet private weak var toggleFlashlightButton: UIButton!
    
    @IBOutlet private weak var blurEffectView: UIVisualEffectView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var camera = Camera(frame: view.layer.bounds, delegate: self.presenter)
    
    public var presenter : MainPresenterProtocol!
    
    public var popupBuilder : PopupBuilderProtocol?
    
    @IBAction func toggleFlashlight(_ sender: UIButton) -> () {
        let status = camera.toggleFlashlight()
        
        switch status {
            case .on: sender.setImage(UIImage(systemName: "bolt.slash.fill"), for: .normal)
            case .off: sender.setImage(UIImage(systemName: "bolt.fill"), for: .normal)
            case .notFound: self.showAlert(title: "Произошла ошибка", message: "Похоже, что на вашем устройстве нет фонарика.")
            case .notInitialized: self.showAlert(title: "Произошла ошибка", message: "Не удалось переключить фонарик. Попробуйте еще раз.")
        }
    }
    
    private func createCamera() -> () {
        guard let cameraLayer = camera.layer else { return }
        self.view.layer.addSublayer(cameraLayer)
    }
    
    public func show(product: Product) -> () {
        self.activityIndicator.stopAnimating()
        
        popupBuilder?.show(product: product)
    }
    
    public func show(error: HTTPError) -> () {
        self.activityIndicator.stopAnimating()
        
        popupBuilder?.show(error: error)
    }
    
    public func startInput() -> () {
        camera.start()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.blurEffectView.alpha = 0.0
        }, completion: { _ in self.blurEffectView.isHidden = true })
    }
    
    public func output(output: String) {
        self.blurEffectView.isHidden = false
        self.activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.2) {
            self.blurEffectView.alpha = 1.0
        }
        
        camera.stop()
    }
    
    override func viewDidLoad() -> () {
        super.viewDidLoad()
        
        createCamera()
        camera.start()
        
        self.view.bringSubviewToFront(toggleFlashlightButton)
        self.view.bringSubviewToFront(blurEffectView)
    }
    
    override func viewDidLayoutSubviews() -> () {
        super.viewDidLayoutSubviews()
        camera.frame = view.layer.bounds
    }
}
