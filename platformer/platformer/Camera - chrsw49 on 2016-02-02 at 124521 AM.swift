//
//  Camera.swift
//  Micronaut
//
//  Created by Christopher Williams on 2/1/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//

import Foundation

import SpriteKit

class Camera {
    static private let X_OFFSET_MAX:CGFloat = 200.0
    
    static private var cameraNode: SKNode?
    static private var xOffset: CGFloat = 0.0
    
    // Searches for nodes recursively https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKNode_Ref/index.html#//apple_ref/occ/cl/SKNode
    class func loadCamera(scene: SKScene) {
        cameraNode = scene.childNodeWithName("//camera")!
    }
    
    class func getNode() -> SKNode {
        return cameraNode!
    }
    
    class func didFinishUpdate() {
        // Offset the camera by tweening to look ahead of the player
        xOffset = Controller.getTouchMagnitudeX() * 0.1
//        let incr:CGFloat = 5.0
//        let dir = Controller.getTouchMagnitudeX()
//        if dir > 0.0 && xOffset < X_OFFSET_MAX {
//            // Player running right, offset right
//            xOffset += incr
//        } else if dir < 0.0 && xOffset > -X_OFFSET_MAX {
//            // Player running left, offset left
//            xOffset -= incr
//        } else if dir == 0.0 && xOffset != 0.0 {
//            // Player standing still, return camera to center
//            if xOffset < 0.0 {
//                xOffset += incr
//            } else {
//                xOffset -= incr
//            }
//        }
        
        // Keep the camera's x-position focused on player
        cameraNode!.position.x = World.getPlayer().position.x + xOffset
    }
}