//
//  ViewController.swift
//  Week03
//
//  Created by Yeonhee Lee on 2/13/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var key_b3: UIButton!
    @IBOutlet weak var key_c4: UIButton!
    @IBOutlet weak var key_c4s: UIButton!
    @IBOutlet weak var key_d4: UIButton!
    @IBOutlet weak var key_d4s: UIButton!
    @IBOutlet weak var key_e4: UIButton!
    @IBOutlet weak var key_f4: UIButton!
    @IBOutlet weak var key_f4s: UIButton!
    @IBOutlet weak var key_g4: UIButton!
    @IBOutlet weak var key_g4s: UIButton!
    @IBOutlet weak var key_a4: UIButton!
    @IBOutlet weak var key_a4s: UIButton!
    @IBOutlet weak var key_b4: UIButton!
    @IBOutlet weak var key_c5: UIButton!
    
    @IBOutlet weak var lbl: UIImageView!
    
    // Unlock Sequence
    let lockPattern = [1,1,8,8,10,10,8]
    
    // Array to capture input from button taps.
    var inputPattern = [Int]()
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
        resetScreen()

    }
    
    func resetScreen() {
        // Initialize status label.
 //       lbl.isHidden = false
        lbl.image = UIImage(named: "label_star.png")
        
        // Reset button is initially hidden.
   //     btn_reset.isHidden = true
        
        // Flush input pattern.
        inputPattern.removeAll()
    }
    
    // Logic for different stages of the input sequence.
    func processInputPattern(inputNumber: Int) {
        
        // Append passed in inputNumber into input pattern array.
        inputPattern.append(inputNumber)
        for input in inputPattern {
            print(input)
        }
        
        // Check where we are in the sequence by inspecting array count.
        if inputPattern.count == 7 {
            
            // Check if pattern matches or need to try again.
            if inputPattern == lockPattern {
                // connect to second view controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
                
                resetScreen()

                self.present(secondViewController, animated: true, completion: nil)
       
            } else {
                // Update status message.
                lbl.image = UIImage(named: "label_fail.png")
                
                // Flush input pattern.
                inputPattern.removeAll()
            }
        }
        
    }

    @IBAction func pressB3(_ sender: UIButton) {
        key_b3.setImage(UIImage(named: "whitep.png"), for: UIControlState.normal)
        playSoundMP3(filename: "b3")
        lbl.image = UIImage(named: "label_b3.png")
    }
    
    @IBAction func releaseB3(_ sender: UIButton) {
        key_b3.setImage(UIImage(named: "white.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 0)
    }
    
    @IBAction func pressC4(_ sender: UIButton) {
        key_c4.setImage(UIImage(named: "whitep.png"), for: UIControlState.normal)
        playSoundMP3(filename: "c4")
        lbl.image = UIImage(named: "label_c4.png")
    }
    
    @IBAction func releaseC4(_ sender: UIButton) {
        key_c4.setImage(UIImage(named: "white.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 1)
    }
    
    @IBAction func pressC4s(_ sender: UIButton) {
        key_c4s.setImage(UIImage(named: "blackp.png"), for: UIControlState.normal)
        playSoundMP3(filename: "c4s")
        lbl.image = UIImage(named: "label_c4s.png")
    }
    
    @IBAction func releaseC4s(_ sender: UIButton) {
        key_c4s.setImage(UIImage(named: "black.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 2)
    }
    
    @IBAction func pressD4(_ sender: UIButton) {
        key_d4.setImage(UIImage(named: "whitep.png"), for: UIControlState.normal)
        playSoundMP3(filename: "d4")
        lbl.image = UIImage(named: "label_d4.png")
    }
    
    @IBAction func releaseD4(_ sender: UIButton) {
        key_d4.setImage(UIImage(named: "white.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 3)
    }
    
    @IBAction func pressD4s(_ sender: UIButton) {
        key_d4s.setImage(UIImage(named: "blackp.png"), for: UIControlState.normal)
        playSoundMP3(filename: "d4s")
        lbl.image = UIImage(named: "label_d4s.png")
    }
    
    @IBAction func releaseD4s(_ sender: UIButton) {
        key_d4s.setImage(UIImage(named: "black.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 4)
    }
    
    @IBAction func pressE4(_ sender: UIButton) {
        key_e4.setImage(UIImage(named: "whitep.png"), for: UIControlState.normal)
        playSoundMP3(filename: "e4")
        lbl.image = UIImage(named: "label_e4.png")
    }
    
    @IBAction func releaseE4(_ sender: UIButton) {
        key_e4.setImage(UIImage(named: "white.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 5)
    }
    
    @IBAction func pressF4(_ sender: UIButton) {
        key_f4.setImage(UIImage(named: "whitep.png"), for: UIControlState.normal)
        playSoundMP3(filename: "f4")
        lbl.image = UIImage(named: "label_f4.png")
    }
    
    @IBAction func releaseF4(_ sender: UIButton) {
        key_f4.setImage(UIImage(named: "white.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 6)
    }
    
    @IBAction func pressF4s(_ sender: UIButton) {
        key_f4s.setImage(UIImage(named: "blackp.png"), for: UIControlState.normal)
        playSoundMP3(filename: "f4s")
        lbl.image = UIImage(named: "label_f4s.png")
    }
    
    @IBAction func releaseF4s(_ sender: UIButton) {
        key_f4s.setImage(UIImage(named: "black.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 7)
    }
    
    @IBAction func pressG4(_ sender: UIButton) {
        key_g4.setImage(UIImage(named: "whitep.png"), for: UIControlState.normal)
        playSoundMP3(filename: "g4")
        lbl.image = UIImage(named: "label_g4.png")
    }
    
    @IBAction func releaseG4(_ sender: UIButton) {
        key_g4.setImage(UIImage(named: "white.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 8)
    }
    
    @IBAction func pressG4s(_ sender: UIButton) {
        key_g4s.setImage(UIImage(named: "blackp.png"), for: UIControlState.normal)
        playSoundMP3(filename: "g4s")
        lbl.image = UIImage(named: "label_g4s.png")
    }
    
    @IBAction func releaseG4s(_ sender: UIButton) {
        key_g4s.setImage(UIImage(named: "black.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 9)
    }
    
    @IBAction func pressA4(_ sender: UIButton) {
        key_a4.setImage(UIImage(named: "whitep.png"), for: UIControlState.normal)
        playSoundMP3(filename: "a4")
        lbl.image = UIImage(named: "label_a4.png")
    }
    
    @IBAction func releaseA4(_ sender: UIButton) {
        key_a4.setImage(UIImage(named: "white.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 10)
    }
    
    @IBAction func pressA4s(_ sender: UIButton) {
        key_a4s.setImage(UIImage(named: "blackp.png"), for: UIControlState.normal)
        playSoundMP3(filename: "a4s")
        lbl.image = UIImage(named: "label_a4s.png")
    }
    
    @IBAction func releaseA4s(_ sender: UIButton) {
        key_a4s.setImage(UIImage(named: "black.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 11)
    }
    
    @IBAction func pressB4(_ sender: UIButton) {
        key_b4.setImage(UIImage(named: "whitep.png"), for: UIControlState.normal)
        playSoundMP3(filename: "b4")
        lbl.image = UIImage(named: "label_b4.png")
    }
    
    @IBAction func releaseB4(_ sender: UIButton) {
        key_b4.setImage(UIImage(named: "white.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 12)
    }
    
    @IBAction func pressC5(_ sender: UIButton) {
        key_c5.setImage(UIImage(named: "whitep.png"), for: UIControlState.normal)
        playSoundMP3(filename: "c5")
        lbl.image = UIImage(named: "label_c5.png")
    }
    
    @IBAction func releaseC5(_ sender: UIButton) {
        key_c5.setImage(UIImage(named: "white.png"), for: UIControlState.normal)
        processInputPattern(inputNumber: 13)
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

