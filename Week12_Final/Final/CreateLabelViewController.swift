//
//  ActionViewController.swift
//  Final
//
//  Created by Yeonhee Lee on 4/25/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import Photos

let photonoteArrayKey = "PHOTONOTES"

class CreateLabelViewController: UIViewController {
    
    var photonoteArray = [PhotoNote]()
    
    let library = PHPhotoLibrary.shared()
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var labelTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    
    var image: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get data from user defaults and set data array
        if let photonotes = UserDefaults.standard.value(forKey: photonoteArrayKey) as? Data {
            let phtonoteArr = try? PropertyListDecoder().decode(Array<PhotoNote>.self, from: photonotes)
            
            self.photonoteArray = phtonoteArr!
        }
        
        // Styles
        cardView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        cardView.layer.shadowRadius = 1.5
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.cornerRadius = 5

    }
    
    @IBAction func cancel_touchUpInside(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func save_touchUpInside(_ sender: UIButton) {
        
        if labelTextField.text != "" {
            
            let lbl = labelTextField.text!
            
            // Get the string in the Note field
            let txtNote: String!
            if self.noteTextField.text == "Description" {
                txtNote = "No description"
            } else if self.noteTextField.text == "" {
                txtNote = "No description"
            } else {
                txtNote = self.noteTextField.text
            }
            
            // Make sure this app has a permission to access the library
            // Make sure we have permission to access the library
            PHPhotoLibrary.requestAuthorization { authorizationStatus in
                print("This app is authorized to access the user's library", authorizationStatus)
                
                let options = PHFetchOptions()
                options.predicate = NSPredicate(format: "title = %d", argumentArray: [ALBUM_TITLE])
                
                guard let myAlbum = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: options).firstObject else {
                    print("COULD NOT FIND ALBUM!")
                    return
                }
                
                self.library.performChanges({
                    let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
                    let imagePlaceholder = creationRequest.placeholderForCreatedAsset
                    
                    let imageId = imagePlaceholder?.localIdentifier
                    
                    // save the image to the photo library
                    guard let addAssetRequest = PHAssetCollectionChangeRequest(for: myAlbum) else {
                        print("Failed to make a reqeust to add the new photo to the album")
                        return
                    }
                    
                    addAssetRequest.addAssets([imagePlaceholder!] as NSArray)
                    
                    // Get current time and date.
                    let dateString = NSDate().description
                    
                    // User Defaults
                    let pnote = PhotoNote(imageId: imageId!, label: lbl, date: dateString, textnote: txtNote)
                    
                    self.photonoteArray.append(pnote)
//                    self.labelArray.append(lbl)
                    
                    // Save arrays into User Defaults
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(self.photonoteArray), forKey: photonoteArrayKey)
                    
//                    UserDefaults.standard.set(try? PropertyListEncoder().encode(self.labelArray), forKey: labelArrayKey)
                    
                }) { (success, error) in
                    print("Did succeed saving the photo to the album?", success, error)
                }
            }
            
            // Go back to CameraViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let cameraVC = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController else {
                print("Error instantiating CameraViewController")
                return
            }
            
            present(cameraVC, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Empty Label", message: "Please name the new label", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .default) { (action) in
                print("ALERT CLOSED")
            }
            
            alert.addAction(actionOK)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // This doesn't work 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismisses keyboard when done is pressed.
        view.endEditing(true)
        return false
    }
    
}
