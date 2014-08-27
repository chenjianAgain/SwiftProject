//
//  NearDriverViewController.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/9.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


/**
显示地图和司机列表
*/

/**拿取附近司机视图*/
var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
/**获取的司机数组*/
var driverListArray : NSArray?

var driverDic : NSDictionary?

var nearDriverNav  = appDelegate.nearDriverNavigation


/**屏幕的宽*/
let SCREENWIDTH : CGFloat = UIScreen.mainScreen().bounds.size.width
/**屏幕的高*/
let SCREENHEIGHT : CGFloat = UIScreen.mainScreen().bounds.size.height
/**状态栏的高度*/
let STATUSHEIGHT: CGFloat  = 20.0
let TABBARVIEW : CGFloat = 49.0


class NearDriverViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate,UITableViewDataSource, UITableViewDelegate {
    
    /**添加地图*/
    var mapView : MapView?
     /**司机列表*/
    var driverListTableView : UITableView?
    /**定义全局常量:用户中心视图控制器*/
    var userCenterNavigation : UINavigationController?
    /**登陆注册界面*/
    var registerNav : UINavigationController?

    /**通知中心*/
    var centerNS : NSNotificationCenter?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerNS = NSNotificationCenter.defaultCenter()
        centerNS!.addObserver(self, selector: "driverInfo:", name: "driverInfo", object: nil)
        
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        self.view.autoresizesSubviews = true
     createSegmentedCintrolAndClientServiceBtnAndUserCenterBtn()
         createMap()
        
    }
 
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    /**分段视图切换及个人中心按钮、客服电话的创建*/
    func createSegmentedCintrolAndClientServiceBtnAndUserCenterBtn(){
       
       nearDriverNav!.navigationBar.backgroundColor = UIColor(red: 226.0 / 255.0, green: 234.0 / 255.0, blue: 237.0 / 255.0, alpha: 1)
        nearDriverNav!.navigationBar.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        /**客服按钮*/
        var clientServiceButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        clientServiceButton.frame = CGRectMake(0, 0, 50, nearDriverNav!.navigationBar.frame.size.height)
        clientServiceButton.setImage(UIImage(named: "nav_btn_phone"), forState: UIControlState.Normal)
        clientServiceButton.tag = 12
        clientServiceButton.addTarget(self, action: "clientBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        clientServiceButton.autoresizingMask =  UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        nearDriverNav!.navigationBar.addSubview(clientServiceButton)
        
        /**导航条上的分段按钮*/
        let arr : NSArray = ["地图","列表"]
        let seg : UISegmentedControl = UISegmentedControl(items:arr)
        seg.frame = CGRectMake(clientServiceButton.frame.size.width + clientServiceButton.frame.origin.x ,10,nearDriverNav!.navigationBar.frame.size.width - clientServiceButton.frame.size.width * 2 ,24)
        seg.selectedSegmentIndex = 0
        seg.tag = 13
        seg.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        seg.addTarget(self,action:"segmentValueChange:",forControlEvents: UIControlEvents.ValueChanged)
        nearDriverNav!.navigationBar.addSubview(seg)
        /**个人中心按钮*/
        var userCenterButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        userCenterButton.frame = CGRectMake(seg.frame.origin.x + seg.frame.size.width , 0, nearDriverNav!.navigationBar.frame.size.width - seg.frame.size.width - clientServiceButton.frame.size.width, nearDriverNav!.navigationBar.frame.size.height)
        userCenterButton.setImage(UIImage(named: "nav_btn_user"), forState: UIControlState.Normal)
        userCenterButton.tag = 14
        userCenterButton.addTarget(self, action: "userCenterBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        userCenterButton.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        nearDriverNav!.navigationBar.addSubview(userCenterButton)
        
        
        

    }
    
    /**将自定义的UIView加到界面上，其中内含地图*/
    func createMap(){
        mapView = MapView(frame: CGRectMake(0, nearDriverNav!.navigationBar.frame.size.height , SCREENWIDTH, SCREENHEIGHT - nearDriverNav!.navigationBar.frame.size.height - 49))
        mapView!.createMap()
        self.view.addSubview(mapView)
        /**获取附近司机信息*/
        getNearDriverInformation()
    }
    
     /**客服按钮的触发事件：拨打客服电话*/
    func clientBtn(sender : UIButton){
        UIApplication.sharedApplication().openURL(NSURL.URLWithString("telprompt://15620507385"))
    }
    
     /**个人中心*/
    func userCenterBtn(sender : UIButton){
        var btn = sender
        /*模拟登录*/
        registerNav  = PackViewControllerUtil.ViewControllerUtil( storyName: "Register", viewControllerName: "registerNav") as? UINavigationController
        self.presentViewController(registerNav, animated: true, completion: nil)
    }
    
    /**分段按钮的触发事件*/
    func segmentValueChange(sender:UISegmentedControl!){
        var index = sender.selectedSegmentIndex
        if index == 0{
            createMap()
        }
        else{
           
            driverList()
        }
    }
    /**司机列表*/
    func driverList(){
        self.driverListTableView = UITableView(frame: CGRectMake(0, nearDriverNav!.navigationBar.frame.size.height + STATUSHEIGHT, self.view.frame.size.width, self.view.frame.size.height - nearDriverNav!.navigationBar.frame.size.height - 49 - STATUSHEIGHT), style: UITableViewStyle.Plain)
        self.driverListTableView!.delegate = self
        self.driverListTableView!.dataSource = self
        self.driverListTableView!.registerClass(DriverTableViewCell.self, forCellReuseIdentifier: "nearDriverCell")
        self.view.addSubview(self.driverListTableView)
    }
    
    // UITableViewDataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return driverListArray!.count
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        var cell  : DriverTableViewCell = tableView.dequeueReusableCellWithIdentifier("nearDriverCell", forIndexPath: indexPath) as DriverTableViewCell
        if cell == nil{
            cell = DriverTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "nearDriverCell")
        }
       
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.data = driverListArray![indexPath!.row] as? NSDictionary
        cell.updateCell()
        return cell
    }
    
    // UITableViewDelegate Methods
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var driverInfoVC : DriverInfoViewController = PackViewControllerUtil.ViewControllerUtil(storyName: "DriverInfo", viewControllerName: "driverInfoVC") as DriverInfoViewController
        var dic : NSDictionary = driverListArray![indexPath.row] as NSDictionary
        selectDriverNo = dic["no"] as? String
        navBackMark = 1
        self.navigationController.pushViewController(driverInfoVC, animated: true)
        
    }
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 95.0
    }
    /**获取附近司机信息*/
    func getNearDriverInformation(){
        //加载一个NSURL对象
//        var serviceurl : String = NSBundle.mainBundle().objectForInfoDictionaryKey("service_url") as String
//        var getNearDriverString : String = serviceurl + "getFreeDrivers?lng=" + String(loc!.longitude) + "&lat=" + String(loc!.latitude)
//        println(getNearDriverString)
//        var encodingString = getNearDriverString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
//        var getNearDriverRequest : NSURLRequest = NSURLRequest(URL: NSURL.URLWithString(encodingString))
//        //将请求的url数据放到NSData对象中
//        var getNearDriverResponse : NSData = NSURLConnection.sendSynchronousRequest(getNearDriverRequest, returningResponse: AutoreleasingUnsafePointer.null(), error: AutoreleasingUnsafePointer.null()) as NSData
//        //IOS自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        var informationDic : NSDictionary = NSJSONSerialization.JSONObjectWithData(getNearDriverResponse, options: NSJSONReadingOptions.MutableLeaves, error: AutoreleasingUnsafePointer.null()) as NSDictionary
//        var driverListDic : NSDictionary = informationDic.objectForKey("msg") as NSDictionary
//        driverListArray  = driverListDic.objectForKey("driverList") as? NSArray
//        println(driverListArray)
        driverListArray = [
            ["no":"SJ001","name":"李光明","pic":"1.png","latitude":31.14,"longitude":121.29,"place":"山东","lType":"C1","dAge":"24","sCount":"32","grade":4.5,"status":0,"dist":1200],
            ["no":"SJ002","name":"王锐明","pic":"2.png","latitude":31.15,"longitude":121.28,"place":"安徽","lType":"B1","dAge":"26","sCount":"22","grade":3.5,"status":0,"dist":1500]]
        for var i = 0; i < driverListArray!.count; i++ {
             driverDic = driverListArray!.objectAtIndex(i) as? NSDictionary
            var annotation : DriverAnnotation = DriverAnnotation(driver:driverDic!)
            map!.addAnnotation(annotation)
            
        }
        
    }
    
    
    /**通知该页面进行跳转*/
    func driverInfo(notification: NSNotification){
        var driverNo : String = notification.object as String
        var driverVC  : DriverInfoViewController = PackViewControllerUtil.ViewControllerUtil(storyName: "DriverInfo", viewControllerName: "driverInfoVC") as DriverInfoViewController
        selectDriverNo = driverNo
        navBackMark = 0
        self.navigationController.pushViewController(driverVC, animated: true)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var clientBtn : UIButton = nearDriverNav!.navigationBar.viewWithTag(12) as UIButton
        var seg : UISegmentedControl = nearDriverNav!.navigationBar.viewWithTag(13) as UISegmentedControl
        var userBtn : UIButton = nearDriverNav!.navigationBar.viewWithTag(14) as UIButton
        clientBtn.hidden = false
        seg.hidden = false
        userBtn.hidden = false
        
    }

    
}
