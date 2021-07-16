//
//  PopupBuilder.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 03.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol PopupBuilderProtocol : class {
    func show(product : Product) -> ()
    func show(error : HTTPError) -> ()
    
    init(root : MainViewControllerProtocol)
}

final class PopupBuilder : PopupBuilderProtocol {
    
    private unowned var root : MainViewControllerProtocol
    
    public func show(product: Product) -> () {
        let popup = UINib(nibName: "ProductPopup", bundle: nil).instantiate(withOwner: root, options: nil)[0] as! ProductPopup
        popup.configure(barcode: product.barcode, classification: product.classification,
                        name: product.name, image: product.image)
        SwiftEntryKit.display(entry: popup, using: Attributes.bottom(disappearEvent: self.root.startInput))
    }
    
    public func show(error: HTTPError) -> () {
        let popup = UINib(nibName: "ErrorPopup", bundle: nil).instantiate(withOwner: root, options: nil)[0] as! ErrorPopup
        
        switch error {
            case .notFound:
                popup.configure(title: "Уупс!", description: "Похоже, что в базе данных не нашлось продуктов с подходящим штрихкодом.",
                                image: UIImage(systemName: "tray.and.arrow.up"))
            case .unexpected, .badRequest:
                popup.configure(title: "О нет!", description: "Произошла непредвиденная ошибка, мы уже занимаемся над её исправлением.",
                                image: UIImage(systemName: "barcode.viewfinder"))
            case .transportError(_):
                popup.configure(title: "Нет соединения!", description: "Похоже, что соединение пропало. Проверьте свое подключение к интернету.",
                                image: UIImage(systemName: "wifi.exclamationmark"))
        }
        
        SwiftEntryKit.display(entry: popup, using: Attributes.bottom(disappearEvent: self.root.startInput))
    }
    
    required init(root: MainViewControllerProtocol) {
        self.root = root
    }
}
