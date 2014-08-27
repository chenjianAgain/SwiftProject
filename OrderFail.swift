//
//  OrderFail.swift
//  iDriver
//
//  Created by GaoLi on 14-8-25.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

class OrderFail: UIView {

   
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        
        self.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.8)
        var btn1 : UIButton = self.viewWithTag(6000) as UIButton
        var btn2 : UIButton = self.viewWithTag(6001) as UIButton
        btn1.layer.cornerRadius = 7
        btn2.layer.cornerRadius = 7
    }
    
    @IBAction func againSelectDriverBtnClick(sender: AnyObject) {
        
        self.removeFromSuperview()
    }

    @IBAction func orderByPlaceBtnClick(sender: AnyObject) {
        
    }
}
