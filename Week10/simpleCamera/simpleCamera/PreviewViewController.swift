//
//  PreviewViewController.swift
//  simpleCamera
//
//  Created by Yeonhee Lee on 4/7/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import Photos

struct MyImage {
    let imageId: String
    var tags: [String] = []
    let voiceId: String?
    var text: String?
}

class PreviewViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    var image: UIImage!
    
    let library = PHPhotoLibrary.shared()
    let myAlbumTitle = "test"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image
    }

    @IBAction func cancelBtn_touchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn_touchUpInside(_ sender: Any) {
        // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // Make sure we have permission to access the library
        PHPhotoLibrary.requestAuthorization { authorizationStatus in
            print("We are authorized to access the user's library", authorizationStatus)
            
            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "title = %d", argumentArray: [self.myAlbumTitle])
            
            guard let myAlbum = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: options).firstObject else {
                print("COULD NOT FIND ALBUM!")
                return
            }
            
            self.library.performChanges({
                
                let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
                
                let imagePlaceholder = creationRequest.placeholderForCreatedAsset
                let imageId = imagePlaceholder?.localIdentifier
                
                
                
                let myNewImage = MyImage(imageId: imageId!, tags: [], voiceId: "", text: "")
                
                let myData: NSDictionary = [
                    "imageId": imageId,
                    "text": "asdjlaskdlkasdlkas"
                ]
                
                
                
                
                // Save myImage
                // userDefault
                // NSDitionary
                
                
                guard let addAssetRequest = PHAssetCollectionChangeRequest(for: myAlbum) else {
                    print("Could not make request to add new photo to album")
                    return
                }
                
                addAssetRequest.addAssets([creationRequest.placeholderForCreatedAsset!] as NSArray)
               
            }) { (success, error) in
                print("Success saving photo to album?", success, error)
            }
        }
        
        // UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Did finish saving image")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
