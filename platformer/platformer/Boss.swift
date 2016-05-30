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
    static var state:BossState = BossState.Sleeping
    
    enum BossState {
        case Sleeping
        case Cutscene
        case Waiting
        case Chasing
    }
    
    class func initialize(node: SKNode) {
        Boss.loadSprite(Constants.Sprite_BossAppear, frames: 4)
        Boss.loadSprite(Constants.Sprite_BossWalk, frames: 6)
        Boss.loadSprite(Constants.Sprite_BossRetreat, frames: 4)
        
        // TODO Custom sprite collision body for better detection
//        let physics = SKPhysicsBody(rectangleOfSize: CGSizeMake(210 * node.xScale, 150 * node.yScale), center: CGPoint(x: 150 * node.xScale, y: 175 * node.yScale))
//        physics.dynamic = true
//        physics.allowsRotation = false
//        physics.pinned = false
//        physics.affectedByGravity = false
//        physics.categoryBitMask = Constants.CollisionCategory_Enemy
//        physics.contactTestBitMask = Constants.CollisionCategory_Player
//        node.physicsBody = physics
        
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

        // TODO chase by staying certain distance behind (so long as running?)
        // TODO if player not running keep boss momentum
        // TODO what to do if player stops and runs? (boss will just be forever closer)

        
        if state == BossState.Chasing {
            // Chase player
            let dir = Utility.direction(bossPos.x, x2: playerPos.x)
            node!.physicsBody!.velocity.dx = dir * Constants.PlayerSpeed
//            if Player.dying {
//                // Humorous "eating" movement
//                node!.physicsBody!.velocity.dx = dir * Constants.PlayerSpeed
//            } else {
//                // Otherwise, chase with acceleration
//                node!.physicsBody!.velocity.dx += dir * Utility.dt * Constants.BossAccel
//                if abs(node!.physicsBody!.velocity.dx) > Constants.BossMaxSpeed {
//                    node!.physicsBody!.velocity.dx = dir * Constants.BossMaxSpeed
//                }
//            }
        } else if state == BossState.Waiting {
            // Stand still and wait for the player to move left or right
            state = BossState.Chasing
        } else if state == BossState.Cutscene {
            // Play the cutscene
            // stun player
            Player.clearVelocity()
            let duration = 1.0
            Player.stunCounter = CGFloat(duration + 0.2)
            // Have camera shake to simulate boss taking big steps
            Camera.shake(15)
            // boss appears on left side
            state = BossState.Waiting
        } else /* state == BossState.Sleeping */{
            // Wait for player to get in position
            if playerPos.x >= Constants.BossWakeX {
                state = BossState.Cutscene
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
//        // Keep boss clipped within bounds
//        node!.position.y = Constants.BossY
//        if node?.position.x < Constants.BossLeftX {
//            node!.position.x = Constants.BossLeftX
//        } else if node?.position.x > Constants.BossRightX {
//            node!.position.x = Constants.BossRightX
//        }
    }
    
    class func reset() {
        node!.position = Constants.BossStartPos
        node!.physicsBody?.velocity = CGVectorMake(0.0, 0.0)
        
        node!.removeAllActions()
        (node as! SKSpriteNode).texture = SKTexture(imageNamed: "bossAppear_00")
        
        state = BossState.Sleeping
    }
    
    class func getPos() -> CGPoint {
        return node!.position
    }
}