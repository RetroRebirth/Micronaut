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
    static private let speed = CGFloat(200)
    
    class func loadControls(view: SKView) {
        // Tap = Jump
        let tapRecognizer = UITapGestureRecognizer(target: Controller.self, action: "jump:")
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)];
        view.addGestureRecognizer(tapRecognizer)
        
        // Swipe Up = Jump
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: Controller.self, action: "jump:")
        swipeUpRecognizer.direction = .Up
        view.addGestureRecognizer(swipeUpRecognizer)
        
        // Swipe Right = Run Right
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: Controller.self, action: "runRight:")
        swipeRightRecognizer.direction = .Right
        view.addGestureRecognizer(swipeRightRecognizer)
        
        // Swipe Left = Run Left
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: Controller.self, action: "runLeft:")
        swipeLeftRecognizer.direction = .Left
        view.addGestureRecognizer(swipeLeftRecognizer)
        
        // Swipe Down = Stop Moving
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: Controller.self, action: "stopRunning:")
        swipeDownRecognizer.direction = .Down
        view.addGestureRecognizer(swipeDownRecognizer)
    }
    
    class func jump(gestureRecognizer: UIGestureRecognizer) {
        print("jump began!")
        World.getPlayer().physicsBody?.applyImpulse(CGVectorMake(0, speed))
        print("jump ended")
    }
    
    class func runRight(gestureRecognizer: UIGestureRecognizer) {
        World.getPlayer().physicsBody?.velocity = CGVectorMake(speed, 0)
        // TODO paralax motion with background
    }
    
    class func runLeft(gestureRecognizer: UIGestureRecognizer) {
        World.getPlayer().physicsBody?.velocity = CGVectorMake(-speed, 0)
        // TODO paralax motion with background
    }
    
    class func stopRunning(gestureRecognizer: UIGestureRecognizer) {
        World.getPlayer().physicsBody?.velocity = CGVectorMake(0, 0)
    }
}