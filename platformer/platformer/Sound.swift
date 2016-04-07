//
//  Sound.swift
//  Micronaut
//
//  Created by Christopher Williams on 4/7/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  Handles playing and stopping soundtracks.

import SpriteKit

class Sound {
    static private var scene:SKScene?
    
    class func initialize(scene: SKScene) {
        self.scene = scene
    }
    
    class func play(filename: String) {
        scene!.runAction(SKAction.playSoundFileNamed(filename, waitForCompletion: false))
    }
}