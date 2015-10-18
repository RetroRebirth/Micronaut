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
        sprite.name = "player"
        sprite.xScale = 0.2
        sprite.yScale = 0.2
        sprite.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMinY(self.frame) + 150)
        self.addChild(sprite)
        
        // add tap recogizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tapped:")
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)];
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func tapped(gestureRecognizer: UIGestureRecognizer) {
        // make ship jump when tapped
        let sprite = self.childNodeWithName("player")!
        
        // create jump animation
        let height = CGFloat(200)
        let duration = 1.0
        let rise = SKAction.moveByX(0, y: height, duration: duration/2)
        let fall = SKAction.moveByX(0, y: -height, duration: duration/2)
        let jump = SKAction.sequence([rise, fall])
        
        sprite.runAction(jump)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
