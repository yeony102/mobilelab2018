//
//  ViewController.swift
//  Final
//
//  Created by Yeonhee Lee on 4/24/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

let ALBUM_TITLE = "Photonote"

struct PhotoNote: Codable {
        let imageId: String
        var label: String
        var date: String
        var textnote: String?
}

class CameraViewController: UIViewController {
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        createAlbum()
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }

    // MARK: Setting up the camera
    
    func createAlbum() {
        let library = PHPhotoLibrary.shared()
        
        // Make sure this app has permission to access the library
        PHPhotoLibrary.requestAuthorization { authorizationStatus in
            print("Authorized to access the user's library", authorizationStatus)
            
            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "title = %d", argumentArray: [ALBUM_TITLE])
            
            let myAlbum = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: options)
            
            print("Found my album?", myAlbum)
            
            // Create an album if it doesn't exist
            if(myAlbum.count == 0) {
                library.performChanges({
                    PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: ALBUM_TITLE)
                }) { (success, error) in
                    print("Succeed in creating a new album?", success)
                }
            }
        }
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }

    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }

    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    // Take a picture
    @IBAction func cameraButton_touchUpInside(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotoSegue" {
            let reviewVC = segue.destination as! ReviewViewController
            reviewVC.image = self.image
        }
    }
 
    
    // when the Photonotes button on the top left corner is tapped, present the image lists (PhotonotesTableViewController)
    @IBAction func photonotes_touchUpInside(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let photonoteTVC = storyboard.instantiateViewController(withIdentifier: "PhotonotesTableViewController") as? PhotonotesTableViewController else {
            print("Error initiating PhotonotesTableViewController")
            return
        }
    
        let nc = UINavigationController(rootViewController: photonoteTVC)
        
        present(nc, animated: true, completion: nil)
        
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhotoSegue", sender: nil)
        }
    }
}

