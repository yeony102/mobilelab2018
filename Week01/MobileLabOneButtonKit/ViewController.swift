//
//  ViewController.swift
//  MobileLab1ButtonKit
//
//  Created by Nien Lam on 1/19/18.
//  Copyright © 2018 Mobile Lab. All rights reserved.
//  Modified by Yeonhee Lee 1/31/2018
//
//  Description:
//  View controller creating a one button application.

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // EDIT START ////////////////////////////////////////////////////////////////////////////////////////
    
    // Set to 'true' or 'false' to control content sequence.
    // Either flip through content in sequence or randomize.
    let randomize = true
    
    // Set to array size.
    // Make sure all arrays are the same length and matches array size.
    let arraySize = 7
    
    
    // Image name array.
    // Set to image name or set to empty string.
    let imageNameArray = ["img01.png",
                          "img02.png",
                          "",
                          "",
                          "",
                          "",
                          "img03.png"]
    
    // MP3 sound file array.
    // Set mp3 file name or set to empty string.
    let soundArray = ["",
                      "",
                      "",
                      "",
                      "",
                      "",
                      "bomb_explosion"]
    
    // EDIT END //////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////

    
    // Connected to storyboard UI elements.
//    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var player: AVAudioPlayer?

    var currentIndex = 0
    var normalState = 0
    
    // Initial setup function.
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: imageNameArray[currentIndex])
        
//        let tap = UILongPressGestureRecognizer(target: self, action: #selector(tapHandler))
//        tap.minimumPressDuration = 0
//        myView.addGestureRecognizer(tap)
        
//        let pan = UIPanGestureRecognizer(target: self, action: "pan:")
//        imageView.addGestureRecognizer(pan)
        //updateContent()
    }

    // Called when screen is tapped.
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        updateContent()
    }

//    @IBAction func tapHandler(gesture: UITapGestureRecognizer) {
//
//        // handle touch down and touch up events separately
//        if gesture.state == .began {
//            if(currentIndex < arraySize-1) {
//                imageView.image = UIImage(named: "img02.png")
//            }
//        } else if gesture.state == .ended { // optional for touch up event catching
//            if(currentIndex == arraySize-1) {
//                imageView.image = UIImage(named: "image01.png")
//                currentIndex = -1
//            }
//            else {
//                updateContent()
//            }
//        }
//    }
    
//    func pan(g : UIPanGestureRecognizer) {
//        switch g.state {
//        case .began:
//            if(currentIndex < arraySize-1) {
//                imageView.image = UIImage(named: "img02.png")
//            }
//        case .ended:
//            if(currentIndex == arraySize-1) {
//                imageView.image = UIImage(named: "image01.png")
//                currentIndex = -1
//            }
//            else {
//                updateContent()
//            }
//        default:
//            if(currentIndex < arraySize-1) {
//                imageView.image = UIImage(named: "img02.png")
//            }
//        }
//    }

    
    // Update content based on array content and current array index.
    func updateContent() {
        // Update content index.,
        nextIndex()

//        if (currentIndex == arraySize-1) {
//            imageView.image = UIImage(named: "img03.png")
//            generateImpactFeedback()
//            playSoundMP3(filename: "bomb_explosion")
//        }
//        else {
//            imageView.image = UIImage(named: "img01.png")
//        }
        
        // Update image if string is not empty
        if imageNameArray[currentIndex].isEmpty {
            imageView.image = nil
        } else {
            imageView.image = UIImage(named: imageNameArray[currentIndex])
        }

        // Play sound.
        if !soundArray[currentIndex].isEmpty {
            playSoundMP3(filename: soundArray[currentIndex])
        }
    }

    
    // Either increment index or randomize.
    func nextIndex() {
        if randomize {
            if (currentIndex == arraySize-1) {
                currentIndex = 0
            }
            else {
                currentIndex = Int(arc4random_uniform(UInt32(arraySize)))
                if(currentIndex < arraySize-1) {
                    if(normalState==0) {
                        currentIndex = 1
                        normalState = 1
                    }
                    else {
                        currentIndex = 0
                        normalState = 0
                    }
                }
            }
        } else {
            currentIndex = (currentIndex + 1 == arraySize) ? 0 : currentIndex + 1
        }
    }

    // Make the device vibrate.
    func generateImpactFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }

    // Play a mp3 sound file.
    func playSoundMP3(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    

}

