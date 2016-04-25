//
//  Utility.swift
//  Micronaut
//
//  Created by Christopher Williams on 1/16/16.
//  Copyright © 2016 Christopher Williams. All rights reserved.
//
//  Add useful operator overloads and static methods here.

import Foundation
import SpriteKit

// CGVector operation overloading (http://www.raywenderlich.com/80818/operator-overloading-in-swift-tutorial)
func + (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}
func - (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}
func * (scale: CGFloat, vector: CGVector) -> CGVector {
    return CGVector(dx: scale * vector.dx, dy: scale * vector.dy)
}
// CGPoint operation overloading
func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

class Utility {
    static var dt:CGFloat = 0.0
    
    static private var previousTime:CFTimeInterval = 0.0
    
    class func update(currentTime: CFTimeInterval) {
        // Convert the current time to delta time (dt)
        Utility.dt = CGFloat(currentTime - previousTime)
        Utility.previousTime = currentTime
    }
    // Handle collisions
    class func didBeginContact(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        // Player contacted enemy
        if ((bodyA.categoryBitMask & Constants.CollisionCategory_Player != 0) &&
            (bodyB.categoryBitMask & Constants.CollisionCategory_Enemy != 0)) {
            Player.hurtBy(bodyB)
        }
        // Player contacted goal
        if ((bodyA.categoryBitMask & Constants.CollisionCategory_Player != 0) &&
            (bodyB.categoryBitMask & Constants.CollisionCategory_Goal != 0)) {
            Player.warp()
        }
    }
    class func didEndContact(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
    }
    
    // CGPoint & CGVector conversion
    class func CGPointToCGVector(point: CGPoint) -> CGVector {
        return CGVector(dx: point.x, dy: point.y)
    }
    class func CGVectorToCGPoint(vector: CGVector) -> CGPoint {
        return CGPoint(x: vector.dx, y: vector.dy)
    }
    class func distance(p1: CGPoint, p2: CGPoint) -> CGFloat {
        let xDist = (p2.x - p1.x);
        let yDist = (p2.y - p1.y);
        return sqrt((xDist * xDist) + (yDist * yDist));
    }
    class func normal(vector: CGVector) -> CGVector {
        let mag = sqrt(vector.dx * vector.dx + vector.dy * vector.dy)
        return CGVectorMake(vector.dx / mag, vector.dy / mag)
    }
    // Standard math extension
    class func NumberWithinBounds(value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
        if value < min {
            return min
        } else if value > max {
            return max
        } else {
            return value
        }
    }
    // Collision detection
    class func SortCollisionBodies(contact: SKPhysicsContact) -> (bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        // Sort bodies by category bit
        var bodyA: SKPhysicsBody
        var bodyB: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            bodyA = contact.bodyA
            bodyB = contact.bodyB
        } else {
            bodyA = contact.bodyB
            bodyB = contact.bodyA
        }
        
        return (bodyA, bodyB)
    }
}