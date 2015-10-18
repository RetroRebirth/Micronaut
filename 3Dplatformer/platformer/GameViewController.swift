//
//  GameViewController.swift
//  platformer
//
//  Created by Christopher Williams on 10/17/15.
//  Copyright (c) 2015 Christopher Williams. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 15)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.darkGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        let box = scene.rootNode.childNodeWithName("box", recursively: true)!
        
        // animate the 3d object
        box.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 1, z: 0, duration: 1)))
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
//        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.blackColor()
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        var gestureRecognizers = [UIGestureRecognizer]()
        gestureRecognizers.append(tapGesture)
        
        // add a swipe gesture recognizer
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRecognizer.direction = .Right // TODO recognize left gesture
        gestureRecognizers.append(swipeRecognizer)
        
        // attach interaction listeners
        if let existingGestureRecognizers = scnView.gestureRecognizers {
            gestureRecognizers.appendContentsOf(existingGestureRecognizers)
        }
        scnView.gestureRecognizers = gestureRecognizers
    }
    
    // Box jumps when remote is tapped
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // retrieve box object
        let box = scnView.scene!.rootNode.childNodeWithName("box", recursively: true)!
        
        // movement variables
        let time = 0.3
        let speed : CGFloat = 5
        
        // hacky jumping animation. TODO use CABasicAnimation?
        if box.position.y <= 0 {
            box.runAction(SCNAction.moveByX(0, y: speed, z: 0, duration: time), completionHandler: {
                () in
                box.runAction(SCNAction.moveByX(0, y: -speed, z: 0, duration: time))
            })
        }
    }
    
    func swiped(gestureRecognizer: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // retrieve box object
        let box = scnView.scene!.rootNode.childNodeWithName("box", recursively: true)!
        
        // movement variables
        let speed : CGFloat = 3
        
        // move right
        box.runAction(SCNAction.repeatActionForever(SCNAction.moveByX(speed, y: 0, z: 0, duration: 1)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
