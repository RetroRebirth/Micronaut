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
//    static private var xOffset: CGFloat = 0.0 // The offset of the camera from the player
    
    // Gets called at the end of every frame.
    class func didFinishUpdate() {
        let camera = World.getSpriteByName(Constants.Node_Camera)
        
        // Calculate the new camera's position
        let newCameraPos = Camera.calcNewCameraPos()
        
        // Background horizontal parallax motion before moving the camera
        let player = World.getSpriteByName(Constants.Node_Player)
        let playerVelX = player.physicsBody!.velocity.dx
        let directionX:CGFloat = abs(playerVelX) > 0.0 ? playerVelX / abs(playerVelX) : 0.0
        let playerVelY = World.getSpriteByName(Constants.Node_Player).physicsBody!.velocity.dx
        let directionY:CGFloat = abs(playerVelY) > 0.0 ? playerVelY / abs(playerVelY) : 0.0
        World.getSpriteByName(Constants.Node_Background).position.x += Constants.BackgroundParallaxVelocity * directionX * Utility.distance(CGPointMake(newCameraPos.x, camera.position.y), p2: camera.position)
        World.getSpriteByName(Constants.Node_Background).position.x += Constants.BackgroundParallaxVelocity * directionY * Utility.distance(CGPointMake(camera.position.x, newCameraPos.y), p2: camera.position)
        
        // Move the camera
        camera.position = newCameraPos
    }
    
    class func calcNewCameraPos() -> CGPoint {
//        let camera = World.getSpriteByName(Constants.Node_Camera)
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
        let player = World.getSpriteByName(Constants.Node_Player)
        let newPosX = player.position.x
        let newPosY = max(player.position.y - 160, 380)
        return CGPointMake(newPosX, newPosY)
        
        // Keep the camera in bounds
//        let bounds = Constants.LevelCameraBounds[World.Level]
//        return Utility.NumberWithinBounds(newPosX, min: CGFloat(bounds[0]), max: CGFloat(bounds[1]))
    }
}