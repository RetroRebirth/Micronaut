//
//  Constants.swift
//  Micronaut
//
//  Created by Christopher Williams on 2/15/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//

import Foundation
import SpriteKit

struct Constants {
    // Animated Sprites
    static let Sprite_PlayerResting = "resting"
    static let Sprite_PlayerWalking = "walking"
    static let Sprite_PlayerJumping = "jumping"
    static let Sprite_BossAppear = "bossAppear"
    static let Sprite_BossWalk = "bossWalk"
    static let Sprite_BossRetreat = "bossRetreat"
    
    // Node Names
    static let Node_Player = "player"
    static let Node_Background = "background"
    static let Node_Camera = "camera"
    static let Node_Boss = "boss"
    
    // Player Properties
    static let PlayerHurtForce:CGFloat = 1000
    static let PlayerHurtStunTime:CGFloat = 1.0
    static let PlayerSpeed:CGFloat = 500
    static let PlayerJumpForceSmall:CGFloat = 300
    static let PlayerJumpForceBig:CGFloat = 400
    
    // Boss Properties (commented numbers are in relation to level4 node)
    static let BossY:CGFloat = 280 //-960
    static let BossLeftX:CGFloat = 24246 //1910
    static let BossRightX:CGFloat = 25866 //3530
    static let BossStartPos:CGPoint = CGPointMake(Constants.BossRightX, Constants.BossY)
    
    // Background Properties
    static let BGParallaxVelocity:CGFloat = -0.1
    
    // Camera
//    static let LevelCameraBounds = [[768, 4286], [5948, 7700], [9358, 10350]]
    static let CameraTweenResetVelocity:CGFloat = 5.0
    static let CameraLookAheadMagnitude:CGFloat = 0.1
    
    // Collision Classes (assigned in GameScene.sks by hand)
    static let CollisionCategory_Player:UInt32 = 0x1 << 0
    static let CollisionCategory_Ground:UInt32 = 0x1 << 1
    static let CollisionCategory_Enemy:UInt32 = 0x1 << 2
    static let CollisionCategory_Goal:UInt32 = 0x1 << 3
    
    // World Levels
    static let LevelSpawnPoints = [CGPointMake(0, 240),
                                   CGPointMake(12200, 768),
                                   CGPointMake(16600, 240),
                                   CGPointMake(6600, 240),
                                   CGPointMake(22336, 1240)]
}