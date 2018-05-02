//
//  reviewViewController.swift
//  Final
//
//  Created by Yeonhee Lee on 4/25/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import Photos

//struct PhotoNote: Codable {
//    let imageId: String
//    var label: String
//    var textnote: String?
//}

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
        guard let chooseLabelVC = storyboard.instantiateViewController(withIdentifier: "ChooseLabelViewController") as? ChooseLabelViewController else {
            print("Error instantiating CreateViewController")
            return
        }
        chooseLabelVC.image = self.image
        
        let nc = UINavigationController(rootViewController: chooseLabelVC)
        
        present(nc, animated: true, completion: nil)
    }
    
   
}
