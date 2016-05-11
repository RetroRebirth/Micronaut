//
//  Boss.swift
//  Micronaut
//
//  Created by Christopher Williams on 5/10/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  Handles the game logic in association with the boss.

import Foundation
import SpriteKit

class Boss: AnimatedSprite {
    
    override class func loadSprites() {
        super.loadSprites()
        
        loadSprite(Constants.Sprite_BossAppear, frames: 4)
        loadSprite(Constants.Sprite_BossWalk, frames: 6)
        loadSprite(Constants.Sprite_BossAppear, frames: 4)
    }
    
    class func update() {
        
    }
    
    class func reset() {
        node!.position = Constants.BossStartPos
        node!.physicsBody?.velocity = CGVectorMake(0.0, 0.0)
        
        (node as! SKSpriteNode).texture = SKTexture(imageNamed: "bossAppear_00")
    }
}