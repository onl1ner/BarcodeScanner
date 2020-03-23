//
//  Config.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 22/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import Foundation
import SwiftEntryKit

struct BarcodeDataBase {
    public static let url = "http://barcodes.olegon.ru/api/card"
}

struct GoogleSearch {
    public static let apiKey = "AIzaSyBoqHyHDVZugSUI6fan-fqnbl_ieR01yNs"
    public static let engineKey = "007337280464247857418:hgpmffeg34k"
}

struct Attributes {
    public static func popupConfiguration() -> EKAttributes {
        var attributes = EKAttributes()
        
        let popupWidth = EKAttributes.PositionConstraints.Edge.ratio(value: 0.95)
        let popupHeight = EKAttributes.PositionConstraints.Edge.ratio(value: 0.35)
        
        /// - Анимация
        attributes.entranceAnimation.translate?.duration = 0.1
        attributes.exitAnimation.translate?.duration = 0.1
        
        /// - Время показа
        attributes.displayDuration = .infinity
        
        /// - Расположение
        attributes.position = .bottom
        attributes.positionConstraints.size = .init(width: popupWidth, height: popupHeight)
        attributes.positionConstraints.verticalOffset = 5
        
        /// - Затемнение бэкграунда
        attributes.screenBackground = .color(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)))
        
        /// - Пользовательский ввод
        attributes.entryInteraction = .forward
        attributes.screenInteraction = .dismiss
        
        return attributes
    }
}
