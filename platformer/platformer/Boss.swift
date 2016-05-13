//
//  Boss.swift
//  Micronaut
//
//  Created by Christopher Williams on 5/10/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  Handles the game logic in association with the boss. Follows model of Player but doesn't use same class.

import Foundation
import SpriteKit

class Boss {
    static var sprites:[String:[SKTexture]] = [String:[SKTexture]]()
    static var node:SKNode?
    static var awake:Bool = false
    
    class func initialize(node: SKNode) {
        Boss.loadSprite(Constants.Sprite_BossAppear, frames: 4)
        Boss.loadSprite(Constants.Sprite_BossWalk, frames: 6)
        Boss.loadSprite(Constants.Sprite_BossRetreat, frames: 4)
        
        self.node = node
    }
    
    // This only works when there are less than 10 frames
    class func loadSprite(name: String, frames: Int) {
        sprites[name] = []
        for i in 0...frames-1 {
            sprites[name]!.append(SKTexture(imageNamed: name+"_0\(i)"))
        }
    }
    
    class func update() {
        let playerPos = World.getSpriteByName(Constants.Node_Player).position
        let bossPos = node!.position
        
        if awake {
            // Chase player
            let dir = Utility.direction(bossPos.x, x2: playerPos.x)
            node!.physicsBody?.velocity.dx = dir * Constants.BossSpeed
        } else {
            // Check if player is close
            let dist = Utility.distance(bossPos, p2: playerPos)
            if dist < Constants.BossWakeRadius {
                Boss.animateOnce(Constants.Sprite_BossAppear, timePerFrame: 0.3, completion: { () in
                    Boss.animateContinuously(Constants.Sprite_BossWalk, timePerFrame: 0.1)
                    awake = true
                })
            }
        }
    }
    
    class func animateOnce(name: String, timePerFrame: NSTimeInterval, completion: () -> Void) {
        node!.runAction(SKAction.animateWithTextures(sprites[name]!, timePerFrame: timePerFrame), completion: completion)
    }
    
    class func animateContinuously(name: String, timePerFrame: NSTimeInterval) {
        node!.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(sprites[name]!, timePerFrame: timePerFrame)))
    }
    
    class func didFinishUpdate() {
        // Keep boss clipped within bounds
        node!.position.y = Constants.BossY
        if node?.position.x < Constants.BossLeftX {
            node!.position.x = Constants.BossLeftX
        } else if node?.position.x > Constants.BossRightX {
            node!.position.x = Constants.BossLeftX
        }
    }
    
    class func reset() {
        node!.position = Constants.BossStartPos
        node!.physicsBody?.velocity = CGVectorMake(0.0, 0.0)
        
        node!.removeAllActions()
        (node as! SKSpriteNode).texture = SKTexture(imageNamed: "bossAppear_00")
        
        awake = false
    }
    
    class func getPos() -> CGPoint {
        return node!.position
    }
}