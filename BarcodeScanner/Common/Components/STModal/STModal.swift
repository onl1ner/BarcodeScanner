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

protocol STModalDelegate {
    func modalDidDisappear() -> ()
}

final class STModal {
    
    public private(set) var view: UIViewController
    public private(set) var attributes: EKAttributes
    
    private var delegate: STModalDelegate?
    
    private func setDefaultAttributes() -> () {
        self.attributes.screenBackground = .color(color: .black.with(alpha: 0.25))
        self.attributes.displayDuration = .infinity
        
        self.attributes.entryInteraction = .absorbTouches
        self.attributes.screenInteraction = .dismiss
        
        self.attributes.lifecycleEvents.didDisappear = self.delegate?.modalDidDisappear
    }
    
    public func set(position: EKAttributes.Position) -> Self {
        self.attributes.position = position
        return self
    }
    
    public func set(verticalOffset: CGFloat) -> Self {
        self.attributes.positionConstraints.verticalOffset = verticalOffset
        return self
    }
    
    public func set(width: EKAttributes.PositionConstraints.Edge) -> Self {
        self.attributes.positionConstraints.size.width = width
        return self
    }
    
    public func set(height: EKAttributes.PositionConstraints.Edge) -> Self {
        self.attributes.positionConstraints.size.height = height
        return self
    }
    
    public init(view: UIViewController, delegate: STModalDelegate? = nil) {
        self.view = view
        self.attributes = .init()
        
        self.delegate = delegate
        
        self.setDefaultAttributes()
    }
    
}
