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
        Camera.loadCamera(self)
        Controller.loadGestures(view)
    }

    override func update(currentTime: CFTimeInterval) {
        Controller.update()
        World.update()
    }
    
    override func didFinishUpdate() {
        Camera.didFinishUpdate()
        World.didFinishUpdate()
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
}
