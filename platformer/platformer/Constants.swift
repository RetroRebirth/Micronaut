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
    
    // Sprite Properties
    static let PlayerStartPos = CGPointMake(128, 768)
    static let BackgroundParallaxVelocity:CGFloat = -0.1
    
    // Camera
    static let CameraMinXBound:CGFloat = 768
    static let CameraMaxXBound:CGFloat = 4288
    static let CameraTweenResetVelocity:CGFloat = 5.0
    static let CameraLookAheadMagnitude:CGFloat = 0.1
    
    // Controller
    static let PlayerSpeed:CGFloat = 0.5
    static let PlayerJumpForce:CGFloat = 200
}