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

    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    let driverCount : Int = 4
    var previousBtn : UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        self.view.autoresizesSubviews = true
        self.view.backgroundColor = UIColor(red: 226.0 / 255.0, green: 226.0 / 255.0, blue: 226.0 / 255.0, alpha: 1)
        initDriverCountView()
        initconnectPhoneview()
        initLocationView()
        clickOrderBtn()

        
    }
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
         /**设置NavigationController的标题*/
        self.title = "一键下单"
        var clickOrderNav = appDelegate.clickOrderNavigation
        clickOrderNav!.navigationBar.backgroundColor = UIColor(red: 23.0 / 255.0, green: 161.0 / 255.0, blue: 219.0 / 255.0, alpha: 1)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
     /**司机数量视图*/
    func initDriverCountView(){
        /**司机数标签*/
        var clickOrderNav  = appDelegate.clickOrderNavigation
        var driverCountLabel : UILabel = UILabel(frame: CGRectMake(28, clickOrderNav!.navigationBar.frame.size.height, 100, 100))
        driverCountLabel.text = "司机数:"
        self.view.addSubview(driverCountLabel)
        /**司机数按钮及人数标签*/
        for var btnIndex = 0;btnIndex < driverCount; ++btnIndex{
            var btn : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            btn.frame = CGRectMake(CGFloat(btnIndex) * 70 + driverCountLabel.frame.origin.x + 10,driverCountLabel.frame.size.height + 10 ,20 , 20)
            btn.tag = 20 + btnIndex
            var countLabel : UILabel = UILabel(frame: CGRectMake(btn.frame.origin.x - 3, btn.frame.origin.y + btn.frame.size.height , 50, 30))
            countLabel.tag = 30 + btnIndex
            switch(btnIndex){
            case 0:
                countLabel.text = "一人"
                break
            case 1:
                countLabel.text = "两人"
                break
            case 2:
                countLabel.text = "三人"
                break
            case 3:
                countLabel.text = "四人"
                break
            default :
                break
            }
            if btnIndex == 0{
                btn.setImage(UIImage(named: "SelectCount.png"), forState: UIControlState.Normal)
                previousBtn = btn
                btn.enabled = false
            }
            else{
                btn.setImage(UIImage(named: "NoSelectCount.png"), forState: UIControlState.Normal)
            }
            btn.addTarget(self, action: "selectDriverCount:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(countLabel)
            self.view.addSubview(btn)
            
        }
        
       
    }
    /**联系电话视图*/
    func initconnectPhoneview(){
        /**联系电话视图*/
        var countLalel : UILabel = self.view.viewWithTag(30) as UILabel
        var connectPhoneView : UIView = UIView(frame: CGRectMake(10, countLalel.frame.origin.y + countLalel.frame.size.height  + 5, self.view.frame.size.width - 10 * 2, 70))
        connectPhoneView.backgroundColor = UIColor.whiteColor()
        connectPhoneView.tag = 40
        /**联系电话标签*/
        var phonelabel : UILabel = UILabel (frame: CGRectMake(30, 20, 70, 30))
        phonelabel.font = UIFont.systemFontOfSize(14.0)
        phonelabel.text = "联系电话:"
        phonelabel.tag = 41
        connectPhoneView.addSubview(phonelabel)
        var numberlabel : UILabel = UILabel (frame: CGRectMake(phonelabel.frame.origin.x + phonelabel.frame.size.width, phonelabel.frame.origin.y, 100, phonelabel.frame.size.height))
        numberlabel.font = UIFont.systemFontOfSize(14.0)
        numberlabel.text = "12345678910"
        connectPhoneView.addSubview(numberlabel)
        /**通讯录按钮*/
        var addressListBtn : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        addressListBtn.frame = CGRectMake(numberlabel.frame.origin.x + numberlabel.frame.size.width + 5, numberlabel.frame.origin.y,60 , numberlabel.frame.size.height)
        addressListBtn.setImage(UIImage(named: "addressList"), forState: UIControlState.Normal)
        addressListBtn.addTarget(self, action: "getaddressList:", forControlEvents: UIControlEvents.TouchUpInside)
        connectPhoneView.addSubview(addressListBtn)
        
        self.view.addSubview(connectPhoneView)
    }
    
     /**司机数按钮触发事件:选择司机数量*/
    func selectDriverCount(sender : UIButton){
        var btn : UIButton = sender
        if previousBtn != btn{
            previousBtn!.setImage(UIImage(named: "NoSelectCount.png"), forState: UIControlState.Normal)
            previousBtn!.enabled = true
            btn.setImage(UIImage(named: "SelectCount.png"), forState: UIControlState.Normal)
            previousBtn = btn
            btn.enabled = false
        }
    }
    /**通讯录按钮触发事件：获取用户的通讯录*/
    func getaddressList(sender : UIButton){
//        var tmpAddressbook : ABAddressBookRef?
//        var versionStr : String = UIDevice.currentDevice().systemVersion
//        println(versionStr)
//        var versionNum : Float = String.bridgeToObjectiveC(versionStr)().floatValue
//        if versionNum >= 6.0{
//          //tmpAddressbook = ABAddressBookCreateWithOptions(?,?)
//            var sema : dispatch_semaphore_t = dispatch_semaphore_create(0)
//            var error : CFErrorRef?
//            var greanted : Bool?
//            ABAddressBookRequestAccessWithCompletion(tmpAddressbook,{
//                (greanted,error) in
//                dispatch_semaphore_signal(sema)
//                });
        
    }
    /**所在位置视图*/
    func initLocationView(){
        var connectPhone : UIView = self.view.viewWithTag(40)
        var phoneLal : UILabel = connectPhone.viewWithTag(41) as UILabel
        var locationView : UIView = UIView(frame: CGRectMake(connectPhone.frame.origin.x, connectPhone.frame.origin.y + connectPhone.frame.size.height + 10, connectPhone.frame.size.width, connectPhone.frame.size.height))
        locationView.tag = 50
        locationView.backgroundColor = UIColor.whiteColor()
        
        var locationLabel : UILabel = UILabel (frame:phoneLal.frame)
        locationLabel.font = UIFont.systemFontOfSize(14.0)
        locationLabel.text = "所在位置:"
        locationView.addSubview(locationLabel)
        
       
        var locationBtn : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        locationBtn.frame = CGRectMake(locationLabel.frame.origin.x + locationLabel.frame.size.width, locationLabel.frame.origin.y,200 , locationLabel.frame.size.height)
        locationBtn.setTitle("闵行区万源路2158号", forState: UIControlState.Normal)
        locationBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        locationBtn.addTarget(self, action: "selectLocation:", forControlEvents: UIControlEvents.TouchUpInside)
        locationView.addSubview(locationBtn)
        self.view.addSubview(locationView)
        
    }
    /**选择代驾开始位置*/
    func selectLocation(sender : UIButton){
        
    }
    func clickOrderBtn(){
        var locationView : UIView = self.view.viewWithTag(50)
        var clickOrderBtn : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        clickOrderBtn.frame = CGRectMake(70, locationView.frame.origin.y + locationView.frame.size.height + 10, 180, 40)
        clickOrderBtn.setImage(UIImage(named: "clickOrderNormalBtn.png"), forState: UIControlState.Normal)
        clickOrderBtn.setImage(UIImage(named: "clickOrderHighlightBtn.png"), forState: UIControlState.Highlighted)
        clickOrderBtn.addTarget(self, action:"clickOrder:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(clickOrderBtn)
         
    }
    func clickOrder(sender : UIButton){
        
    }
    
    
    

  
}
