//
//  MessageCell.swift
//  iDriver
//
//  Created by tp on 14-7-28.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

var iconView : UIImageView?
var contentBtn : UIButton?

class MessageCell: UITableViewCell {

    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        
        self.backgroundColor = UIColor.clearColor()
        
        // 2、创建头像
        self.contentView.addSubview(iconView)
        
        // 3、创建内容
        contentBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        contentBtn!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        contentBtn!.titleLabel.font = kContentFont
        contentBtn!.titleLabel.numberOfLines = 0
        self.contentView.addSubview(contentBtn)
    }

    
    func setMessageFrame(messageFrame : MessageFrame) {
        
        // 2、设置头像
        iconView!.image = UIImage(named:icon)
        iconView!.frame = iconF!
        
        // 3、设置内容
        contentBtn!.setTitle(content, forState: UIControlState.Normal)
        contentBtn!.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight)
        contentBtn!.frame = contentF!
        
        var chatFrame : UIImage?
        
        if type == MessageTypeMe {
        
            chatFrame = UIImage(named: "convo_bg_right.png")
            chatFrame = chatFrame!.stretchableImageWithLeftCapWidth(Int(chatFrame!.size.width * 0.5), topCapHeight: Int(chatFrame!.size.height * 0.7))
        }
        if type == MessageTypeOther {
        
            chatFrame = UIImage(named: "convo_bg_left.png")
            chatFrame = chatFrame!.stretchableImageWithLeftCapWidth(Int(chatFrame!.size.width * 0.5), topCapHeight:Int(chatFrame!.size.height * 0.7))
        }
        contentBtn!.setBackgroundImage(chatFrame, forState: UIControlState.Normal)
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
