//
//  ViewController.swift
//  Candidity
//
//  Created by Changyuan Lin on 3/17/19.
//  Copyright © 2019 Changyuan Lin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var oneTouchGesture: UITapGestureRecognizer!
    @IBOutlet var twoTouchGesture: UITapGestureRecognizer!
    
    let cameraControl = CameraController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cameraControl.prepare()
        videoPreview()
    }
    
    func videoPreview() {
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: cameraControl.captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
    }

    @IBAction func oneTouch(_ sender: UITapGestureRecognizer) {
        print("ABDSUHFE")
    }
    
    @IBAction func twoTouch(_ sender: UITapGestureRecognizer) {
        print("ABCSD")
    }
    
}

