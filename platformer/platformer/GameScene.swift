//
//  GameScene.swift
//  platformer
//
//  Created by Christopher Williams on 10/18/15.
//  Copyright (c) 2015 Christopher Williams. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        // title at top middle
        let title = SKLabelNode(fontNamed:"Chalkduster")
        title.text = "Platformer"
        title.fontSize = 65
        title.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - 150)
        self.addChild(title)
        
        // player at middle-bottom of screen
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        sprite.xScale = 0.2
        sprite.yScale = 0.2
        sprite.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMinY(self.frame) + 150)
        self.addChild(sprite)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // TODO make ship jump
//        
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
