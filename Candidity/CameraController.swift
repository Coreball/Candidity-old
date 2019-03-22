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
    let photoOutput = AVCapturePhotoOutput()
    
    func prepare() {
        captureSession.beginConfiguration()
        let videoDevice = AVCaptureDevice.default(for: .video)
//        guard let videoInput = try? AVCaptureDeviceInput(device: videoDevice!),
//            captureSession.canAddInput(videoInput) else {
//                return
//        }
        // Use if statements and not guards b/c video/audio isn't strictly required?
        // Like you don't neeeeeed audio, but camera functionality should still work
        if let videoInput = try? AVCaptureDeviceInput(device: videoDevice!), captureSession.canAddInput(videoInput){
            captureSession.addInput(videoInput)
        }
        let audioDevice = AVCaptureDevice.default(for: .audio)
        if let audioInput = try? AVCaptureDeviceInput(device: audioDevice!), captureSession.canAddInput(audioInput) {
            captureSession.addInput(audioInput)
        }
        photoOutput.isHighResolutionCaptureEnabled = true
//        photoOutput.isLivePhotoCaptureEnabled = photoOutput.isLivePhotoCaptureSupported
        guard captureSession.canAddOutput(photoOutput) else {
            return
        }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        // Add movie stuff later
        captureSession.commitConfiguration()
        captureSession.startRunning()
    }
    
    func shootPhoto() {
        let photoSettings: AVCapturePhotoSettings
        if photoOutput.availablePhotoCodecTypes.contains(.hevc) {
            photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
        } else {
            photoSettings = AVCapturePhotoSettings()
        }
        photoSettings.flashMode = .auto // Later add status indicators for live(enabled/inuse)/flash/recording
        photoSettings.isAutoStillImageStabilizationEnabled = photoOutput.isStillImageStabilizationSupported
        
    }
    
}
