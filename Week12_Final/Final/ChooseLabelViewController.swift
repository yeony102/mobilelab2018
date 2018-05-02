//
//  ChooseLabelViewController.swift
//  Final
//
//  Created by Yeonhee Lee on 4/25/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit

private let reuseIdentifier = "LabelListCell"
let photonoteArrayKey = "PHOTONOTES"
let labelArrayKey = "LABELS"

class ChooseLabelViewController: UITableViewController {
    var image: UIImage!
    
    var photonoteArray = [PhotoNote]()
    var labelArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get data from user defaults and set data array
        if let photonotes = UserDefaults.standard.value(forKey: photonoteArrayKey) as? Data {
            let phtonoteArr = try? PropertyListDecoder().decode(Array<PhotoNote>.self, from: photonotes)
            
            self.photonoteArray = phtonoteArr!
        }
        
        if let labels = UserDefaults.standard.value(forKey: labelArrayKey) as? Data {
            let labelArr = try? PropertyListDecoder().decode(Array<String>.self, from: labels)
            self.labelArray = labelArr!
            
            self.tableView.reloadData()
        }
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
        
        let label = self.labelArray[indexPath.row]
        
        cell.label.text = label
        
        return cell
    }
    
    @IBAction func cancel_tapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add_tapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let createLabelVC = storyboard.instantiateViewController(withIdentifier: "CreateLabelViewController") as? CreateLabelViewController else {
            print("Error instantiating CreateLabelViewController")
            return
        }
        
        createLabelVC.photonoteArray = self.photonoteArray
        createLabelVC.labelArray = self.labelArray
        createLabelVC.image = self.image
        
        present(createLabelVC, animated: true, completion: nil)
        
    }
    
    
}
