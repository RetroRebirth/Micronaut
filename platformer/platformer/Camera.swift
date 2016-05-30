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
    static private var shakeOffsets: [CGPoint] = [CGPoint]()
    
    // Gets called at the end of every frame.
    class func didFinishUpdate() {
        let camera = World.getSpriteByName(Constants.Node_Camera)
        
        // Calculate the new camera's position
        let newCameraPos = Camera.calcNewCameraPos()
        
        // Background horizontal parallax motion before moving the camera
        let camDeltaX = newCameraPos.x - camera.position.x
        for i in 0..<Constants.Node_BG.count {
            World.getSpriteByName(Constants.Node_BG[i]).position.x += Constants.BGParallax[i] * camDeltaX
        }
        
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
        let newPosY = max(player.position.y - Constants.CameraYBuffer, Constants.CameraMinY)
        var point = CGPointMake(newPosX, newPosY)
        
        if !shakeOffsets.isEmpty {
            point = (shakeOffsets.popLast()! as CGPoint)
        }
        
        return point
        
        // Keep the camera in bounds
//        let bounds = Constants.LevelCameraBounds[World.Level]
//        return Utility.NumberWithinBounds(newPosX, min: CGFloat(bounds[0]), max: CGFloat(bounds[1]))
    }
    
    // TODO causes camera to shake randomly for given duration
    // http://stackoverflow.com/questions/20889860/a-camera-shake-effect-for-spritekit
    class func shake(times: Int) {
        let camera = World.getSpriteByName(Constants.Node_Camera)
        
        let pos = camera.position
        let amplitudeX = 30
        let amplitudeY = 30
        
        for _ in 0..<times {
            let randX = pos.x + CGFloat(arc4random()) % CGFloat(amplitudeX - amplitudeX/2)
            let randY = pos.y + CGFloat(arc4random()) % CGFloat(amplitudeY - amplitudeY/2)
            shakeOffsets.append(CGPointMake(randX, randY))
        }
    }
}