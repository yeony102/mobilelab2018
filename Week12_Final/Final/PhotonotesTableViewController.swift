//
//  PhotonotesTableViewController.swift
//  Final
//
//  Created by Yeonhee Lee on 4/28/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "PhotonotesTableCell"
private let filename = "IMG_0057.PNG"   // temporary image

class PhotonotesTableViewController: UITableViewController {
    
    var photonoteArray = [PhotoNote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get data from user defaults and set data array
        if let photonotes = UserDefaults.standard.value(forKey: photonoteArrayKey) as? Data {
            let phtonoteArr = try? PropertyListDecoder().decode(Array<PhotoNote>.self, from: photonotes)
            
            self.photonoteArray = phtonoteArr!
        }
        
    }
    
    // When the camera button on the top left corner is tapped, go back to the previous screen (CameraViewController)
    @IBAction func camera_tapped(_ sender: UIBarButtonItem) {

        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the row data count.
        return photonoteArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get custom cell object.
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PhotonotesTableCell
        
        let pnote = photonoteArray[indexPath.row]
        
        cell.thumbnail.image = UIImage(named: filename)
        cell.label.text = pnote.label
        cell.date.text = pnote.date
        
        return cell
    }
    
    // When a row is selected, show the full image (FullViewController)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let pnote = photonoteArray[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let fullVC = storyboard.instantiateViewController(withIdentifier: "FullViewController") as? FullViewController else {
            print("Error instantiating FullViewController")
            return
        }
        
//        print(filename)
//        print(pnote.label)
//        print(pnote.textnote!)
        
        fullVC.image = UIImage(named: filename)
        fullVC.label = pnote.label
        fullVC.txtNote = pnote.textnote!

        
        present(fullVC, animated: true, completion: nil)
    }
    
}
