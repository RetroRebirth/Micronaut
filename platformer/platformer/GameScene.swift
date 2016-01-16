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
        Controller.loadControls(view)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
