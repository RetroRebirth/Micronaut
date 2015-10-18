//
//  ViewController.swift
//  platformer
//
//  Created by Christopher Williams on 10/17/15.
//  Copyright © 2015 Christopher Williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var test: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        test.center.x = view.bounds.width / 2
        test.center.y = view.bounds.height / 2
        test.backgroundColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

