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