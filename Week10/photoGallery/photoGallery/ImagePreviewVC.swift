//
//  ImagePreviewVC.swift
//  photoGallery
//
//  Created by Yeonhee Lee on 4/11/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit

class ImagePreviewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var myCollectionView: UICollectionView!
    var imgArray = [UIImage]()
    var passedContentOffset = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black
        
        // set the layout for the myCollectionView
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal    //////////// -> why horizontal??
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout) // declare collection view
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(ImagePreviewFullViewCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.isPagingEnabled = true
        myCollectionView.scrollToItem(at: passedContentOffset, at: .left, animated: true)
        
        self.view.addSubview(myCollectionView)
        
        myCollectionView.autoresizingMask = UIViewAutoresizing(rawValue:
            UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) |
            UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count   // the number of items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagePreviewFullViewCell
        cell.imgView.image = imgArray[indexPath.row]    // set the cell image view to the image array
        return cell
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // the scroll view inside the cell to conform to the bounds of the ??? (layout? wheel?)
        guard let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
        flowLayout.itemSize = myCollectionView.frame.size
        flowLayout.invalidateLayout()   // resize the cell to fit the ... screen?
        myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator) // size: current size of the screen
        let offset = myCollectionView.contentOffset // current offset of myCollectionView
        let width = myCollectionView.bounds.size.width
        
        let index = round(offset.x / width)
        let newOffset = CGPoint(x: index * size.width, y: offset.y)
        
        // manually set the offset of myCollectionView
        myCollectionView.setContentOffset(newOffset, animated: false)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.myCollectionView.reloadData()
            
            self.myCollectionView.setContentOffset(newOffset, animated: false)
        }, completion: nil)
    }
}

// UIScrollView is needed for the zoom in pinching functionality
class ImagePreviewFullViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    var scrollImg: UIScrollView!
    var imgView: UIImageView!   // imgView is gonna be a subview of the scrollImg
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollImg = UIScrollView()
        scrollImg.delegate = self
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 4.0
        
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTapGest) // add double tap gesture recognizer to the scrollImg so that we can double tap on the image to zoom in
        
        self.addSubview(scrollImg)
        
        imgView = UIImageView() // create and image view
        imgView.image = UIImage(named: "user3")
        scrollImg.addSubview(imgView!) // add the imgView as a subview of scrollImg
        imgView.contentMode = .scaleAspectFit
    }
    
    // Handle the double tap on the scroll view
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 { // it the zooming scale is 1
            // use the zoomRectForScale function to zoom in
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {    // otherwise,
            scrollImg.setZoomScale(1, animated: true)   // it's gonna set the image scale to 1
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imgView.frame.size.height / scale
        zoomRect.size.width = imgView.frame.size.width / scale
        let newCenter = imgView.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    // gives the imgView to the scroll view for zooming view
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView // need to return the view which we want to zoom in here
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollImg.frame = self.bounds   // set scrollImg frame to the bounds of the cell
        imgView.frame = self.bounds  // set the imgView frame to the bounds of the cell
    }
    
    // It is called when a cell is reused
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollImg.setZoomScale(1, animated: true)   // need to reset it for the reuse
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
