//
//  GameScene.swift
//  platformer
//
//  Created by Christopher Williams on 10/18/15.
//  Copyright (c) 2015 Christopher Williams. All rights reserved.
//

import SpriteKit

//struct PhysicsCategory {
//    static let None     : UInt32 = 0
//    static let All      : UInt32 = UInt32.max
//    static let Player   : UInt32 = 0b1
//    static let World    : UInt32 = 0b110
//    static let Ground   : UInt32 = 0b10
//    static let Wall     : UInt32 = 0b100
//}

// CGVector operation overloading (http://www.raywenderlich.com/80818/operator-overloading-in-swift-tutorial)
func + (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}
func - (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    // Sprites
    var player: SKNode?
    
    // Mechanisms
    let runningSpeed = CGFloat(200)
    var jumpVector = CGVectorMake(0, 200)
    
    override func didMoveToView(view: SKView) {
        loadSprites()
        loadControls(view)
    }
    
    func loadSprites() {
        player = self.childNodeWithName("player")!
    }
    
    func loadControls(view: SKView) {
        // add tap recogizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "jump:")
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)];
        view.addGestureRecognizer(tapRecognizer)
        
        // add swipe up recogizer
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: "jump:")
        swipeUpRecognizer.direction = .Up
        view.addGestureRecognizer(swipeUpRecognizer)
        
        // add swipe right recogizer
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: "runRight:")
        swipeRightRecognizer.direction = .Right
        view.addGestureRecognizer(swipeRightRecognizer)
        
        // add swipe left recogizer
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: "runLeft:")
        swipeLeftRecognizer.direction = .Left
        view.addGestureRecognizer(swipeLeftRecognizer)
        
        // add swipe down recogizer
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: "stopRunning:")
        swipeDownRecognizer.direction = .Down
        view.addGestureRecognizer(swipeDownRecognizer)
    }
    
    func jump(gestureRecognizer: UIGestureRecognizer) {
        player!.physicsBody?.applyImpulse(jumpVector)
    }
    
    func runRight(gestureRecognizer: UIGestureRecognizer) {
        player!.physicsBody?.velocity = CGVectorMake(runningSpeed, 0)
        // TODO paralax motion with background
    }
    
    func runLeft(gestureRecognizer: UIGestureRecognizer) {
        player!.physicsBody?.velocity = CGVectorMake(-runningSpeed, 0)
        // TODO paralax motion with background
    }
    
    func stopRunning(gestureRecognizer: UIGestureRecognizer) {
        player!.physicsBody?.velocity = CGVectorMake(0, 0)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
//        // Sort physics bodies by category bit
//        var firstBody: SKPhysicsBody
//        var secondBody: SKPhysicsBody
//        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
//            firstBody = contact.bodyA
//            secondBody = contact.bodyB
//        } else {
//            firstBody = contact.bodyB
//            secondBody = contact.bodyA
//        }
//        
//        // Player can jump off wall and ground
//        if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
//            (secondBody.categoryBitMask & PhysicsCategory.Ground != 0)) {
//                jumpVector = CGVector.zero
//                jumpVector.dy = 200
//        }
//        if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
//            (secondBody.categoryBitMask & PhysicsCategory.Wall != 0)) {
//                jumpVector.dx = 100 * contact.contactNormal.dx
//                jumpVector.dy = 200
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // TODO Keep camera focused on player
        self.position = player!.position
    }
}
