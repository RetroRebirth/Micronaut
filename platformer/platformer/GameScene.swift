//
//  GameScene.swift
//  Micronaut
//
//  Created by Christopher Williams on 10/18/15.
//  Copyright (c) 2015 Christopher Williams. All rights reserved.
//
//  The head hancho file that handles everything.

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self // Initialize collision engine
        
        Sound.initialize(self)
        World.initialize(self)
        Player.initialize(World.getSpriteByName(Constants.Node_Player))
        Controller.initialize(view)
    }

    override func update(currentTime: CFTimeInterval) {
        Utility.update(currentTime) // Handles time management. Reference necessary time from here
        Player.update()
        World.update()
    }
    
    override func didFinishUpdate() {
        Camera.didFinishUpdate()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Controller.touchBegan((touches.first?.locationInView(self.view))!)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Controller.touchMoved((touches.first?.locationInView(self.view))!)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Controller.touchEnded()
    }
    
    // The start of collision detections.
    // http://www.raywenderlich.com/119815/sprite-kit-swift-2-tutorial-for-beginners
    // Be sure to define the Category and Contact mask for each sprite http://stackoverflow.com/questions/19675967/didbegincontactskphysicscontact-contact-not-invoked
    func didBeginContact(contact: SKPhysicsContact) {
        let bodies = Utility.SortCollisionBodies(contact)
        
        Utility.didBeginContact(bodies.bodyA, bodyB: bodies.bodyB)
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        let bodies = Utility.SortCollisionBodies(contact)
        
        Utility.didEndContact(bodies.bodyA, bodyB: bodies.bodyB)
    }
}
