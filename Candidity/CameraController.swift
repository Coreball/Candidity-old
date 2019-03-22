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
    var livePhotoMode = false
    
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
        let captureIsLivePhoto = livePhotoMode && photoOutput.isLivePhotoCaptureSupported
        photoOutput.isLivePhotoCaptureEnabled = photoOutput.isLivePhotoCaptureSupported
        
        if photoOutput.availablePhotoCodecTypes.contains(.hevc) { // Use the fancy codec if available
            photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
        } else {
            photoSettings = AVCapturePhotoSettings()
        }
        print("Live Photos Supported:  \(photoOutput.isLivePhotoCaptureSupported)")
        if captureIsLivePhoto { // If live photos is on use it
            print("Capture is a live photo")
            let livePhotoMovieName = NSUUID().uuidString
            let livePhotoMoviePath = (NSTemporaryDirectory() as NSString).appendingPathComponent((livePhotoMovieName as NSString).appendingPathExtension("mov")!)
            photoSettings.livePhotoMovieFileURL = URL(fileURLWithPath: livePhotoMoviePath)
        }
        print("Live Photo URL:  \(photoSettings.livePhotoMovieFileURL)")
        
        photoSettings.flashMode = .auto // Later add status indicators for live(enabled/inuse)/flash/recording
        photoSettings.isAutoStillImageStabilizationEnabled = photoOutput.isStillImageStabilizationSupported
        
        let captureProcessor = CaptureProcessor(isLivePhoto: captureIsLivePhoto)
        photoOutput.capturePhoto(with: photoSettings, delegate: captureProcessor)
        print("Shot Photo")
    }
    
}
