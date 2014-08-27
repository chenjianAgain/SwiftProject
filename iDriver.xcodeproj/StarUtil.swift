//
//  StarUtil.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/31.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit
/**
用于星星的展示
*/

/**记录半颗星的起始位置*/
var halfStarRect : CGRect?
/**记录空心的起始位置*/
var emptyStarRect : CGRect?
/**用于放置半颗星*/
var halfStar : UIImageView?

class StarUtil: NSObject {
    class func showDriverStar(grade : CGFloat,view: UIView){
        /*取得整数部分*/
        var fullStar  = floor(grade)
        if CGFloat(fullStar) == CGFloat(grade){
            for var i = 0; i < Int(fullStar); i++ {
                var fullStarImg : UIImageView = UIImageView(frame: CGRectMake(CGFloat(i) * 14, 0, 14, view.frame.size.height))
                if i == Int(fullStar) - 1{
                    emptyStarRect = fullStarImg.frame
                }
                
                fullStarImg.image = UIImage(named: "star_light")
                view.addSubview(fullStarImg)
            }
            if Int(fullStar) < 5{
                for var j = 0; j < 5 - Int(fullStar); j++ {
                    var emptyStarImg : UIImageView = UIImageView(frame: CGRectMake(emptyStarRect!.origin.x + emptyStarRect!.size.width, 0, 14, view.frame.size.height))
                    emptyStarImg.image = UIImage(named: "star_unlight")
                    view.addSubview(emptyStarImg)
                    
                }
            }
        }
        else{
            for var i = 0; i < Int(fullStar); i++ {
                var fullStarImg : UIImageView = UIImageView(frame: CGRectMake(CGFloat(i) * 14, 0, 14, view.frame.size.height))
                if i == Int(fullStar) - 1{
                    halfStarRect = fullStarImg.frame
                }
                fullStarImg.image = UIImage(named: "star_light")
                view.addSubview(fullStarImg)
            }
            halfStar = UIImageView(frame: CGRectMake(halfStarRect!.origin.x + halfStarRect!.size.width, 0,14, view.frame.size.height ))
            halfStar!.image = UIImage(named: "star_half_light")
            view.addSubview(halfStar)
            if Int(fullStar) + 1 < 5{
                for var j = 0; j < 4 - Int(fullStar); j++ {
                    var emptyStarImg : UIImageView = UIImageView(frame: CGRectMake(halfStar!.frame.origin.x + halfStar!.frame.size.width + CGFloat(j) * 14, 0, 14, view.frame.size.height))
                    emptyStarImg.image = UIImage(named: "star_unlight")
                    view.addSubview(emptyStarImg)
                    
                }
            }
            
        }
    }

}
