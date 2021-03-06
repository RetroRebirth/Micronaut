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
    static var debug = false
    // Keep track of the relative positioning on the remote
    static private var initialTouchPos = CGPointMake(0, 0)
    static private var currentTouchPos = CGPointMake(0, 0)
    
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
        // Pressed play/pause button
        let playRecognizer = UITapGestureRecognizer(target: Controller.self, action: #selector(Controller.play(_:)))
        playRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.PlayPause.rawValue)];
        view.addGestureRecognizer(playRecognizer)
    }
    
    class func play(gestureRecognizer: UIGestureRecognizer) {
        // Toggle debug controls
        Controller.debug = !Controller.debug
        Player.clearVelocity()
        Player.node?.physicsBody?.affectedByGravity = !Controller.debug
    }
    
    class func tapped(gestureRecognizer: UIGestureRecognizer) {
        if Controller.debug {
            Player.warp()
        } else {
            Player.setShrink(Player.isBig())
        }
    }
    
    class func swipedUp(gestureRecognizer: UIGestureRecognizer) {
        if Controller.debug {
            Player.clearVelocity()
            Player.setVelocityY(Constants.PlayerSpeed, force: true)
        } else {
            Player.jump()
        }
    }
    
    class func swipedDown(gestureRecognizer: UIGestureRecognizer) {
        if Controller.debug {
            Player.clearVelocity()
            Player.setVelocityY(-Constants.PlayerSpeed, force: true)
        } else {
            Player.setVelocityX(0.0, force: false)
        }
    }

    class func swipedRight(gestureRecognizer: UIGestureRecognizer) {
        if debug {
            Player.clearVelocity()
        }
        Player.setVelocityX(Constants.PlayerSpeed, force: false)
    }
    
    class func swipedLeft(gestureRecognizer: UIGestureRecognizer) {
        if debug {
            Player.clearVelocity()
        }
        Player.setVelocityX(-Constants.PlayerSpeed, force: false)
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