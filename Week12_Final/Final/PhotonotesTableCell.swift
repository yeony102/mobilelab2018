//
//  PhotonotesTableCell.swift
//  Final
//
//  Created by Yeonhee Lee on 4/28/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit

class PhotonotesTableCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
