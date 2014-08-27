//
//  MessageCell.swift
//  iDriver
//
//  Created by tp on 14-7-28.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

var _messageFrame : MessageFrame?

 

class MessageCell: UITableViewCell {

    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
