//
//  ClickOrderViewController.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/9.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit
import AddressBookUI
import AddressBook
/**
一键下单页面
*/

class ClickOrderViewController: UIViewController {
    
    var previousBtn : UIButton?
    /**一键下单*/
    @IBAction func orderBtnClick(sender: AnyObject) {
        //TODO
    }
    
    @IBAction func addressBookBtnClick(sender: AnyObject) {
//        var addressBook : ABAddressBookRef = ABAddressBookCreateWithOptions(CFDictionaryRef(),UnsafePointer())
//        var allPeople : CFArrayRef = ABAddressBookCopyArrayOfAllPeople(addressBook)
    }
    /**选择司机数量*/
    @IBAction func driverNumberBtnClick(sender: AnyObject) {
        var btn : UIButton = sender as UIButton
        if previousBtn != btn{
            previousBtn!.backgroundColor = UIColor(patternImage: UIImage(named: "order_driver_num"))
            btn.backgroundColor = UIColor(patternImage: UIImage(named: "order_driver_num_selected"))
           btn.titleLabel.textColor = UIColor.redColor()
            btn.titleLabel.textColor = UIColor.whiteColor()
            previousBtn = btn
        }
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       initView()
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        /**设置NavigationController的标题*/
        self.title = "一键下单"
        var clickOrderNav = appDelegate.clickOrderNavigation
        clickOrderNav!.navigationBar.backgroundColor = UIColor(red: 226.0 / 255.0, green: 234.0 / 255.0, blue: 237.0 / 255.0, alpha: 1)
    }
    
    /**界面的一些初始化*/
    func initView(){
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        self.view.autoresizesSubviews = true
        var phoneVC : UIView = self.view.viewWithTag(100)
        var location : UIView = self.view.viewWithTag(101)
        var btn : UIButton = self.view.viewWithTag(90) as UIButton
        btn.layer.cornerRadius = 7
        previousBtn = btn
        previousBtn!.backgroundColor = UIColor(patternImage: UIImage(named: "order_driver_num_selected"))
        var clickBtn : UIButton = self.view.viewWithTag(94) as UIButton
        phoneVC.layer.cornerRadius = 7
        location.layer.cornerRadius = 7
        clickBtn.layer.cornerRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
