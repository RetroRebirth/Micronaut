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
    static var velocityX:CGFloat = 0.0
    static var velocityY:CGFloat = 0.0
    static var jumpCounter:CGFloat = 0.0
    static var dying:Bool = false
    
    override class func initialize(node: SKNode) {
        super.initialize(node)
        
        // Allow player to run
        node.physicsBody?.friction = 0.0
        node.physicsBody?.restitution = 0.0
        node.physicsBody?.affectedByGravity = !Controller.debug

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
        // Death
        loadSprite("spacemanDead", frames: 1)
    }
    
    class func update() {
        // Keep the player running (unless they hit something)
        if abs(Player.velocityX) > 0.0 {
            node!.physicsBody?.velocity.dx = Player.velocityX
        }
        if abs(Player.velocityY) > 0.0 {
            node!.physicsBody?.velocity.dy = Player.velocityY
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
        // Check to see if the player is recently contacting the ground
        if Player.jumpCounter > 0.0 {
            Player.jumpCounter -= Utility.dt
        }
        
//        var groundContactCount = 0
        for body in node!.physicsBody!.allContactedBodies() {
            if (body.categoryBitMask & Constants.CollisionCategory_Ground != 0) {
                // Reset the jump counter if the player has recently touched the ground
                Player.jumpCounter = 0.5
                // If the player isn't shrinking or growing then we don't care what happens now
                if !Player.isShrinkingOrGrowing() {
                    break
                }
                // Measure the ground's position in relation to the player
                // http://stackoverflow.com/questions/21853175/finding-absolute-position-of-child-sknode
                let absoluteY = body.node!.position.y + body.node!.parent!.position.y
                if absoluteY > node!.position.y {
                    // If the player is squished between a floor and ceiling, force shrink
                    Player.setShrink(true)
                    break
//                    // If the player is touching two grounds at the same time while growing, have them shrink
//                    groundContactCount += 1
//                    // TODO why does allContactedBodies return duplicates?
//                    if groundContactCount == 3 {
//                        Player.setShrink(true)
//                        break
//                    }
                }
            }
        }
    }
    
    class func didFinishUpdate() {
    }
    
    class func jump() {
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        // Only jump when the player is standing on the ground
//        if let dy = node!.physicsBody?.velocity.dy {
        if Player.onGround() {
            // Nullify the jump counter (until we touch ground again)
            Player.jumpCounter = 0.0
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
            animateContinuously(Constants.Sprite_PlayerWalking, timePerFrame: 0.05)
        }
    }
    
    class func setVelocityY(velocityY: CGFloat, force: Bool) {
        if Player.isStunned() && !force {
            // Do nothing, the player is stunned
            return
        }
        
        Player.velocityY = velocityY
        node!.physicsBody?.velocity.dy = velocityY
    }
    
    
    class func clearVelocity() {
        Player.velocityX = 0.0
        Player.velocityY = 0.0
        
        node!.physicsBody?.velocity.dx = 0.0
        node!.physicsBody?.velocity.dy = 0.0
    }
    
    class func isStunned() -> Bool {
        return Player.stunCounter > 0.0
    }
    
    class func reset() {
        Player.setPos(Constants.LevelSpawnPoints[World.Level])
        animateContinuously(Constants.Sprite_PlayerResting, timePerFrame: 0.1)
        node!.xScale = 1.0
        node!.yScale = 1.0
        node!.alpha = 1.0
        node!.physicsBody?.affectedByGravity = !Controller.debug
        node!.physicsBody?.pinned = false
        node!.physicsBody?.dynamic = true
    }
    
    class func setPos(pos: CGPoint) {
        // Place the player back at start with no velocity
        node!.position = pos
        node!.physicsBody?.velocity = CGVectorMake(0.0, 0.0)
        
        // Change player sprite to default
        animateContinuously(Constants.Sprite_PlayerResting, timePerFrame: 0.1)
    }
    
    class func getPos() -> CGPoint {
        return node!.position
    }
    
    class func hurtBy(enemyBody: SKPhysicsBody) {
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        // Option 1: Player dies and goes back to start
        Player.die()
        
        // Option 2: Knock the player back, no death
//        Player.setVelocityX(0.0, force: true)
//        
//        let playerBody = node!.physicsBody!
//        
//        // TODO Change player sprite to hurt
//        animateOnce(Constants.Sprite_PlayerJumping, timePerFrame: 0.1)
//        // Play hurt sound effect
//        Sound.play("hurt.wav", loop: false)
//        
//        // Knock-back player
//        let hurtImpulse = Constants.PlayerHurtForce * Utility.normal(Utility.CGPointToCGVector((playerBody.node?.position)! - (enemyBody.node?.position)!))
//        playerBody.applyImpulse(hurtImpulse)
//        // Apply hit stun
//        Player.stunCounter = Constants.PlayerHurtStunTime
    }
    
    class func setShrink(shouldShrink:Bool) {
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        let duration = 0.1
        let directionX = node!.xScale / abs(node!.xScale)
        
        if shouldShrink {
            node!.runAction(SKAction.scaleXTo(directionX * Player.shrinkScale, duration: duration))
            node!.runAction(SKAction.scaleYTo(0.5, duration: duration))
        } else {
            node!.runAction(SKAction.scaleXTo(directionX * 1.0, duration: duration))
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
    
    class func die() {
        if Player.isStunned() || Controller.debug {
            // Do nothing, the player is stunned
            return
        }
        
        setShrink(false)
        
        let duration = 1.0
        // Animations to group together
        let image = SKAction.animateWithTextures(sprites["spacemanDead"]!, timePerFrame: duration)
        let fade = SKAction.fadeOutWithDuration(duration)
        // Final animation
        let group = SKAction.group([image, fade])
        // Hold player still for better animation
        Player.stunCounter = CGFloat(duration + 0.2)
        node!.physicsBody?.affectedByGravity = false
        node!.physicsBody?.pinned = true
        node!.physicsBody?.dynamic = false
        Player.clearVelocity()
        
        // Audio feedback
        Sound.play("hurt.wav", loop: false)
        // Visual feedback
        node!.runAction(group, completion: { () -> Void in
            // Move player back to start of level
            World.ShouldReset = true
            Player.dying = false
        })
        
        Player.dying = true
    }
    
    class func warp() {
        if Player.isStunned() {
            // Do nothing, the player is stunned
            return
        }
        
        setShrink(false)
        
        let duration = 0.5
        // Animations to group together
        let fade = SKAction.fadeOutWithDuration(duration)
        // Final animation
        let group = SKAction.group([fade])
        // Hold player still for better animation
        Player.setVelocityX(0.0, force: true)
        Player.stunCounter = CGFloat(duration + 0.2)
        node!.physicsBody?.affectedByGravity = false
        
        // Audio feedback
        Sound.play("warp.wav", loop: false)
        // Visual feedback
        node!.runAction(group, completion: { () -> Void in
            // Move player to next level
            World.nextLevel()
        })
    }
    
    class func onGround() -> Bool {
        return Player.jumpCounter > 0.0
    }
}