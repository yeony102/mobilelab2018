//
//  reviewViewController.swift
//  Final
//
//  Created by Yeonhee Lee on 4/25/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import Photos

class ReviewViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image
    }
    
    @IBAction func cancel_touchUpInside(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // When the Next button on the top right corner is tapped, present the Create Label screen (CreateLabelViewController)
    @IBAction func next_touchUpInside(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let createLabelVC = storyboard.instantiateViewController(withIdentifier: "CreateLabelViewController") as? CreateLabelViewController else {
            print("Error instantiating CreateViewController")
            return
        }
        createLabelVC.image = self.image
        
        present(createLabelVC, animated: true, completion: nil)
    
    }
}
