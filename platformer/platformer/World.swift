//
//  World.swift
//  Micronaut
//
//  Created by Christopher Williams on 1/16/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  Contains all sprites within the world.

import Foundation
import SpriteKit

class World {
    static private var sprites: [String:SKNode] = [String:SKNode]()
    
    // Adding "//" searches for nodes recursively https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKNode_Ref/index.html#//apple_ref/occ/cl/SKNode
    class func loadSprites(scene: SKScene) {
        sprites[Constants.Sprite_Player] = scene.childNodeWithName("//\(Constants.Sprite_Player)")!
        sprites[Constants.Sprite_Background] = scene.childNodeWithName("//\(Constants.Sprite_Background)")!
        sprites[Constants.Sprite_Camera] = scene.childNodeWithName("//\(Constants.Sprite_Camera)")!
    }
    
    class func getSpriteByName(name: String) -> SKNode {
        return sprites[name]!
    }

    // Player either died or acheived the goal. Reset the sprites.
    class func reset() {
        let player = getSpriteByName(Constants.Sprite_Player)
        let background = getSpriteByName(Constants.Sprite_Background)
        
        player.position = Constants.PlayerStartPos
        background.position.x = 0.0
    }
    
    // Gets called with every frame.
    class func update() {
        let player = getSpriteByName(Constants.Sprite_Player)
        
        // If the player fell, bring them back to start
        if player.position.y < 0.0 {
            reset()
        }
    }
}