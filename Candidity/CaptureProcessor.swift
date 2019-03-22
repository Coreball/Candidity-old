//
//  CaptureProcessor.swift
//  Candidity
//
//  Created by Changyuan Lin on 3/21/19.
//  Copyright © 2019 Changyuan Lin. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

class CaptureProcessor: NSObject, AVCapturePhotoCaptureDelegate {
    
    var stillImage: Data?
    let isLivePhoto: Bool!
    
    init(isLivePhoto: Bool) {
        self.isLivePhoto = isLivePhoto
        print("Photo is live: \(isLivePhoto)")
    }
    
    // None of these below are actually fired. What's up with that?
    // This object is instantiated correctly...
    
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("will begin capture!")
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("photo captured!")
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("about to capture!")
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        print("capture process complete")
    }
    
    // It never calls the below method
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            print("Error capturing photo: \(error!)")
            return
        }
        print("finished processing photo")
        print(photo.metadata)
        if isLivePhoto {
            stillImage = photo.fileDataRepresentation() // Save still image for combining later
        } else {
            savePhoto(stillImage: photo.fileDataRepresentation()!) // If not live, just save it
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingLivePhotoToMovieFileAt outputFileURL: URL, duration: CMTime, photoDisplayTime: CMTime, resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        guard error == nil else {
            print("Error capturing live photo: \(error!)")
            return
        }
        guard stillImage != nil else {
            print("Still image does not exist yet??")
            return
        }
        print("Live photo done processing")
        savePhoto(stillImage: stillImage!, livePhotoURL: outputFileURL)
    }
    
    func savePhoto(stillImage: Data) {
        PHPhotoLibrary.requestAuthorization{ status in
            guard status == .authorized else {
                return
            }
            PHPhotoLibrary.shared().performChanges({
                print("Saving photo")
                let creationRequest = PHAssetCreationRequest.forAsset()
                creationRequest.addResource(with: .photo, data: stillImage, options: nil) // Add photo
            }, completionHandler: nil)
        }
    }
    
    func savePhoto(stillImage: Data, livePhotoURL: URL) {
        PHPhotoLibrary.requestAuthorization{ status in
            guard status == .authorized else {
                return
            }
            PHPhotoLibrary.shared().performChanges({
                print("Saving live photo")
                let creationRequest = PHAssetCreationRequest.forAsset()
                creationRequest.addResource(with: .photo, data: stillImage, options: nil) // Add photo
                let options = PHAssetResourceCreationOptions()
                options.shouldMoveFile = true
                creationRequest.addResource(with: .pairedVideo, fileURL: livePhotoURL, options: options) // Then pair the video
            }, completionHandler: nil)
        }
    }
    
}
