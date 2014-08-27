//
//  CustomTabBarButton.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/10.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

/**
自定义的Button 来改变图片和标题的位置
*/
class CustomTabBarButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
   /**通过重写两个方法，使得标题和图片是上下关系（默认的图片在左，标题在右）*/
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect{
        var imageWidth : CGFloat = contentRect.size.width * 0.4
        var imageHeight : CGFloat = contentRect.size.height 
        return CGRect(x:0,y:0,width: imageWidth,height: imageHeight)
    }
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        var titleX = contentRect.size.height * 0.6
        var titleWidth = contentRect.size.width - contentRect.size.height * 0.6
        var titleHeight = contentRect.size.height
        return CGRect(x:titleX,y:0,width: titleWidth,height: titleHeight)
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
}
