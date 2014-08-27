//
//  PhotoTableViewCell.swift
//  iDriver
//
//  Created by tp on 14-8-18.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit




class PhotoTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    
       
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
