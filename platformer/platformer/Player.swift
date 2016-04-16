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

class Player: AnimatedSprite {
    static private var stunCounter:CGFloat = 0.0
//    static var canJump:Bool = false
    
    override class func initialize(node: SKNode) {
        super.initialize(node)

        animateContinuously(Constants.Sprite_PlayerResting, timePerFrame: 0.1)
    }
    
    override class func loadSprites() {
        super.loadSprites()
        
        // Resting
        loadSprite(Constants.Sprite_PlayerResting, frames: 8)
        // Walking
        loadSprite(Constants.Sprite_PlayerWalking, frames: 8)
        // Jumping
        loadSprite(Constants.Sprite_PlayerJumping, frames: 8)
    }
    
    class func update() {
        // If the player fell, reset the world
        if node!.position.y < 0.0 {
            World.ShouldReset = true
        }
        // If the player is stunned, decrement the stun counter
        if Player.stunCounter > 0.0 {
            Player.stunCounter -= Utility.dt
            // Stun timer is done, change player sprite back to normal
            if Player.stunCounter <= 0.0 {
                animateContinuously(Constants.Sprite_PlayerResting, timePerFrame: 0.1)
            }
        }
    }
    
    class func jump() {
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        // Only jump when the player is "standing on ground"
        if let dy = node!.physicsBody?.velocity.dy {
            
//            debugPrint(dy)
            
            if fabs(dy) <= 5.0 {
                // Change player sprite image to jumping
                animateOnce(Constants.Sprite_PlayerJumping, timePerFrame: 0.1)
                // Play jumping sound effect
                Sound.play("jump.wav")
                // Enact an impulse on the player
                if isBig() {
                    node!.physicsBody?.applyImpulse(CGVectorMake(0, Constants.PlayerJumpForceBig))
                } else {
                    node!.physicsBody?.applyImpulse(CGVectorMake(0, Constants.PlayerJumpForceSmall))
                }
            }
        }
        
//        if canJump {
//            player.physicsBody?.applyImpulse(CGVectorMake(0, Constants.PlayerJumpForce))
//        }
    }
    
    class func setVelocityX(velocityX: CGFloat) {
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        // Only move when on the ground
        if node!.physicsBody?.velocity.dy == 0.0 {
            node!.physicsBody?.velocity.dx = velocityX
            
            // Change player sprite animation
            if velocityX == 0.0 {
                animateContinuously(Constants.Sprite_PlayerResting, timePerFrame: 0.1)
            } else {
                // Flip image depending on which way the player is moving
                if (velocityX > 0.0 && node!.xScale < 0.0) || (velocityX < 0.0 && node!.xScale > 0.0) {
                    node!.xScale = -1.0 * node!.xScale
                }
                animateContinuously(Constants.Sprite_PlayerWalking, timePerFrame: 0.1)
            }
        }
    }
    
    class func isStunned() -> Bool {
        return stunCounter > 0.0
    }
    
    class func reset() {
        Player.setPos(Constants.LevelSpawnPoints[World.Level])
    }
    
    class func setPos(pos: CGPoint) {
        // Place the player back at start with no velocity
        node!.position = pos
        node!.physicsBody?.velocity = CGVectorMake(0.0, 0.0)
        
        // Change player sprite to default
        animateContinuously(Constants.Sprite_PlayerResting, timePerFrame: 0.1)
    }
    
    class func hurtBy(enemyBody: SKPhysicsBody) {
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        let playerBody = node!.physicsBody!
        
        // TODO Change player sprite to hurt
        animateOnce(Constants.Sprite_PlayerJumping, timePerFrame: 0.1)
        // Play hurt sound effect
        Sound.play("hurt.wav")
        
        // Knock-back player
        let hurtImpulse = Constants.PlayerHurtForce * Utility.normal(Utility.CGPointToCGVector((playerBody.node?.position)! - (enemyBody.node?.position)!))
        playerBody.applyImpulse(hurtImpulse)
        // Apply hit stun
        Player.stunCounter = Constants.PlayerHurtStunTime
    }
    
    class func toggleShrink() {
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        let duration = 0.1
        let direction:CGFloat = directionX()
        
        // Is player small or big?
        if isBig() {
            node!.runAction(SKAction.scaleXTo(direction * 0.5, duration: duration))
            node!.runAction(SKAction.scaleYTo(0.5, duration: duration))
        } else {
            node!.runAction(SKAction.scaleXTo(direction * 1.0, duration: duration))
            node!.runAction(SKAction.scaleYTo(1.0, duration: duration))
        }
    }
    
    class func isBig() -> Bool {
        return node!.yScale >= 1.0
    }
    
    class func directionX() -> CGFloat {
        return node!.physicsBody!.velocity.dx > 0.0 ? 1.0 : -1.0
    }
}