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
/****全局变量****/
/**拿取附近司机视图*/
var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
/**获取的司机数组*/
var driverListArray : NSArray?
/**获取单个司机*/
var driverDic : NSMutableDictionary?
var nearDriverNav  = appDelegate.nearDriverNavigation
/**添加地图搜索*/
var AMsearch : AMapSearchAPI?
/**在地图上显示具体的地址信息*/
var currentLabel : UILabel?



/****全局常量****/
let SERVICEURL : String = NSBundle.mainBundle().objectForInfoDictionaryKey("service_url") as String
let SERVICEREURL : String = NSBundle.mainBundle().objectForInfoDictionaryKey("service_resource") as String
/**屏幕的宽*/
let SCREENWIDTH : CGFloat = UIScreen.mainScreen().bounds.size.width
/**屏幕的高*/
let SCREENHEIGHT : CGFloat = UIScreen.mainScreen().bounds.size.height
/**状态栏的高度*/
let STATUSHEIGHT: CGFloat  = 20.0
/**tabBar高度*/
let TABBARVIEW : CGFloat = 49.0
/**无网络视图*/
//let NONETVIEWVC : NoNetViewController = PackViewControllerUtil.ViewControllerUtil(storyName: "Alert", viewControllerName: "NoNetVC") as NoNetViewController






class NearDriverViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate,UITableViewDataSource, UITableViewDelegate, AMapSearchDelegate , UIAlertViewDelegate{
    
    /**添加地图*/
    var mapView : MapView?
     /**司机列表*/
    var driverListTableView : UITableView?
    /**定义全局常量:用户中心视图控制器*/
    var userCenterNavigation : UINavigationController?
    /**通知中心*/
    var centerNS : NSNotificationCenter?
    /**分段按钮*/
    var seg : UISegmentedControl?
    /**定时刷新器*/
    var updateTimer : NSTimer?
     /**在地图上显示具体的地址信息的视图*/
    var showCurrentView : UIView?
    /**在地图上显示具体的地址信息的视图*/
    var warnCurrentView : UIView?
    
      override func viewDidLoad() {
        super.viewDidLoad()
        AMsearch = AMapSearchAPI(searchKey: "1fe713f6719276dd0fd593e67326ae5c", delegate: self)
        AMsearch!.delegate = self
        centerNS = NSNotificationCenter.defaultCenter()
        centerNS!.addObserver(self, selector: "driverInfo:", name: "driverInfo", object: nil)
        createSegmentedCintrolAndClientServiceBtnAndUserCenterBtn()
        createMap()
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    /**分段视图切换及个人中心按钮、客服电话的创建*/
    func createSegmentedCintrolAndClientServiceBtnAndUserCenterBtn(){
       
       nearDriverNav!.navigationBar.backgroundColor = UIColor(red: 226.0 / 255.0, green: 234.0 / 255.0, blue: 237.0 / 255.0, alpha: 1)
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
        seg = UISegmentedControl(items:arr)
        seg!.frame = CGRectMake(clientServiceButton.frame.size.width + clientServiceButton.frame.origin.x ,10,nearDriverNav!.navigationBar.frame.size.width - clientServiceButton.frame.size.width * 2 ,24)
        seg!.selectedSegmentIndex = 0
        seg!.tag = 13
        seg!.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        seg!.addTarget(self,action:"segmentValueChange:",forControlEvents: UIControlEvents.ValueChanged)
        nearDriverNav!.navigationBar.addSubview(seg!)
        /**个人中心按钮*/
        var userCenterButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        userCenterButton.frame = CGRectMake(seg!.frame.origin.x + seg!.frame.size.width , 0, nearDriverNav!.navigationBar.frame.size.width - seg!.frame.size.width - clientServiceButton.frame.size.width, nearDriverNav!.navigationBar.frame.size.height)
        userCenterButton.setImage(UIImage(named: "nav_btn_user"), forState: UIControlState.Normal)
        userCenterButton.tag = 14
        userCenterButton.addTarget(self, action: "userCenterBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        userCenterButton.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        nearDriverNav!.navigationBar.addSubview(userCenterButton)
        
    }
    
    /**将自定义的MapView加到界面上，其中内含地图*/
    func createMap(){
        mapView = MapView(frame: CGRectMake(0, nearDriverNav!.navigationBar.frame.size.height , SCREENWIDTH, SCREENHEIGHT - nearDriverNav!.navigationBar.frame.size.height - TABBARVIEW))
        mapView!.createMap()
       
        /**用于显示当前位置的小视图*/
        showCurrentLocView()
    
        self.view.addSubview(mapView!)
        if seg!.selectedSegmentIndex == 0{
            tabBarView!.hidden = false
        }
        /**设置定时器，定时刷新获取附近司机*/
        getNearDriverInformation()
    }
    func showCurrentLocView(){
        //获取当前位置信息
        showCurrentView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 50))
        showCurrentView!.backgroundColor = UIColor.whiteColor()
        showCurrentView!.alpha = 0.9
        currentLabel = UILabel(frame:CGRectMake(5, 20, SCREENWIDTH, showCurrentView!.frame.size.height - 20))
        currentLabel!.font = UIFont.systemFontOfSize(14.0)
        currentLabel!.textAlignment = NSTextAlignment.Left
        convertReGeocode()
        showCurrentView!.addSubview(currentLabel!)
        map!.addSubview(showCurrentView!)
    
    }
    
