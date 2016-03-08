//
//  Player.swift
//  Micronaut
//
//  Created by Christopher Williams on 2/16/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  Handles the game logic in association with the player.

import Foundation
import SpriteKit

class Player {
    static private var stunCounter:CGFloat = 0.0
    
    class func update() {
        let player = World.getSpriteByName(Constants.Sprite_Player) as! SKSpriteNode
        
        // If the player fell, reset the world
        if player.position.y < 0.0 {
            World.ShouldReset = true
        }
        if Player.stunCounter > 0.0 {
            Player.stunCounter -= Utility.dt
            // Stun timer is done, change player sprite back to normal
            if Player.stunCounter <= 0.0 {
                player.texture = SKTexture(image: UIImage(named: Constants.Player_Image)!)
            }
        }
    }
    
    class func jump() {
        let player = World.getSpriteByName(Constants.Sprite_Player)
        
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        // Only jump when the player is standing on ground
        if player.physicsBody?.velocity.dy == 0.0 {
            // TODO change player sprite image to jumping
            player.physicsBody?.applyImpulse(CGVectorMake(0, Constants.PlayerJumpForce))
        }
    }
    
    class func setVelocityX(velocityX: CGFloat) {
        let player = World.getSpriteByName(Constants.Sprite_Player)
        
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        // TODO change player sprite image to running based on direction
        
        // Only run when on the ground
        if player.physicsBody?.velocity.dy == 0.0 {
            player.physicsBody?.velocity.dx = velocityX
        }
    }
    
    class func isStunned() -> Bool {
        return stunCounter > 0.0
    }
    
    class func reset() {
        Player.setPos(Constants.LevelSpawnPoints[World.Level])
    }
    
    class func setPos(pos: CGPoint) {
        let player = World.getSpriteByName(Constants.Sprite_Player)
        
        // Place the player back at start with no velocity
        player.position = pos
        player.physicsBody?.velocity = CGVectorMake(0.0, 0.0)
    }
    
    class func hurtBy(enemyBody: SKPhysicsBody) {
        let playerSprite = World.getSpriteByName(Constants.Sprite_Player) as! SKSpriteNode
        let playerBody = playerSprite.physicsBody!
        
        // TODO change player sprite to hurt
        playerSprite.texture = SKTexture(vectorNoiseWithSmoothness: 0.5, size: CGSize(width: 128, height: 128))
        
        // Knock-back player
        let hurtImpulse = Constants.PlayerHurtForce * Utility.normal(Utility.CGPointToCGVector((playerBody.node?.position)! - (enemyBody.node?.position)!))
        playerBody.applyImpulse(hurtImpulse)
        // Apply hit stun
        Player.stunCounter = Constants.PlayerHurtStunTime
    }
}