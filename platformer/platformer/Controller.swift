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
    
    // Gets called with every frame.
//    class func update() {
//        // Don't update the player's velocity unless we are influencing it
//        if (initialTouchPos.x != 0.0 && currentTouchPos.x != 0.0) {
//            Player.setVelocityX(Controller.calcNewPlayerVelocityDx())
//        }
//    }
    
    class func initialize(view: SKView) {
        loadGestures(view)
    }
    
    class func loadGestures(view: SKView) {
        // Tap
        let tapRecognizer = UITapGestureRecognizer(target: Controller.self, action: #selector(Controller.tapped(_:)))
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)];
        view.addGestureRecognizer(tapRecognizer)
        // Swipe Up
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: Controller.self, action: #selector(Controller.swipedUp(_:)))
        swipeUpRecognizer.direction = .Up
        view.addGestureRecognizer(swipeUpRecognizer)
        // Swipe Down
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: Controller.self, action: #selector(Controller.swipedDown(_:)))
        swipeDownRecognizer.direction = .Down
        view.addGestureRecognizer(swipeDownRecognizer)
        // Swipe Right
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: Controller.self, action: #selector(Controller.swipedRight(_:)))
        swipeRightRecognizer.direction = .Right
        view.addGestureRecognizer(swipeRightRecognizer)
        // Swipe Left
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: Controller.self, action: #selector(Controller.swipedLeft(_:)))
        swipeLeftRecognizer.direction = .Left
        view.addGestureRecognizer(swipeLeftRecognizer)
    }
    
    class func tapped(gestureRecognizer: UIGestureRecognizer) {
        Player.toggleShrink()
    }
    
    class func swipedUp(gestureRecognizer: UIGestureRecognizer) {
        Player.jump()
    }
    
    class func swipedDown(gestureRecognizer: UIGestureRecognizer) {
        Player.setVelocityX(0.0)
    }

    class func swipedRight(gestureRecognizer: UIGestureRecognizer) {
        Player.setVelocityX(Constants.PlayerSpeed)
    }
    
    class func swipedLeft(gestureRecognizer: UIGestureRecognizer) {
        Player.setVelocityX(-Constants.PlayerSpeed)
    }
    
    class func touchBegan(pos: CGPoint) {
        initialTouchPos = pos
        currentTouchPos = pos
    }

    class func touchMoved(pos: CGPoint) {
        currentTouchPos = pos
    }
    
    class func touchEnded() {
//        initialTouchPos = CGPointMake(0, 0)
//        currentTouchPos = CGPointMake(0, 0)
    }
    
    // Calculates the distance the user has moved their input along the X axis
    class func getTouchMagnitudeX() -> CGFloat {
        return (currentTouchPos - initialTouchPos).x
    }
    
//    class func calcNewPlayerVelocityDx() -> CGFloat {
//        return Constants.PlayerSpeed * Controller.getTouchMagnitudeX()
//    }
}