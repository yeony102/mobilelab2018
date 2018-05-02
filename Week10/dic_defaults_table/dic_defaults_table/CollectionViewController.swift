//
//  CollectionViewController.swift
//  dic_defaults_table
//
//  Created by Yeonhee Lee on 4/21/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

class CollectionViewController: UICollectionViewController {
    
//    var scraps: [Scrap] = []
//    var book = [Any]()
    var ids = [Any]()
    var memos = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("Passed in data: \(scraps)")
//        print("Passed in data: \(book)")
        print("Passed in ids: \(ids)")
        print("Passed in memos: \(memos)")
        print(ids.count)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return scraps.count
        return ids.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
//        let scrap = scraps[indexPath.row]
//        cell.cellData.text = scrap.imageId
        print(indexPath.row)
        let id = ids[indexPath.row] as! String
        let memo = memos[indexPath.row] as! String
        
        cell.cellId.text = id
        cell.cellMemo.text = memo
        
        return cell
    }
}
