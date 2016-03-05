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
    // Sprites
    static let Sprite_Player = "player"
    static let Sprite_Background = "background"
    static let Sprite_Camera = "camera"
    
    // Player Properties
    static let PlayerStartPos = CGPointMake(128, 768)
    static let PlayerHurtForce:CGFloat = 150
    static let PlayerHurtStunTime:CGFloat = 2.0
    static let PlayerSpeed:CGFloat = 0.5
    static let PlayerJumpForce:CGFloat = 500
    
    // Background Properties
    static let BackgroundParallaxVelocity:CGFloat = -0.1
    
    // Camera
    static let CameraMinXBound:CGFloat = 768
    static let CameraMaxXBound:CGFloat = 4288
    static let CameraTweenResetVelocity:CGFloat = 2.0
    static let CameraLookAheadMagnitude:CGFloat = 0.1
    
    // Collision Classes (assigned in GameScene.sks by hand)
    static let CollisionCategory_Ground:UInt32 = 0x1 << 0
    static let CollisionCategory_Player:UInt32 = 0x1 << 1
    static let CollisionCategory_Enemy:UInt32 = 0x1 << 2
    static let CollisionCategory_Goal:UInt32 = 0x1 << 3
}