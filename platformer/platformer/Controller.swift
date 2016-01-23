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
    static private let jumpForce = CGFloat(200)
    
    // Keep track of the relative positioning on the remote
    static private var initialTouchPos = CGPointMake(0, 0)
    static private var currentTouchPos = CGPointMake(0, 0)
    
    class func loadGestures(view: SKView) {
        // Tap = Jump
        let tapRecognizer = UITapGestureRecognizer(target: Controller.self, action: "jump:")
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)];
        view.addGestureRecognizer(tapRecognizer)
    }
    
    class func jump(gestureRecognizer: UIGestureRecognizer) {
        if World.getPlayer().physicsBody?.velocity.dy == 0.0 {
            World.getPlayer().physicsBody?.applyImpulse(CGVectorMake(0, jumpForce))
        }
    }
    
    class func touchBegan(pos: CGPoint) {
        initialTouchPos = pos
        currentTouchPos = pos
    }

    class func touchMoved(pos: CGPoint) {
        currentTouchPos = pos
    }
    
    class func touchEnded() {
        initialTouchPos = CGPointMake(0, 0)
        currentTouchPos = CGPointMake(0, 0)
    }
    
    // Have the player move depending on where the touch has moved on the controller
    class func update() {
        // This allows the player to slide
        if (initialTouchPos.x != 0.0 && currentTouchPos.x != 0.0) {
            World.getPlayer().physicsBody?.velocity.dx = speed * (currentTouchPos - initialTouchPos).x
        }
    }
}