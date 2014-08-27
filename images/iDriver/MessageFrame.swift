//
//  MessageFrame.swift
//  iDriver
//
//  Created by tp on 14-7-28.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit


let kMargin : CGFloat = 14  //高度
let kIconWH : CGFloat = 45  //头像宽高
let kContentW : CGFloat = 90  //内容宽度
let kContentTop : CGFloat = 15  //文本内容与按钮上边缘间隔
let kContentLeft : CGFloat = 25  //文本内容与按钮左边缘间隔
let kContentBottom : CGFloat = 15  //文本内容与按钮下边缘间隔
let kContentRight : CGFloat = 25  //文本内容与按钮右边缘间隔
let kContentFont = UIFont.systemFontOfSize(16)//内容字体



var iconF : CGRect?
var contentF : CGRect?
var cellHeight :CGFloat?


class MessageFrame: NSObject {
   
    func setMessage(message : Message){
    
       
        // 0、获取屏幕宽度
        var screenW : CGFloat = UIScreen.mainScreen().bounds.size.width
        
        // 2、计算头像位置
        var iconX : CGFloat = kMargin
        
        // 2.1 如果是自己发得，头像在右边
        if type == MessageTypeMe{
        
            iconX = screenW - kMargin - kIconWH
        }
        
        var iconY : CGFloat = kMargin
        iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH)
        
        // 3、计算内容位置
        var contentX : CGFloat = CGRectGetMaxX(iconF!) + kMargin
        var contentY : CGFloat = iconY
        var chatTextFont : NSDictionary = [NSFontAttributeName : kContentFont]
        
        //var contentSize : CGSize = content!.boundingRectWithSize(CGSizeMake(CGFloat(kContentW), CGFloat(CGFLOAT_MAX)), options: NSStringDrawingOptions.TruncatesLastVisibleLine | NSStringDrawingOptions.UsesLineFragmentOrigin | NSStringDrawingOptions.UsesFontLeading, attributes: chatTextFont, context: nil).size
        
        var contentSize : CGSize = content!.boundingRectWithSize(CGSizeMake(kContentW, CGFLOAT_MAX), options: NSStringDrawingOptions.TruncatesLastVisibleLine, attributes: chatTextFont, context: nil).size

        if type == MessageTypeMe{
        
            contentX = iconX - kMargin - contentSize.width - kContentLeft - kContentRight
            
        }
        
        contentF = CGRectMake(contentX, contentY, contentSize.width + kContentLeft + kContentRight, contentSize.height + kContentTop + kContentBottom)
        
        // 4、计算高度
        cellHeight = max(CGRectGetMaxY(contentF!), CGRectGetMaxY(iconF!))  + kMargin
    }
}
