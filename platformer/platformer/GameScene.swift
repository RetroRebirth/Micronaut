//
//  GameScene.swift
//  platformer
//
//  Created by Christopher Williams on 10/18/15.
//  Copyright (c) 2015 Christopher Williams. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKSpriteNode(imageNamed:"Spaceship")
    let runningSpeed = CGFloat(500)
    
    override func didMoveToView(view: SKView) {
        // create physics engine
        physicsWorld.gravity = CGVectorMake(0, -10)
        
        // create floor
        let floor = SKShapeNode(rect: CGRectMake(0, size.height * 0.15, size.width, size.height * 0.1))
        floor.fillColor = SKColor.whiteColor()
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(size.width * 2, size.height * 0.5)) // TODO why isn't physics body wrapping node correctly? whatever, this works for now
        floor.physicsBody?.dynamic = false
        self.addChild(floor)
        
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
        player.physicsBody?.dynamic = true
        player.physicsBody?.friction = 0.0
        self.addChild(player)
    }
    
    // jump when tapped or swipe up
    func jump(gestureRecognizer: UIGestureRecognizer) {
        // stop the player from jumping too high if you mash the button
        if player.position.y < size.height * 0.4 {
            player.physicsBody?.applyImpulse(CGVectorMake(0, 200))
        }
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
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
