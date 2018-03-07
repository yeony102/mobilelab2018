//
//  ViewController.swift
//  Week05
//
//  Created by Yeonhee Lee on 3/6/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // Real time camera capture session.
    var captureSession = AVCaptureSession()
    
    // References to camera devices.
    var backCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    // Track device orientation changes.
    var orientation: AVCaptureVideoOrientation = .portrait
    
    var motionManager = CMMotionManager()
    
    let stars = UIImageView(image: UIImage(named: "constellation.png"))

    @IBOutlet weak var filteredImage: UIImageView!
    
  
    @IBOutlet weak var instLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Camera device setup.
        setupDevice()
        setupInputOutput()
        
        stars.isHidden = true
        instLabel.isHidden = false
        self.view.addSubview(stars)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        motionManager.gyroUpdateInterval = 0.2
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data
            {
                if myData.rotationRate.x > 2.5 {
                    print ("Sky!!")
                    self.stars.isHidden = false
                    self.instLabel.isHidden = true
                }
                if myData.rotationRate.x < -2.5 {
                    print("Reset")
                    self.stars.isHidden = true
                    self.instLabel.isHidden = false
                }
            }
        }
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        // Set correct device orientation.
        connection.videoOrientation = orientation
        
        // Get pixel buffer.
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        var cameraImage = CIImage(cvImageBuffer: pixelBuffer!)
        
        
        // Get the filtered image if a currentFilter is set.
        var filteredImage: UIImage!
       
        filteredImage =  UIImage(ciImage: cameraImage)
       
        // Set image view outlet with filtered image.
        DispatchQueue.main.async {
            self.filteredImage.image = filteredImage
        }
    }


}

extension ViewController {
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes:
            [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    func setupInputOutput() {
        
        do {
            setupCorrectFramerate(currentCamera: currentCamera!)
            
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
            
            if captureSession.canAddInput(captureDeviceInput) {
                captureSession.addInput(captureDeviceInput)
            }
            
            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer delegate", attributes: []))
            
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            }
            
            captureSession.startRunning()
        } catch {
            print(error)
        }
    }
    
    func setupCorrectFramerate(currentCamera: AVCaptureDevice) {
        for vFormat in currentCamera.formats {
            var ranges = vFormat.videoSupportedFrameRateRanges as [AVFrameRateRange]
            let frameRates = ranges[0]
            do {
                //set to 240fps - available types are: 30, 60, 120 and 240 and custom
                // lower framerates cause major stuttering
                if frameRates.maxFrameRate == 240 {
                    try currentCamera.lockForConfiguration()
                    currentCamera.activeFormat = vFormat as AVCaptureDevice.Format
                    //for custom framerate set min max activeVideoFrameDuration to whatever you like, e.g. 1 and 180
                    currentCamera.activeVideoMinFrameDuration = frameRates.minFrameDuration
                    currentCamera.activeVideoMaxFrameDuration = frameRates.maxFrameDuration
                }
            }
            catch {
                print("Could not set active format")
                print(error)
            }
        }
    }

}