    /**客服按钮的触发事件：拨打客服电话*/
    func clientBtn(sender : UIButton){
        
       alertViewString = CALLSERVICEALERT
       var arr : NSArray = NSBundle.mainBundle().loadNibNamed("AlertView", owner: self, options: nil)
        var alertView : AlertView = arr.objectAtIndex(0) as AlertView
        alertView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.8)
        UIApplication.sharedApplication().keyWindow!.rootViewController.view.addSubview(alertView)
    }
    
    
    
     /**个人中心*/
    func userCenterBtn(sender : UIButton){
        var btn = sender
        /*模拟登录*/
        var registerNav : UINavigationController = PackViewControllerUtil.ViewControllerUtil( storyName: "Register", viewControllerName: "registerNav") as UINavigationController
        self.presentViewController(registerNav, animated: true, completion: nil)
    }
    
    /**分段按钮的触发事件*/
    func segmentValueChange(sender:UISegmentedControl!){
        var index = sender.selectedSegmentIndex
        if index == 0{
            self.driverListTableView!.removeFromSuperview()
            createMap()
        }
        else{
            mapView!.removeFromSuperview()
            driverList()
        }
        
    }
    /**司机列表*/
    func driverList(){
        println(CheckNetWork.NetWorkIsOk())
        if CheckNetWork.NetWorkIsOk(){
            self.driverListTableView = UITableView(frame: CGRectMake(0, nearDriverNav!.navigationBar.frame.size.height + STATUSHEIGHT , SCREENWIDTH, SCREENHEIGHT - nearDriverNav!.navigationBar.frame.size.height - STATUSHEIGHT - TABBARVIEW), style: UITableViewStyle.Plain)
        }
        else{
             warnningView()
             self.driverListTableView = UITableView(frame: CGRectMake(0, nearDriverNav!.navigationBar.frame.size.height + STATUSHEIGHT + warnCurrentView!.frame.size.height, SCREENWIDTH, SCREENHEIGHT - nearDriverNav!.navigationBar.frame.size.height - STATUSHEIGHT - TABBARVIEW - warnCurrentView!.frame.size.height), style: UITableViewStyle.Plain)
            self.view.addSubview(warnCurrentView!)
        }
        
        self.driverListTableView!.delegate = self
        self.driverListTableView!.dataSource = self
        self.driverListTableView!.registerClass(DriverTableViewCell.self, forCellReuseIdentifier: "nearDriverCell")
        tabBarView!.hidden = true
        self.view.addSubview(self.driverListTableView!)
        /**对网络的状态进行定时刷新*/
         updateTimer! = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: "netIsOk", userInfo: nil, repeats: true)

    }
    func warnningView(){
        warnCurrentView = UIView(frame: CGRectMake(0, nearDriverNav!.navigationBar.frame.size.height + STATUSHEIGHT, SCREENWIDTH, 30))
        warnCurrentView!.backgroundColor = UIColor(red: 236.0 / 255.0, green: 232.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
        warnCurrentView!.alpha = 0.9
        var warnLabel : UILabel = UILabel(frame: CGRectMake(5, 5, SCREENWIDTH, warnCurrentView!.frame.size.height - 10))
        warnLabel.text = "网络连接错误"
        warnLabel.font = UIFont.systemFontOfSize(14.0)
        warnLabel.textAlignment = NSTextAlignment.Left
        warnCurrentView!.addSubview(warnLabel)
    }
    /**网络状态改变时的界面变化*/
    func netIsOk(){
        if CheckNetWork.NetWorkIsOk(){
            self.driverListTableView!.frame = CGRectMake(0, nearDriverNav!.navigationBar.frame.size.height + STATUSHEIGHT, SCREENWIDTH, SCREENHEIGHT - nearDriverNav!.navigationBar.frame.size.height - STATUSHEIGHT - TABBARVIEW)
        }
        else{
            warnningView()
            self.view.addSubview(warnCurrentView!)
             self.driverListTableView!.frame = CGRectMake(0, nearDriverNav!.navigationBar.frame.size.height + STATUSHEIGHT + warnCurrentView!.frame.size.height, SCREENWIDTH, SCREENHEIGHT - nearDriverNav!.navigationBar.frame.size.height - STATUSHEIGHT - TABBARVIEW - warnCurrentView!.frame.size.height)
        }
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
            cell = DriverTableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier:"nearDriverCell")
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
        
        var lng  = loc!.longitude
        var lat  = loc!.latitude
        var getNearDriverString : String = SERVICEURL + "getFreeDrivers?lng=\(lng)&lat=\(lat)"
        var url : NSURL = NSURL(string:getNearDriverString)
        var driverRequest = ASIFormDataRequest(URL: url)
        driverRequest.requestMethod = "GET"
        driverRequest.delegate = self
        driverRequest.didFinishSelector = "nearDriverFinish:"
        driverRequest.didFailSelector = "nearDriverFail:"
        driverRequest.startAsynchronous()
        
    }
    //获取附近司机信息成功和失败的代理
    func nearDriverFinish(request : ASIHTTPRequest){
        var dic : NSDictionary = NSJSONSerialization.JSONObjectWithData(request.responseData(), options: NSJSONReadingOptions.MutableContainers, error:NSErrorPointer()) as NSDictionary
        if dic["res"].isEqual("0"){
            var dic1 : NSDictionary = dic["msg"] as NSDictionary
            driverListArray  = dic1.objectForKey("driverList") as? NSArray
            for var i = 0; i < driverListArray!.count; i++ {
                driverDic = driverListArray!.objectAtIndex(i) as? NSMutableDictionary
                getDriverPic(driverDic!["pic"] as String)
            }
        
        showCurrentView!.backgroundColor = UIColor.whiteColor()
        convertReGeocode()
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: "getNearDriverInformation", userInfo: nil, repeats: true)
        }
        else{
            var errStr : String = dic["msg"] as String
            AlertUtil.showAlert(errStr)
        }
    
    }
    
    func nearDriverFail(request :ASIFormDataRequest){
        if request.error.code == 1{
            
            showCurrentView!.backgroundColor = UIColor(red: 236.0 / 255.0, green: 232.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
            currentLabel!.text = "当前网络不可用，请检查网络设置"
            ///////updateNoNet()
        }
        
    }
   
    
    
    /**点击手势，通知该页面进行跳转*/
    func driverInfo(notification: NSNotification){
        var driverNo : String = notification.object as String
        var driverVC  : DriverInfoViewController = PackViewControllerUtil.ViewControllerUtil(storyName: "DriverInfo", viewControllerName: "driverInfoVC") as DriverInfoViewController
        selectDriverNo = driverNo
        navBackMark = 0
        updateTimer!.invalidate()
        self.navigationController.pushViewController(driverVC, animated: true)
    }
    /**页面将要出现需要加载的*/
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var clientBtn : UIButton = nearDriverNav!.navigationBar.viewWithTag(12) as UIButton
        var userBtn : UIButton = nearDriverNav!.navigationBar.viewWithTag(14) as UIButton
        clientBtn.hidden = false
        seg!.hidden = false
        if seg!.selectedSegmentIndex == 0 {
            tabBarView!.hidden = false
        }
        userBtn.hidden = false
        
    }
       /**通过公共接口，获取司机头像*/
    func getDriverPic(str : String){
        var getPicStr : String = SERVICEREURL + "getResourse?no=\(str)"
        var url : NSURL = NSURL(string:getPicStr)
        var picRequest = ASIFormDataRequest(URL: url)
        picRequest.requestMethod = "GET"
        picRequest.delegate = self
        picRequest.didFinishSelector = "picFinish:"
        picRequest.didFailSelector = "picFail:"
        picRequest.startAsynchronous()
    }
    /**获取头像成功和失败的代理*/
    func picFinish(request : ASIFormDataRequest){
        var data : NSData = request.responseData()
        var photoImage : UIImage = UIImage(data: data)
        driverDic!.removeObjectForKey("pic")
        driverDic!.setObject(photoImage, forKeyedSubscript: "pic")
        var name : String = driverDic!["name"] as String
        var annotation : DriverAnnotation = DriverAnnotation(driver:driverDic!)
        map!.addAnnotation(annotation)
    }
    func picFail(request :ASIFormDataRequest){
        /**未连接到网络*/
        if request.error.code == 1{
            currentLabel!.text = "当前网络不可用，请检查网络设置"
        }
    }
    
    //转换为地址信息
    func convertReGeocode(){
        var reGeoRequest : AMapReGeocodeSearchRequest = AMapReGeocodeSearchRequest()
        reGeoRequest.searchType = AMapSearchType_ReGeocode
        reGeoRequest.location = AMapGeoPoint.locationWithLatitude(CGFloat(loc!.latitude), longitude: CGFloat(loc!.longitude))
//        reGeoRequest.radius = 10000
//        reGeoRequest.requireExtension = true
        AMsearch!.AMapReGoecodeSearch(reGeoRequest)
    }
    //转换成地址信息的代理
    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        var reGeo : AMapReGeocode = response.regeocode
        currentLabel!.text = "当前位置:\(reGeo.formattedAddress)"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }


    
}
