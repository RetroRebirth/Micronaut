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
        World.loadSprites(self)
        Controller.loadGestures(view)
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // TODO abstract death logic to new class
        // If the player fell, bring them back to start
        if World.getPlayer().position.y < 0.0 {
            World.getPlayer().position = CGPointMake(128, 768)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Controller.touchBegan((touches.first?.locationInView(self.view))!)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Controller.touchMoved((touches.first?.locationInView(self.view))!)
    }
}
