//
//  MainViewController.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 21/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftEntryKit

class MainViewController: UIViewController {
    
    let codeTypes = [AVMetadataObject.ObjectType.ean8,
                     AVMetadataObject.ObjectType.ean13]
    
    var captureSession = AVCaptureSession()
    var videoPreview : AVCaptureVideoPreviewLayer?
    
    var effectView = UIVisualEffectView(effect: nil)
    
    var barcodeRectangle : RectangleView!
    
    public func setBlurEffect() -> Void {
        let effect = UIBlurEffect(style: .regular)
        effectView = UIVisualEffectView(effect: effect)
        
        view.addSubview(effectView)
        effectView.frame = view.frame
    }
    
    public func unsetBlurEffect() -> Void {
        effectView.removeFromSuperview()
        captureSession.startRunning()
    }
    
    public func showProductPopup(scannedProduct product : Product) -> Void {
        DispatchQueue.main.async {
            let popup = UINib(nibName: "ProductPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ProductPopup
            
            var attributes = Attributes.popupConfiguration()
            
            attributes.lifecycleEvents.didDisappear = { self.unsetBlurEffect() }
            
            product.getProductImage() { (image) in popup.setProductImage(whereImage: image!) }
            product.getProductClass() { (classification) in popup.setProductClass(whereClass: classification!) }
            product.getProductName() { (name) in popup.setProductName(whereName: name!) }
            
            popup.layer.cornerRadius = 20
            
            SwiftEntryKit.display(entry: popup, using: attributes)
        }
    }
    
    public func showErrorPopup(errorCode error : Int) -> Void {
        DispatchQueue.main.async {
            let popup = UINib(nibName: "ErrorPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ErrorPopup
            var attributes = Attributes.popupConfiguration()
            
            attributes.lifecycleEvents.didDisappear = { self.unsetBlurEffect() }
            
            popup.layer.cornerRadius = 20
            
            popup.show(withError: error)
            SwiftEntryKit.display(entry: popup, using: attributes)
        }
    }
    
    public func changeViewController(barcode code : String!) -> Void {
        let scannedProduct = Product(barcode: code)
        
        scannedProduct.checkIfExist(){ (status) in
            if status == 200 {
                self.showProductPopup(scannedProduct: scannedProduct)
            } else {
                self.showErrorPopup(errorCode: status)
            }
        }
    }
    
    override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        // Берем в переменную записывающее устройство
        guard let capture_device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        
        do {
            // Добавляем инпут как инстанс класса AVCaptureDeviceInput полученного девайса
            let input = try AVCaptureDeviceInput(device: capture_device)
            captureSession.addInput(input)
            
            // Инициализируем оутпут, используя класс AVCaptureMetadataOutput и добавляем в нашу сессию
            let captureOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureOutput)
            
            // Инициализуем наш делегат для получения всех сигналов
            captureOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureOutput.metadataObjectTypes = codeTypes
            
        } catch { return }
        
        // Инициализируем слой с превью видео
        videoPreview = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreview?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreview?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreview!)
        
        // Запускаем сессию снятия
        captureSession.startRunning()
        
        // Рисуем область
        barcodeRectangle = RectangleView(frame: CGRect(x: view.center.x - 125,
                                                       y: view.center.y - 50,
                                                       width: 250,
                                                       height: 100))
        view.addSubview(barcodeRectangle)
        view.bringSubviewToFront(barcodeRectangle)
    }
}

extension MainViewController : AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) -> Void {
        
        if metadataObjects.count == 0 { return }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if codeTypes.contains(metadataObj.type) {
            if metadataObj.stringValue != nil {
                setBlurEffect()
                captureSession.stopRunning()
                changeViewController(barcode: metadataObj.stringValue)
            }
        }
    }
}
