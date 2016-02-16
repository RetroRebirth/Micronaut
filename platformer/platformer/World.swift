//
//  World.swift
//  Micronaut
//
//  Created by Christopher Williams on 1/16/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  Contains all sprites within the world.

import Foundation
import SpriteKit

class World {
    static private var sprites: [String:SKNode] = [String:SKNode]()
    
    // Adding "//" searches for nodes recursively https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKNode_Ref/index.html#//apple_ref/occ/cl/SKNode
    class func loadSprites(scene: SKScene) {
        sprites[Constants.Sprite_Player] = scene.childNodeWithName("//\(Constants.Sprite_Player)")!
        sprites[Constants.Sprite_Background] = scene.childNodeWithName("//\(Constants.Sprite_Background)")!
        sprites[Constants.Sprite_Camera] = scene.childNodeWithName("//\(Constants.Sprite_Camera)")!
    }
    
    class func getSpriteByName(name: String) -> SKNode {
        return sprites[name]!
    }

    // Player either died or acheived the goal. Reset the sprites.
    class func reset() {
        let player = getSpriteByName(Constants.Sprite_Player)
        let background = getSpriteByName(Constants.Sprite_Background)
        
        player.position = Constants.PlayerStartPos
        player.physicsBody?.velocity = CGVectorMake(0.0, 0.0)
        background.position.x = 0.0
        Camera.reset()
    }
    
    // Gets called with every frame.
    class func update() {
        let player = getSpriteByName(Constants.Sprite_Player)
        
        // If the player fell, reset the world
        if player.position.y < 0.0 {
            reset()
        }
    }
    
    class func didBeginContact(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        debugPrint(bodyA.categoryBitMask, bodyB.categoryBitMask)
        
        if ((bodyA.categoryBitMask & Constants.CollisionCategory_Player != 0) &&
            (bodyB.categoryBitMask & Constants.CollisionCategory_Enemy != 0)) {
                playerHit(bodyA, enemyBody: bodyB)
        }
    }
    
    class func playerHit(playerBody: SKPhysicsBody, enemyBody: SKPhysicsBody) {
        let hurtImpulse = Constants.PlayerHurtForce * Utility.normal(Utility.CGPointToCGVector((playerBody.node?.position)! - (enemyBody.node?.position)!))
        playerBody.applyImpulse(hurtImpulse)
    }
}