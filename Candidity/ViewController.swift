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
    
    let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        switch (AVCaptureDevice.authorizationStatus(for: .video),
                AVCaptureDevice.authorizationStatus(for: .audio)){
            case (.authorized, .authorized):  // User already authorized camera access
                print("Already authorized!")
            case (.notDetermined, .authorized):  // User not yet asked for camera access
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        print("Video granted")
                    }
                }
            case (.authorized, .notDetermined):
                AVCaptureDevice.requestAccess(for: .audio) { granted in
                    if granted {
                        print("Audio granted")
                    }
                }
            case (.notDetermined, .notDetermined):
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        print("Video granted")
                    }
                }
                AVCaptureDevice.requestAccess(for: .audio) { granted in
                    if granted {
                        print("Audio granted")
                    }
                }
            default:
                print("Either video or audio was not allowed!")
        }
    }
    
    // What happens if we begin setting up before permissions are granted?
    // Perhaps add a preview to test
    
    func setupCaptureSession() {
        captureSession.beginConfiguration()
        let videoDevice = AVCaptureDevice.default(for: .video)
        guard
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!),
            captureSession.canAddInput(videoDeviceInput)
            else { return }
        captureSession.addInput(videoDeviceInput)
    }

    @IBAction func oneTouch(_ sender: UITapGestureRecognizer) {
        print("ABDSUHFE")
    }
    
    @IBAction func twoTouch(_ sender: UITapGestureRecognizer) {
        print("ABCSD")
    }
    
}

