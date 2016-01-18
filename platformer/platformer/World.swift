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
    static var sprites: [String:SKNode] = [String:SKNode]()
    
    class func loadSprites(scene: SKScene) {
        // TODO use pointers
        sprites["player"] = scene.childNodeWithName("player")!
    }
    
    class func getPlayer() -> SKNode {
        return sprites["player"]!
    }
}