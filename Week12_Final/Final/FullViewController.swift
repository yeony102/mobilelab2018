//
//  FullViewController.swift
//  Final
//
//  Created by Yeonhee Lee on 4/28/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import Photos

// Shows the full picture
class FullViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var noteButton: UIButton!
    
    @IBOutlet weak var noteBackgroundView: UIView!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var noteLabel: UILabel!
    
    var image: UIImage!
    var label: String!
    var txtNote: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply the image and the label passed from PhotonotesTableViewController
        imageView.image = self.image
        titleLable.text = self.label
 
        if self.txtNote == "No description" {
            noteButton.isEnabled = false
        } else {
            noteButton.isEnabled = true
            noteLabel.text = txtNote
        }
    }
    
    override func viewDidLayoutSubviews() {
        noteLabel.sizeToFit()
    }
    
    // Go back to the previous screen (PhotonotesTableViewController)
    @IBAction func back_touchUpInside(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func note_touchUpInside(_ sender: UIButton) {

        noteBackgroundView.isHidden = false
        noteView.isHidden = false
    }
    
    @IBAction func noteClose_touchUpInside(_ sender: UIButton) {
        noteView.isHidden = true
        noteBackgroundView.isHidden = true
    }
    
}
