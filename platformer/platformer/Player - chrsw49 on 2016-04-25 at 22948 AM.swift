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
    static private let shrinkScale:CGFloat = 0.5
    
    static private var stunCounter:CGFloat = 0.0
    static var onGround:Bool = false
    static var velocityX:CGFloat = 0.0
    
    override class func initialize(node: SKNode) {
        super.initialize(node)
        
        // Allow player to run
        node.physicsBody?.friction = 0.0
        node.physicsBody?.restitution = 0.0

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
        // Keep the player running (unless they hit something)
        if abs(Player.velocityX) > 0.0 {
            node!.physicsBody?.velocity.dx = Player.velocityX
        }
        // If the player fell, reset the world
        if node!.position.y < 0.0 {
            Player.die()
        }
        // If the player is stunned, decrement the stun counter
        if Player.stunCounter > 0.0 {
            Player.stunCounter -= Utility.dt
            // Stun timer is done, change player sprite back to normal
            if Player.stunCounter <= 0.0 {
                animateContinuously(Constants.Sprite_PlayerResting, timePerFrame: 0.1)
            }
        }
        // Check to see if the player is contacting the ground
        Player.onGround = false
        var groundContactCount = 0
        for body in node!.physicsBody!.allContactedBodies() {
            if (body.categoryBitMask & Constants.CollisionCategory_Ground != 0) {
                Player.onGround = true
                if !Player.isShrinkingOrGrowing() {
                    break
                } else {
                    // If the player is touching two grounds at the same time while growing, have them shrink
                    groundContactCount += 1
                    // TODO why does allContactedBodies return duplicates?
                    if groundContactCount == 3 {
                        Player.setShrink(true)
                        break
                    }
                }
            }
        }
    }
    
    class func jump() {
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        // Only jump when the player is standing on the ground
//        if let dy = node!.physicsBody?.velocity.dy {
        if Player.onGround {
            // Change player sprite image to jumping
            animateOnce(Constants.Sprite_PlayerJumping, timePerFrame: 0.1)
            // Play jumping sound effect
            Sound.play("jump.wav", loop: false)
            // Enact an impulse on the player
            if isBig() {
                node!.physicsBody?.applyImpulse(CGVectorMake(0, Constants.PlayerJumpForceBig))
            } else {
                node!.physicsBody?.applyImpulse(CGVectorMake(0, Constants.PlayerJumpForceSmall))
            }
        }
    }
    
    class func setVelocityX(velocityX: CGFloat, force: Bool) {
        if Player.isStunned() && !force {
            // Do nothing, the player is stunned
            return
        }
        
        Player.velocityX = velocityX
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
    
    class func isStunned() -> Bool {
        return Player.stunCounter > 0.0
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
        
        Player.setVelocityX(0.0, force: true)
        
        let playerBody = node!.physicsBody!
        
        // TODO Change player sprite to hurt
        animateOnce(Constants.Sprite_PlayerJumping, timePerFrame: 0.1)
        // Play hurt sound effect
        Sound.play("hurt.wav", loop: false)
        
        // Knock-back player
        let hurtImpulse = Constants.PlayerHurtForce * Utility.normal(Utility.CGPointToCGVector((playerBody.node?.position)! - (enemyBody.node?.position)!))
        playerBody.applyImpulse(hurtImpulse)
        // Apply hit stun
        Player.stunCounter = Constants.PlayerHurtStunTime
    }
    
    class func setShrink(shouldShrink:Bool) {
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        let duration = 0.1
        let direction:CGFloat = directionX()
        
        if shouldShrink {
            node!.runAction(SKAction.scaleXTo(direction * Player.shrinkScale, duration: duration))
            node!.runAction(SKAction.scaleYTo(0.5, duration: duration))
        } else {
            node!.runAction(SKAction.scaleXTo(direction * 1.0, duration: duration))
            node!.runAction(SKAction.scaleYTo(1.0, duration: duration))
        }
    }
    
    class func isBig() -> Bool {
        return node!.yScale >= 1.0
    }
    
    class func isSmall() -> Bool {
        return node!.yScale <= Player.shrinkScale
    }
    
    class func isShrinkingOrGrowing() -> Bool {
        return node!.yScale < 1.0 && node!.yScale > Player.shrinkScale
    }
    
    class func directionX() -> CGFloat {
        return node!.physicsBody!.velocity.dx > 0.0 ? 1.0 : -1.0
    }
    
    class func die() {
        let duration = 0.5
        // Animations to group together
        let rotate = SKAction.rotateByAngle(2*M_PI, duration: duration)
        let scale = SKAction.scaleTo(0.0, duration: duration)
        
        node!.runAction(SKAction.rotateByAngle(2*M_PI, duration: 0.5), completion: <#T##() -> Void#>)
        
        World.ShouldReset = true
        Player.setVelocityX(0.0, force: true)
    }
}