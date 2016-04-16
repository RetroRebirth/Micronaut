//
//  AnimatedSprite.swift
//  Micronaut
//
//  Created by Christopher Williams on 4/7/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  A model for a class that contains an animated sprite

import SpriteKit

class AnimatedSprite {
    static private var sprites:[String:[SKTexture]] = [String:[SKTexture]]()
    static var node:SKNode?
    
    // Override: Define starting animation
    class func initialize(node: SKNode) {
        loadSprites()
        self.node = node
    }
    
    // Override: Define which sprites to load
    class func loadSprites() {
    }
    
    // This only works when there are less than 10 frames
    class func loadSprite(name: String, frames: Int) {
        sprites[name] = []
        for i in 0...frames-1 {
            sprites[name]!.append(SKTexture(imageNamed: name+"_0\(i)"))
        }
    }
    
    class func animateOnce(name: String, timePerFrame: NSTimeInterval) {
        node!.runAction(SKAction.animateWithTextures(sprites[name]!, timePerFrame: timePerFrame))
    }
    
    class func animateContinuously(name: String, timePerFrame: NSTimeInterval) {
        node!.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(sprites[name]!, timePerFrame: timePerFrame)))
    }
}