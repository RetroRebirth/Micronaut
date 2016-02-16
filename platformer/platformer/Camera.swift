//
//  Camera.swift
//  Micronaut
//
//  Created by Christopher Williams on 2/1/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  Modifies the camera and how we view the scene. The World owns the camera, but we can retreive it from here.

import Foundation

import SpriteKit

class Camera {
    static private var xOffset: CGFloat = 0.0 // The offset of the camera from the player
    
    // Gets called at the end of every frame.
    class func didFinishUpdate() {
        let camera = World.getSpriteByName(Constants.Sprite_Camera)
        
        // Calculate the new camera's position
        let newCameraPosX = calcNewCameraPosX()
        
        // Background horizontal parallax motion before moving the camera
        World.getSpriteByName(Constants.Sprite_Background).position.x += Constants.BackgroundParallaxVelocity * Utility.distance(CGPointMake(newCameraPosX, camera.position.y), p2: camera.position)
        
        // Move the camera
        camera.position.x = newCameraPosX
    }
    
    class func calcNewCameraPosX() -> CGFloat {
        // Offset the camera by tweening to look ahead of the player based on input touch distance
        let mag = Controller.getTouchMagnitudeX()
        if mag == 0.0 && xOffset != 0.0 {
            // Player standing still, return camera to center
            if abs(xOffset) < Constants.CameraTweenResetVelocity {
                xOffset = 0.0
            } else if xOffset < 0.0 {
                xOffset += Constants.CameraTweenResetVelocity
            } else {
                xOffset -= Constants.CameraTweenResetVelocity
            }
        } else {
            xOffset = mag * Constants.CameraLookAheadMagnitude
        }
        
        // Calculate where the camera should go
        let newPosX = World.getSpriteByName(Constants.Sprite_Player).position.x + xOffset
        
        // Keep the camera in bounds
        return Utility.NumberWithinBounds(newPosX, min: Constants.CameraMinXBound, max: Constants.CameraMaxXBound)
    }
    
    class func reset() {
        let camera = World.getSpriteByName(Constants.Sprite_Camera)
            
        camera.position.x = 0.0
        xOffset = 0.0
    }
}