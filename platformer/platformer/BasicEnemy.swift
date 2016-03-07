//
//  BasicEnemy.swift
//  Micronaut
//
//  Created by Christopher Williams on 3/6/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  A basic enemy that is invicible and walks back and forth

import Foundation
import SpriteKit

class BasicEnemy: Enemy {
    private static let MAX_WALKING_TIME:CGFloat = 2 // Max time the enemy should walk around
    
    private var walkingTimer:CGFloat = BasicEnemy.NEW_WALKING_TIME() // Amount of time the enemy should spend walking around
    private var speed:CGFloat = 50.0
    private var direction = 0 // negative = left, zero = standing, positive = right
    
    private static func NEW_WALKING_TIME() -> CGFloat {
        return CGFloat(drand48()) * BasicEnemy.MAX_WALKING_TIME
    }
    
    override func update() {
        // Pick direction if it's time
        walkingTimer -= Utility.dt
        if (walkingTimer <= 0.0) {
            walkingTimer = BasicEnemy.NEW_WALKING_TIME()
            direction = (random() % 3) - 1
        }
        // Move enemy
        sprite?.position.x += CGFloat(direction) * speed * Utility.dt
    }
}
