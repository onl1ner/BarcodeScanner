//
//  Attributes.swift
//  BarcodeScanner
//
//  Created by onl1ner onl1ner on 03.09.2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import SwiftEntryKit

final class Attributes {
    /// Атрибуты для конфигурации попапа с отображением снизу.
    public static func bottom(disappearEvent : (() -> ())?) -> EKAttributes {
        var attributes = EKAttributes()
        
        let popupWidth = EKAttributes.PositionConstraints.Edge.ratio(value: 0.9)
        let popupHeight = EKAttributes.PositionConstraints.Edge.constant(value: 300.0)
        
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
        
        attributes.lifecycleEvents.didDisappear = disappearEvent
        
        return attributes
    }
}
