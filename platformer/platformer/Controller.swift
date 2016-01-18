//
//  Controller.swift
//  Micronaut
//
//  Created by Christopher Williams on 1/16/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  Handles all the input from the user.

import Foundation
import SpriteKit

class Controller: NSObject {
    static private let speed = CGFloat(0.5)
    static private let jumpForce = CGFloat(150)
    
    static private var initialTouchPos = CGPointMake(0, 0) // Keep track of the relative positioning on the remote
    
    class func loadGestures(view: SKView) {
        // Tap = Jump
        let tapRecognizer = UITapGestureRecognizer(target: Controller.self, action: "jump:")
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)];
        view.addGestureRecognizer(tapRecognizer)
    }
    
    class func jump(gestureRecognizer: UIGestureRecognizer) {
        World.getPlayer().physicsBody?.applyImpulse(CGVectorMake(0, jumpForce))
    }
    
    class func touchBegan(pos: CGPoint) {
        initialTouchPos = pos
    }
    
    class func touchMoved(pos: CGPoint) {
        // Have the player move depending on where the touch has moved on the controller
        World.getPlayer().physicsBody?.velocity = CGVectorMake(speed * (pos - initialTouchPos).x, 0)
    }
}