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
}