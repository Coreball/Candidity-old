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
    
    override func viewDidAppear(_ animated: Bool) {
        showInfoMessage()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func showInfoMessage() {
        let message = """
            A Minimalist Camera App

            One Finger Tap - Photo
            Two Finger Tap - Video
            """
        let alert = UIAlertController(title: "Candidity", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Let's Go!", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func videoPreview() {
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: cameraControl.captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
    }

    @IBAction func oneTouch(_ sender: UITapGestureRecognizer) {
        print("One Finger Tap Photo")
        cameraControl.shootPhoto()
    }
    
    @IBAction func twoTouch(_ sender: UITapGestureRecognizer) {
        print("ABCSD")
    }
    
}

