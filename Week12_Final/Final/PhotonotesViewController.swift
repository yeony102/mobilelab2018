//
//  PhotonotesViewController.swift
//  Final
//
//  Created by Yeonhee Lee on 4/25/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

private let reuseIdentifier = "ExistingLabelListCell"

import UIKit
import Photos

class PhotonotesViewController: UITableViewController {
    
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
    
    @IBAction func camera_tapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
        
        ///////// need to add the count label !!!!
        //////// create an array for each label and pass them to the collection view via segue
        
        cell.label.text = label
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedRow = tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        print("Selected Table Row: \(selectedRow)")
        
         let labelCollectionVC = segue.destination as! LabelCollectionViewController
        
        
    }
}
