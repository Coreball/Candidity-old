//
//  ViewController.swift
//  Candidity
//
//  Created by Changyuan Lin on 3/17/19.
//  Copyright © 2019 Changyuan Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var oneTouchGesture: UITapGestureRecognizer!
    @IBOutlet var twoTouchGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func oneTouch(_ sender: UITapGestureRecognizer) {
        print("ABDSUHFE")
    }
    
    @IBAction func twoTouch(_ sender: UITapGestureRecognizer) {
        print("ABCSD")
    }
    
}

