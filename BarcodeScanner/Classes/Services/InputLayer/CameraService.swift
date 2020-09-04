//
//  CameraService.swift
//  BarcodeMVP
//
//  Created by onl1ner onl1ner on 02.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import AVFoundation

enum FlashlightStatus {
    case off
    case on
    
    case notFound
    case notInitialized
}

protocol CameraServiceProtocol : class {
    var cameraLayer : AVCaptureVideoPreviewLayer? { get }
    var frame : CGRect { get set }
    
    func stop() -> ()
    func start() -> ()
    
    func toggleFlashlight() -> FlashlightStatus
    
    init(frame : CGRect, at view : CameraControllerProtocol)
}

final class CameraService : NSObject, CameraServiceProtocol {
    
    private let codeTypes: [AVMetadataObject.ObjectType] = [.ean8, .ean13]
    
    private var captureSession : AVCaptureSession = .init()
    
    private weak var view : CameraControllerProtocol?
    
    public var cameraLayer : AVCaptureVideoPreviewLayer?
    
    public var frame: CGRect {
        didSet {
            cameraLayer?.frame = frame
        }
    }
    
    private func create(frame : CGRect) -> () {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            // Добавляем инпут как инстанс класса AVCaptureDeviceInput полученного девайса
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            
            // Инициализируем оутпут, используя класс AVCaptureMetadataOutput и добавляем в нашу сессию
            let captureOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureOutput)
            
            // Инициализуем наш делегат для получения всех сигналов
            captureOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureOutput.metadataObjectTypes = codeTypes
            
        } catch { return }
        
        // Инициализируем слой с превью видео
        cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraLayer!.frame = frame
    }
    
    public func stop() -> () { captureSession.stopRunning() }
    
    public func start() -> () { captureSession.startRunning() }
    
    func toggleFlashlight() -> FlashlightStatus {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return .notInitialized }
        
        if captureDevice.hasTorch {
            do {
                try captureDevice.lockForConfiguration()
                captureDevice.torchMode = captureDevice.torchMode == .off ? .on : .off
                captureDevice.unlockForConfiguration()
                
                return captureDevice.torchMode == .off ? .off : .on
            } catch let error {
                print("Cannot toggle flashlight: \(error.localizedDescription)")
                return .notInitialized
            }
        } else { return .notFound }
    }
    
    init(frame: CGRect, at view : CameraControllerProtocol) {
        self.view = view
        self.frame = frame
        
        super.init()
        
        create(frame: frame)
    }
}

extension CameraService : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        if metadataObjects.isEmpty { return }
        
        guard let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }
        
        if codeTypes.contains(metadataObj.type) {
            if let barcode = metadataObj.stringValue {
                self.view?.output(output: barcode)
            }
        }
    }
}
