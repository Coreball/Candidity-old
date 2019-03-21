//
//  CameraController.swift
//  Candidity
//
//  Created by Changyuan Lin on 3/21/19.
//  Copyright © 2019 Changyuan Lin. All rights reserved.
//

import Foundation
import AVFoundation

class CameraController {
    
    let captureSession = AVCaptureSession()
    
    func prepare() {
        captureSession.beginConfiguration()
        let videoDevice = AVCaptureDevice.default(for: .video)
        guard let videoInput = try? AVCaptureDeviceInput(device: videoDevice!),
            captureSession.canAddInput(videoInput) else {
                return
        }
        captureSession.addInput(videoInput)
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else {
            return
        }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        // Add movie and audio stuff later
        captureSession.commitConfiguration()
        captureSession.startRunning()
    }
    
}
