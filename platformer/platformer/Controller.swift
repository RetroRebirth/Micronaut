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
        // Only jump when the player is standing on ground
        if World.getSpriteByName(Constants.Sprite_Player).physicsBody?.velocity.dy == 0.0 {
            World.getSpriteByName(Constants.Sprite_Player).physicsBody?.applyImpulse(CGVectorMake(0, Constants.PlayerJumpForce))
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
    
    // Gets called with every frame.
    class func update() {
        // Don't update the player's velocity unless we are influencing it
        if (initialTouchPos.x != 0.0 && currentTouchPos.x != 0.0) {
            World.getSpriteByName(Constants.Sprite_Player).physicsBody?.velocity.dx = calcNewPlayerVelocityDx()
        }
    }
    
    // Calculates the distance the user has moved their input along the X axis
    class func getTouchMagnitudeX() -> CGFloat {
        return (currentTouchPos - initialTouchPos).x
    }
    
    class func calcNewPlayerVelocityDx() -> CGFloat {
        return Constants.PlayerSpeed * getTouchMagnitudeX()
    }
}