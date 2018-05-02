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
    
    @IBAction func next_touchUpInside(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let chooseLabelTVC = storyboard.instantiateViewController(withIdentifier: "ChooseLabelTableViewController") as? ChooseLabelTableViewController else {
            print("Error instantiating CreateViewController")
            return
        }
        chooseLabelTVC.image = self.image
        
        let nc = UINavigationController(rootViewController: chooseLabelTVC)
        
        present(nc, animated: true, completion: nil)
    
    }
}
