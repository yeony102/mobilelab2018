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
    
    var image: UIImage!
    var label: String!
    var txtNote: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply the image and the label from the previous view controller(PhotonotesTableViewController) to this view controllers UIImageView and UILabel
        imageView.image = self.image
        titleLable.text = self.label
    }
    
    // Go back to the previous screen (PhotonotesTableViewController)
    @IBAction func back_touchUpInside(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

//    @IBAction func note_touchUpInside(_ sender: UIButton) {
//    }
    
}
