//
//  GameScene.swift
//  platformer
//
//  Created by Christopher Williams on 10/18/15.
//  Copyright (c) 2015 Christopher Williams. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None     : UInt32 = 0
    static let All      : UInt32 = UInt32.max
    static let Player   : UInt32 = 0b1
    static let World    : UInt32 = 0b110
    static let Ground   : UInt32 = 0b10
    static let Wall     : UInt32 = 0b100
}

// CGVector operation overloading (http://www.raywenderlich.com/80818/operator-overloading-in-swift-tutorial)
func + (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}
func - (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKSpriteNode(imageNamed:"Spaceship")
    let runningSpeed = CGFloat(400)
    var jumpVector = CGVector.zero
    
    override func didMoveToView(view: SKView) {
        // create physics engine
        physicsWorld.gravity = CGVectorMake(0, -10)
        physicsWorld.contactDelegate = self
        
        // create title @ top-middle
        let title = SKLabelNode(fontNamed:"Chalkduster")
        title.text = "Platformer"
        title.fontSize = 65
        title.position = CGPoint(x:size.width * 0.5, y:size.height * 0.8)
        self.addChild(title)
        
        // create player falls with gravity @ bottom-middle
        player.xScale = 0.2
        player.yScale = 0.2
        player.position = CGPoint(x:size.width * 0.5, y:size.height * 0.8)
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.categoryBitMask = PhysicsCategory.Player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.All
        player.physicsBody?.dynamic = true
        player.physicsBody?.friction = 0.0
        player.physicsBody?.restitution = 0.0
        self.addChild(player)
        
        // create floor
        let ground = SKShapeNode(rect: CGRectMake(0, size.height * 0.15, size.width, size.height * 0.1))
        ground.fillColor = SKColor.whiteColor()
        ground.physicsBody = SKPhysicsBody(edgeFromPoint: CGPointMake(0, size.height * 0.25), toPoint: CGPointMake(size.width, size.height * 0.25))
        ground.physicsBody?.categoryBitMask = PhysicsCategory.Ground
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.restitution = 0.0
        self.addChild(ground)
        
        // create left wall
        let leftWall = SKShapeNode(rect: CGRectMake(0, size.height * 0.15, size.width * 0.05, size.height))
        leftWall.fillColor = SKColor.whiteColor()
        leftWall.physicsBody = SKPhysicsBody(edgeFromPoint: CGPointMake(size.width * 0.05, size.height * 0.25), toPoint: CGPointMake(size.width * 0.05, size.height))
        leftWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        leftWall.physicsBody?.dynamic = false
        leftWall.physicsBody?.restitution = 0.0
        self.addChild(leftWall)
        
        // create right wall
        let rightWall = SKShapeNode(rect: CGRectMake(size.width * 0.95, size.height * 0.15, size.width * 0.05, size.height))
        rightWall.fillColor = SKColor.whiteColor()
        rightWall.physicsBody = SKPhysicsBody(edgeFromPoint: CGPointMake(size.width * 0.95, size.height * 0.25), toPoint: CGPointMake(size.width * 0.95, size.height))
        rightWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        rightWall.physicsBody?.dynamic = false
        rightWall.physicsBody?.restitution = 0.0
        self.addChild(rightWall)
        
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
    
    // jump when tapped or swipe up
    func jump(gestureRecognizer: UIGestureRecognizer) {
        print("jumping vector: " + String(jumpVector))
        player.physicsBody?.applyImpulse(jumpVector)
        jumpVector = CGVector.zero
    }
    
    // run right constantly when swiped right
    func runRight(gestureRecognizer: UIGestureRecognizer) {
        player.physicsBody?.velocity = CGVectorMake(runningSpeed, 0)
    }
    
    // run left constantly when swiped right
    func runLeft(gestureRecognizer: UIGestureRecognizer) {
        player.physicsBody?.velocity = CGVectorMake(-runningSpeed, 0)
    }
    
    // stop running when swiped down
    func stopRunning(gestureRecognizer: UIGestureRecognizer) {
        player.physicsBody?.velocity = CGVectorMake(0, 0)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        // Sort physics bodies by category bit
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // Player can jump off wall and ground
        if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Ground != 0)) {
                jumpVector = CGVector.zero
                jumpVector.dy = 200
        }
        if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Wall != 0)) {
                jumpVector.dx = 100 * contact.contactNormal.dx
                jumpVector.dy = 200
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
