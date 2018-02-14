//
//  SecondViewController.swift
//  Week03
//
//  Created by Yeonhee Lee on 2/13/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {

    let randomize = true
    let arraySize = 7
    
    let exp_possibility = [0, 0, 0, 0, 0, 0, 1]
    let soundFileName = "bomb"
    
    let bgColour01 = UIColor(red:1.00, green:0.94, blue:0.16, alpha:1.0)
    let bgColour02 = UIColor(red:0.96, green:0.58, blue:0.14, alpha:1.0)
    let bgColour03 = UIColor(red:0.95, green:0.34, blue:0.34, alpha:1.0)

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    var player: AVAudioPlayer?
    
    var currentIndex = 0
    var normalState = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
//        updateContent()
//    }
    
    @IBAction func handleTouchDown(_ sender: UIButton) {
        img.image = UIImage(named: "bomb02.png")
        view.backgroundColor = bgColour02
    }
    
    @IBAction func handleTouchUp(_ sender: UIButton) {
        updateContent()
    }
    
    func updateContent() {
        // Update content index.,
        nextIndex()
        
        // Update image if string is not empty
        if exp_possibility[currentIndex] == 0 {
            img.image = UIImage(named: "bomb01.png")
            view.backgroundColor = bgColour01
        } else {
            img.image = UIImage(named: "bomb03.png")
            view.backgroundColor = bgColour03
             // Play sound.
            playSoundMP3(filename: soundFileName)
        }
    }
    
    // Either increment index or randomize.
    func nextIndex() {
        
        if (currentIndex == arraySize-1) {
            currentIndex = 0
        }
        else {
            currentIndex = Int(arc4random_uniform(UInt32(arraySize)))
//            if(currentIndex < arraySize-1) {
//                if(normalState==0) {
//                    currentIndex = 1
//                    normalState = 1
//                }
//                else {
//                    currentIndex = 0
//                    normalState = 0
//                }
//            }
        }
        
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
    
    @IBAction func handleBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
