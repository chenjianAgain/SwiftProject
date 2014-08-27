//
//  WaitOrder.swift
//  iDriver
//
//  Created by GaoLi on 14-8-25.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

var orderfail : OrderFail = OrderFail()
var timeLabelTimmer : NSTimer?


class WaitOrder: UIView {
    
    
    
    

    @IBOutlet weak var timeLabel: UILabel!
  
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        self.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.8)
        timeLabelTimmer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:Selector("waitTime"), userInfo: nil, repeats: true)
        
    }
    
    
    func waitTime(){
        if (self.timeLabel!.text as NSString).intValue == 0{
            timeLabelTimmer!.invalidate()
            self.removeFromSuperview()
            //TODO
            var arr : NSArray = NSBundle.mainBundle().loadNibNamed("OrderFail", owner: self, options: nil)
            orderfail = arr.objectAtIndex(0) as OrderFail
            //self.removeFromSuperview()
            orderfail.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.8)
            UIApplication.sharedApplication().keyWindow.addSubview(orderfail)
            
        }
        else{
            var str : NSString = self.timeLabel!.text
            var a  = str.intValue
            a = a - 1
            self.timeLabel!.text = String(a)
 
        }
    }
   

}
