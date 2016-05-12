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
        let directionX:CGFloat = -1.0 * (player.physicsBody!.velocity.dx != 0 ? player.physicsBody!.velocity.dx / abs(player.physicsBody!.velocity.dx) : 1.0)
        World.getSpriteByName(Constants.Node_BG0).position.x += Constants.BG0Parallax * directionX * Utility.distance(CGPointMake(newCameraPos.x, camera.position.y), p2: camera.position)
        World.getSpriteByName(Constants.Node_BG1).position.x += Constants.BG1Parallax * directionX * Utility.distance(CGPointMake(newCameraPos.x, camera.position.y), p2: camera.position)
        World.getSpriteByName(Constants.Node_BG2).position.x += Constants.BG2Parallax * directionX * Utility.distance(CGPointMake(newCameraPos.x, camera.position.y), p2: camera.position)
        World.getSpriteByName(Constants.Node_BG3).position.x += Constants.BG3Parallax * directionX * Utility.distance(CGPointMake(newCameraPos.x, camera.position.y), p2: camera.position)
        World.getSpriteByName(Constants.Node_BG4).position.x += Constants.BG4Parallax * directionX * Utility.distance(CGPointMake(newCameraPos.x, camera.position.y), p2: camera.position)
        
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
        let newPosY = max(player.position.y - 160, 360)
        return CGPointMake(newPosX, newPosY)
        
        // Keep the camera in bounds
//        let bounds = Constants.LevelCameraBounds[World.Level]
//        return Utility.NumberWithinBounds(newPosX, min: CGFloat(bounds[0]), max: CGFloat(bounds[1]))
    }
}