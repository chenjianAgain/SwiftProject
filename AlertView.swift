//
//  AlertView.swift
//  iDriver
//
//  Created by GaoLi on 14-8-25.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit



class AlertView: UIView {

    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var alertMessage: UILabel!
    @IBOutlet weak var alertTitle: UILabel!
    
       override func drawRect(rect: CGRect)
    {
        
        self.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.8)
        self.leftBtn.layer.cornerRadius = 7
        self.rightBtn.layer.cornerRadius = 7
        var view1 : UIView = self.viewWithTag(1102)!
        view1.layer.cornerRadius = 5
        if alertViewString! == NONETALERT{
            self.alertTitle.text = "未连接到网络"
            self.alertMessage.text = "请检查你的网络设置"
            self.leftBtn.setTitle("设置", forState: UIControlState.Normal)
            self.rightBtn.setTitle("退出", forState: UIControlState.Normal)
            
            
        }
        if alertViewString! == CALLSERVICEALERT{
            self.alertTitle.text = "联系客服"
            self.alertMessage.text = "将拨打客服电话400-800-888"
            self.leftBtn.setTitle("取消", forState: UIControlState.Normal)
            self.rightBtn.setTitle("拨打", forState: UIControlState.Normal)
            
        }
        if alertViewString! == BLACKLISTALERT{
            self.alertTitle.text = "账号异常"
            self.alertMessage.text = "请拨打客服400-2000666"
            self.leftBtn.setTitle("拨打电话", forState: UIControlState.Normal)
            self.rightBtn.setTitle("取消", forState: UIControlState.Normal)
        }
        println(alertViewString!)

        
    }
    
    @IBAction func leftBtnClick(sender: AnyObject) {
        println("left")
        if alertViewString! == NONETALERT{
//            if (UIDevice.currentDevice().systemVersion as NSString).floatValue == 8.0{
//                /**iOS8以后该方法可以实现setting页面跳转*/
////                UIApplication.sharedApplication().openURL(NSURL.URLWithString(UIApplicationOpenSettingsURLString))
//            }
//            else{
//                /**ios5.0以后不会起作用*/
//                UIApplication.sharedApplication().openURL(NSURL.URLWithString("prefs:root=General&path=Network/VPN"))
//            }
            
        }
        if alertViewString! == CALLSERVICEALERT{
            self.removeFromSuperview()
        }
        if alertViewString! == BLACKLISTALERT{
            UIApplication.sharedApplication().openURL(NSURL.URLWithString("tel://15620507385"))
        }

    }
    
    
    @IBAction func rightBtnClick(sender: AnyObject) {
        println("right")
        if alertViewString! == NONETALERT{
            exit(0)
        }
        if alertViewString! == CALLSERVICEALERT{
            UIApplication.sharedApplication().openURL(NSURL.URLWithString("tel:15620507385"))
           
        }
        if alertViewString! == BLACKLISTALERT{
            self.removeFromSuperview()
        }

    }
    

}
