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
        // Offset the camera by tweening to look ahead of the player (based on input velocity)
        let mag = Controller.getTouchMagnitudeX()
        if mag == 0.0 && xOffset != 0.0 {
            // Player standing still, return camera to center
            if abs(xOffset) < 5.0 {
                xOffset = 0.0
            } else if xOffset < 0.0 {
                xOffset += 5.0
            } else {
                xOffset -= 5.0
            }
        } else {
            xOffset = mag * 0.1
        }
    
        // Keep the camera's x-position focused on player
        cameraNode!.position.x = World.getPlayer().position.x + xOffset
    }
}