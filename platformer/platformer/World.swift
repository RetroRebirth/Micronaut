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
    static var ShouldReset:Bool = false
    static var Level:Int = 0
    
    static private var sprites:[String:SKNode] = [String:SKNode]()
    static private var enemies = Set<Enemy>()
    
    class func initialize(scene: SKScene) {
        loadSprites(scene)
    }
    
    // Adding "//" searches for nodes recursively https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKNode_Ref/index.html#//apple_ref/occ/cl/SKNode
    class func loadSprites(scene: SKScene) {
        sprites[Constants.Node_Player] = scene.childNodeWithName("//\(Constants.Node_Player)")!
        sprites[Constants.Node_Background] = scene.childNodeWithName("//\(Constants.Node_Background)")!
        sprites[Constants.Node_Camera] = scene.childNodeWithName("//\(Constants.Node_Camera)")!
        
        // Initialize enemies
        // TODO how to search for all enemy nodes?
        enemies.insert(BasicEnemy(sprite: scene.childNodeWithName("//basic_enemy")!))
    }
    
    class func getSpriteByName(name: String) -> SKNode {
        return sprites[name]!
    }

    // Player either died or acheived the goal. Reset the sprites.
    class func reset() {
        Player.reset()
        World.getSpriteByName(Constants.Node_Background).position.x = 0.0
        
        World.ShouldReset = false
    }
    
    // Gets called with every frame.
    class func update() {
        // Check if we need to reset the world
        if World.ShouldReset {
            World.reset()
        }
        // Update enemies
        for enemy in enemies {
            enemy.update()
        }
    }
    
    class func nextLevel() {
        // Increment the level or loop back to the beginning
        // If statement checks to make sure a goal isn't registered twice
        if (World.ShouldReset == false) {
            World.Level = (World.Level + 1) % Constants.LevelSpawnPoints.count
            World.ShouldReset = true
        }
        // Stop the player's velocity
        Player.setVelocityX(0.0, force: true)
        // Use the next level's background texture
        let background = (World.getSpriteByName(Constants.Node_Background) as! SKSpriteNode)
        background.texture = SKTexture(imageNamed: "bg-\(World.Level)")
    }
}