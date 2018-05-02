//
//  ViewController.swift
//  photoGallery
//
//  Created by Yeonhee Lee on 4/11/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate { // inherit the delegates in order to use the navigation controller and collection views

    // create variables for the collection view and the image array
    var myCollectionView: UICollectionView!  // it is gonna take up the whole screen
    var imageArray = [UIImage]()  // it will contain all the images from the photo library
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photos"   // this title will be shown on the navigation bar
        
        let layout = UICollectionViewFlowLayout()   // declare the layout for the collection view. This is needed to initialize the collection view
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout) // set the view to take up the whole screen
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: "Cell") // register the cell to be used to this collection view
        //myCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(myCollectionView)
        
        // make the width and height of the collection view flexible so that it can conform with to the bounds of the screen when it is rotated
        myCollectionView.autoresizingMask = UIViewAutoresizing(rawValue:
            UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) |
            UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        
        grabPhotos()
    }
    
    // it counts how many items will be in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoItemCell
        cell.img.image = imageArray[indexPath.item] // get the cell image and then assign the image from the imageArray
        return cell
    }
    
    // when a user selects an item in the collection view...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let vc = ImagePreviewVC()
        vc.imgArray = self.imageArray   // pass the imageArray to the imgArray variable in the next view controller
        vc.passedContentOffset = indexPath // also pass the IndexPath which was clickled here to the passedContentOffset variable in the next view controller
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        if DeviceInfo.Orientation.isPortrait {  // if the device orientation is portrait
            return CGSize(width: width/4-1, height: width/4-1)  // we are gonna have 4 photos in a row
        } else {    // otherwise,
            return CGSize(width: width/6-1, height: width/6-1) // we are gonna have 6 photos in a row
        }
    }
    
    // it is called when the view is first loaded and when the device orientation is changed (layout changes to conform to the orientation)
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    // collection view delegate: consents to minimum line spacing for section item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0 // we will have 1.0 point of space between the rows
    }
    
    // collection view delegate: consents to minimum inter item spacing for section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0  // we will have 1.0 point of space between the columns
    }
    
    func grabPhotos() {
        imageArray = []
        
        // fetch the photos in the background so that the main query is not blocked -> ???????
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            let imgManager = PHImageManager.default()
            
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            requestOptions.deliveryMode = .highQualityFormat
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
            
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            print(fetchResult)
            print(fetchResult.count)
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count {
                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
                        self.imageArray.append(image!)  // fill the imageArray with the images retrieved
                    })
                }
            } else {
                print("You've got no photos.")
            }
            print("imageArray count: \(self.imageArray.count)")
            
            // then go to the main and reload the collection view
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previews code in outer block.")
                self.myCollectionView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class PhotoItemCell: UICollectionViewCell {
    var img = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        self.addSubview(img)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the landscape orientation
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isLandscape
                : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        
        // indicate current device is in the portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isPortrait
                : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }
}
