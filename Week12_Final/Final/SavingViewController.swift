//
//  savingViewController.swift
//  Final
//
//  Created by Yeonhee Lee on 4/25/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "LabelListCell"
let photonoteArrayKey = "PHOTONOTES"
let labelArrayKey = "LABELS"


class SavingViewController: UITableViewController {
    
    var photonoteArray = [PhotoNote]()
    var labelArray = [String]()
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var textnote: UITextField!
  
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbnail.image = self.image
        
        // Get data from user defaults and set data array
        if let photonotes = UserDefaults.standard.value(forKey: photonoteArrayKey) as? Data {
            let phtonoteArr = try? PropertyListDecoder().decode(Array<PhotoNote>.self, from: photonotes)
            
            self.photonoteArray = phtonoteArr!
        }
        
        if let labels = UserDefaults.standard.value(forKey: labelArrayKey) as? [String] {
//            let labelArr = try? PropertyListDecoder().decode(Array<String>.self, from: labels)
//            self.labelArray = labelArr
            self.labelArray = labels
            
            self.tableView.reloadData()
        }
    }
    
    @IBAction func cancel_touchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add_tapped(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let createLabelVC = storyboard.instantiateViewController(withIdentifier: "CreateLabelViewController") as? CreateLabelViewController else {
            print("Error instantiating createLabelViewController")
            return
        }
        
        createLabelVC.image = self.image
        createLabelVC.photonoteArray = self.photonoteArray
        createLabelVC.labelArray = self.labelArray
        
        if self.textnote.text != nil {
            createLabelVC.textnote = self.textnote.text
        }
        
        // createLabelVC.modalTransitionStyle = .flipHorizontal
        
        present(createLabelVC, animated: true, completion: nil)
    }
    
    // Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get custom cell object
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LabelListCell
        
        let label = labelArray[indexPath.row]
        
        cell.label.text = label
        
        return cell
    }
    
}
