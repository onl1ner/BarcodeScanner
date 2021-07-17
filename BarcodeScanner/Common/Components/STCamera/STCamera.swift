//
//  CameraService.swift
//  BarcodeMVP
//
//  Created by onl1ner onl1ner on 02.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import AVFoundation

protocol STCameraDelegate {
    func scanned(barcode : String) -> ()
}

protocol STCameraProtocol : AnyObject {
    var layer : AVCaptureVideoPreviewLayer? { get }
    var frame : CGRect { get set }
    
    func start() -> ()
    func stop() -> ()
    
    func toggleFlashlight() -> FlashlightStatus
    
    init(frame : CGRect, delegate : STCameraDelegate?)
}

final class STCamera : NSObject, STCameraProtocol {
    
    private let codeTypes: [AVMetadataObject.ObjectType] = [.ean8, .ean13]
    
    private var captureSession : AVCaptureSession = .init()
    private var delegate : STCameraDelegate?
    
    private var scanArea : RectangleView = .init(frame: .init(x: 0, y: 0, width: 250.0, height: 100.0))
    
    public var layer : AVCaptureVideoPreviewLayer?
    
    public var frame : CGRect {
        didSet {
            self.layer?.frame = self.frame
            self.scanArea.center = self.center
        }
    }
    
    public var center : CGPoint {
        return .init(x: self.frame.width / 2, y: self.frame.height / 2)
    }
    
    private func configure() -> () {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            // Добавляем инпут как инстанс класса AVCaptureDeviceInput полученного девайса
            let input = try AVCaptureDeviceInput(device: captureDevice)
            self.captureSession.addInput(input)
            
            // Инициализируем оутпут, используя класс AVCaptureMetadataOutput и добавляем в нашу сессию
            let captureOutput = AVCaptureMetadataOutput()
            self.captureSession.addOutput(captureOutput)
            
            // Инициализуем наш делегат для получения всех сигналов
            captureOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureOutput.metadataObjectTypes = self.codeTypes
            
        } catch { return }
        
        // Инициализируем слой с превью видео
        self.layer = .init(session: self.captureSession)
        
        self.layer?.videoGravity = .resizeAspectFill
        self.layer?.frame = self.frame
        
        self.layer?.addSublayer(self.scanArea.layer)
    }
    
    public func stop() -> () {
        self.captureSession.stopRunning()
    }
    
    public func start() -> () {
        self.captureSession.startRunning()
    }
    
    public func toggleFlashlight() -> FlashlightStatus {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return .notInitialized }
        
        if captureDevice.hasTorch {
            do {
                try captureDevice.lockForConfiguration()
                captureDevice.torchMode = captureDevice.torchMode == .off ? .on : .off
                captureDevice.unlockForConfiguration()
                
                return captureDevice.torchMode == .on ? .on : .off
            } catch let error {
                print("Cannot toggle flashlight: \(error.localizedDescription)")
                return .notInitialized
            }
        } else { return .notFound }
    }
    
    init(frame : CGRect, delegate : STCameraDelegate?) {
        self.frame = frame
        self.delegate = delegate
        
        super.init()
        
        self.configure()
    }
}

extension STCamera : AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) -> () {
        
        guard !metadataObjects.isEmpty,
              let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject
        else { return }
        
        if self.codeTypes.contains(metadataObj.type) {
            if let barcode = metadataObj.stringValue {
                self.delegate?.scanned(barcode: barcode)
            }
        }
        
    }
}
