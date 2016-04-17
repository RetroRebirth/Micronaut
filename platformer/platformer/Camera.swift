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
        let camera = World.getSpriteByName(Constants.Node_Camera)
        
        // Calculate the new camera's position
        let newCameraPosX = Camera.calcNewCameraPosX()
        
        // Background horizontal parallax motion before moving the camera
        // TODO don't just do distance, account for "negative distance"
        World.getSpriteByName(Constants.Node_Background).position.x += Constants.BackgroundParallaxVelocity * Utility.distance(CGPointMake(newCameraPosX, camera.position.y), p2: camera.position)
        
        // Move the camera
        camera.position.x = newCameraPosX
    }
    
    class func calcNewCameraPosX() -> CGFloat {
        // TODO fix momentum camera
//         Offset the camera by tweening to look ahead of the player based on input touch distance
//        let mag = Controller.getTouchMagnitudeX()
//        // TODO fix reset tweening
////        if abs(mag) <= 1000.0 && xOffset != 0.0 {
//////        if ((mag > 0.0 && xOffset > 0.0) || (mag < 0.0 && xOffset < 0.0)) {
//////            // Player switched directions, ease camera to other side
//////            xOffset += Constants.CameraTweenResetVelocity * mag > 0.0 ? -1.0 : 1.0
////            // Player is standing still, return camera to neutral position
////            if abs(xOffset) < Constants.CameraTweenResetVelocity {
////                xOffset = 0.0
////            } else if xOffset < 0.0 {
////                xOffset += Constants.CameraTweenResetVelocity
////            } else {
////                xOffset -= Constants.CameraTweenResetVelocity
////            }
////        } else {
////            xOffset = mag * Constants.CameraLookAheadMagnitude
////        }
//        xOffset = mag * Constants.CameraLookAheadMagnitude
        
        // Calculate where the camera should go
        let newPosX = World.getSpriteByName(Constants.Node_Player).position.x + xOffset
        return newPosX
        
        // Keep the camera in bounds
//        let bounds = Constants.LevelCameraBounds[World.Level]
//        return Utility.NumberWithinBounds(newPosX, min: CGFloat(bounds[0]), max: CGFloat(bounds[1]))
    }
}