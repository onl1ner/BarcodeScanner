//
//  STModal.swift
//  BarcodeScanner
//
//  Created by Tamerlan Satualdypov on 17.07.2021.
//  Copyright © 2021 onl1ner onl1ner. All rights reserved.
//

import UIKit
import SwiftEntryKit

final class STModal {
    
    public private(set) var view : UIViewController
    public private(set) var attributes : EKAttributes
    
    private func setDefaultAttributes() -> () {
        self.attributes.screenBackground = .color(color: EKColor.black.with(alpha: 0.25))
        self.attributes.displayDuration = .infinity
        
        self.attributes.entryInteraction = .absorbTouches
        self.attributes.screenInteraction = .dismiss
        
        let offset = EKAttributes.PositionConstraints.KeyboardRelation.Offset(bottom: 20, screenEdgeResistance: 0)
        let keyboardRelation = EKAttributes.PositionConstraints.KeyboardRelation.bind(offset: offset)
        
        self.attributes.positionConstraints.keyboardRelation = keyboardRelation
    }
    
    public func set(position : EKAttributes.Position) -> Self {
        self.attributes.position = position
        return self
    }
    
    public func set(verticalOffset : CGFloat) -> Self {
        self.attributes.positionConstraints.verticalOffset = verticalOffset
        return self
    }
    
    public func set(width : EKAttributes.PositionConstraints.Edge) -> Self {
        self.attributes.positionConstraints.size.width = width
        return self
    }
    
    public func set(height : EKAttributes.PositionConstraints.Edge) -> Self {
        self.attributes.positionConstraints.size.height = height
        return self
    }
    
    public init(view : UIViewController) {
        self.view = view
        self.attributes = .init()
        
        self.setDefaultAttributes()
    }
    
}
