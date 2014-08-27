//
//  AlertUtil.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/21.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

class AlertUtil: NSObject {
    class func showAlert(message : String){
        var alert = UIAlertView()
        alert.title = "提示"
        alert.message = message
        alert.show()
        var dic : NSDictionary = NSDictionary(object: alert, forKey: "alert") as NSDictionary
        let timmer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector : Selector("removeAlert:"), userInfo: dic, repeats: false)
        println(timmer)
    }
    
   class func removeAlert(timmer : NSTimer){
        var alert : UIAlertView = timmer.userInfo.objectForKey("alert") as UIAlertView
        alert.dismissWithClickedButtonIndex(0, animated: true)
        timmer.invalidate()
        
    }
    
}
