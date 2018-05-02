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

class PhotonotesTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var photonoteArray = [PhotoNote]()
    var currentPhotonoteArray = [PhotoNote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get data from user defaults and set data array
        if let photonotes = UserDefaults.standard.value(forKey: photonoteArrayKey) as? Data {
            let photonoteArr = try? PropertyListDecoder().decode(Array<PhotoNote>.self, from: photonotes)
            
            self.photonoteArray = photonoteArr!
            self.currentPhotonoteArray = photonoteArr!
        }
        
        setUpSearchBar()
        
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    
    // Go back to CameraViewController when the camera button is tapped
    @IBAction func camera_tapped(_ sender: UIBarButtonItem) {

        dismiss(animated: true, completion: nil)
    }
    

    // Search
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            currentPhotonoteArray = photonoteArray
            self.tableView.reloadData()
            return
        }
        currentPhotonoteArray = photonoteArray.filter({ pnote -> Bool in
//            guard let keyword = searchBar.text else { return false }
             pnote.label.lowercased().contains(searchText.lowercased())
        })
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the row data count.
        return currentPhotonoteArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get custom cell object.
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PhotonotesTableCell
        
        let pnote = currentPhotonoteArray[indexPath.row]
        
        cell.label.text = pnote.label
        cell.date.text = pnote.date
        
        // NL: Fetch asset using imageId, get thumbnail image and set to cell thumbnail.
        let results = PHAsset.fetchAssets(withLocalIdentifiers: [pnote.imageId], options: nil)
        if let phasset = results.firstObject {
            cell.thumbnail.image = getAssetThumbnail(asset: phasset)
        }
        
        return cell
    }
    
    // When a row is selected, show the full image (FullViewController)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let pnote = currentPhotonoteArray[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let fullVC = storyboard.instantiateViewController(withIdentifier: "FullViewController") as? FullViewController else {
            print("Error instantiating FullViewController")
            return
        }
   
//        print(pnote.label)
//        print(pnote.textnote!)
        
        // NL: Fetch asset using imageId, get full size image and set to imageView image.
        let results = PHAsset.fetchAssets(withLocalIdentifiers: [pnote.imageId], options: nil)
        if let phasset = results.firstObject {
            fullVC.image = getAssetFullImage(asset: phasset)
        }


        fullVC.label = pnote.label
        fullVC.txtNote = pnote.textnote!

        
        present(fullVC, animated: true, completion: nil)
    }
    
    // NL: Helper method to convert PHAsset to thumbnail UIImage
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()

        let option = PHImageRequestOptions()
        option.isSynchronous = true

        var thumbnail = UIImage()
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: option) { (image: UIImage?, _) in
            thumbnail = image!
        }
        return thumbnail
    }

    // NL: Helper method to convert PHAsset to full UIImage
    func getAssetFullImage(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()

        let option = PHImageRequestOptions()
        option.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        option.isSynchronous = true

        var fullImage = UIImage()
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: option) { (image: UIImage?, _) in
            fullImage = image!
        }
        return fullImage
    }

}
