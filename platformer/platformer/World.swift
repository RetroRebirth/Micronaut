//
//  World.swift
//  Micronaut
//
//  Created by Christopher Williams on 1/16/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  Holds all objects associated with the world.

import Foundation
import SpriteKit

class World {
    static private var sprites: [String:SKNode] = [String:SKNode]()
    
    // Searches for nodes recursively https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKNode_Ref/index.html#//apple_ref/occ/cl/SKNode
    class func loadSprites(scene: SKScene) {
        sprites["player"] = scene.childNodeWithName("//player")!
        sprites["background"] = scene.childNodeWithName("//background")!
    }
    
    class func getSpriteByName(name: String) -> SKNode {
        return sprites[name]!
    }
    
    class func getPlayer() -> SKNode {
        return sprites["player"]!
    }
    
    class func getBackground() -> SKNode {
        return sprites["background"]!
    }
}