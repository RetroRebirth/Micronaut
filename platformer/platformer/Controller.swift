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

class Controller {
    static private let speed = CGFloat(200)
    
    class func loadControls(view: SKView) {
        // Tap = Jump
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "jump:")
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)];
        view.addGestureRecognizer(tapRecognizer)
        
        // Swipe Up = Jump
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: "jump:")
        swipeUpRecognizer.direction = .Up
        view.addGestureRecognizer(swipeUpRecognizer)
        
        // Swipe Right = Run Right
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: "runRight:")
        swipeRightRecognizer.direction = .Right
        view.addGestureRecognizer(swipeRightRecognizer)
        
        // Swipe Left = Run Left
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: "runLeft:")
        swipeLeftRecognizer.direction = .Left
        view.addGestureRecognizer(swipeLeftRecognizer)
        
        // Swipe Down = Stop Moving
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: "stopRunning:")
        swipeDownRecognizer.direction = .Down
        view.addGestureRecognizer(swipeDownRecognizer)
    }
    
    class private func jump(gestureRecognizer: UIGestureRecognizer) {
        World.getPlayer().physicsBody?.applyImpulse(CGVectorMake(0, speed))
    }
    
    class private func runRight(gestureRecognizer: UIGestureRecognizer) {
        World.getPlayer().physicsBody?.velocity = CGVectorMake(speed, 0)
        // TODO paralax motion with background
    }
    
    class private func runLeft(gestureRecognizer: UIGestureRecognizer) {
        World.getPlayer().physicsBody?.velocity = CGVectorMake(-speed, 0)
        // TODO paralax motion with background
    }
    
    class private func stopRunning(gestureRecognizer: UIGestureRecognizer) {
        World.getPlayer().physicsBody?.velocity = CGVectorMake(0, 0)
    }
}