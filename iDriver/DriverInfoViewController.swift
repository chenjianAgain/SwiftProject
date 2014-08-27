//
//  driverInfoViewController.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/28.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit
/**
展示司机的部分信息，并可以进行指定司机的下单*/

var selectDriverNo : String?
var navBackMark : Int?
var commmentArray : NSArray?
var orderNo : String?


//推送的消息
var pushMsg : NSDictionary = NSDictionary()
//判断是否建立了对话
var isChat : Bool = false




class DriverInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,SRWebSocketDelegate {
    
    @IBOutlet var commentTableView: UITableView?
    @IBOutlet var driverStarView: UIView?
    @IBOutlet var driverView: UIView?
    @IBOutlet var driverHome: UILabel?
    @IBOutlet var driveTimes: UILabel?
    @IBOutlet var driveYears: UILabel?
    @IBOutlet var driverLicense: UILabel?
    @IBOutlet var driverDistance: UILabel?
    @IBOutlet var driverName: UILabel?
    @IBOutlet var driverPhoto: UIImageView?
    
    
    
    
    
    /**指定司机下单司机下单*/
    @IBAction func clickOrder(sender: AnyObject) {
        
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {() in
//            var url : String = "ws://192.168.2.13:9090/im/server?userId=15800929404"
//            
//            println(url)
//            
//            _socket = SRWebSocket(URL : NSURL(string:url))
//            _socket!.delegate = self
//            
//            _socket?.open()
//            
//            dispatch_async(dispatch_get_main_queue(), {() in
//            
//                /**等待接单90s*/
//                var arr : NSArray = NSBundle.mainBundle().loadNibNamed("WaitOrder", owner: self, options: nil)
//                var waitView : WaitOrder = arr.objectAtIndex(0) as WaitOrder
//                waitView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.8)
//                UIApplication.sharedApplication().keyWindow!.addSubview(waitView)
//                
//                
//                self.createOrderByDriver()
//            
//            })

        
//})
        
        
        
        var url : String = "ws://192.168.2.13:9090/im/server?userId=15800929404"
        
        println(url)
        
        _socket = SRWebSocket(URL : NSURL(string:url))
        _socket!.delegate = self
        
        _socket?.open()

        
        
        var arr : NSArray = NSBundle.mainBundle().loadNibNamed("WaitOrder", owner: self, options: nil)
                    var waitView : WaitOrder = arr.objectAtIndex(0) as WaitOrder
                    waitView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.8)
                    UIApplication.sharedApplication().keyWindow!.addSubview(waitView)
    
    
        self.createOrderByDriver()

        
        }
    
    
    
    /**websocket需要实现的4个方法*/
    func webSocket(webSocket : SRWebSocket!, didReceiveMessage message : AnyObject) {
        //txtMsgs.text = txtMsgs.text + (message as String) + "\n"
        
        orderfail.removeFromSuperview()
        timeLabelTimmer!.invalidate()
        
        
        var messageData : NSData = NSData(data: (message as NSString).dataUsingEncoding(NSUTF8StringEncoding))
        
        println(messageData)
        
        pushMsg = NSJSONSerialization.JSONObjectWithData(messageData, options: NSJSONReadingOptions.MutableLeaves, error: nil) as NSDictionary
        
        
        println(pushMsg)
        
        
        //当为推送消息的时候，不显示，直接跳转界面
                if pushMsg.objectForKey("action") as Int == 0 {
        
                    var insidePushMsg : NSDictionary = pushMsg.objectForKey("msg") as NSDictionary
                    
                    //真实判断条件应以订单状态决定socket是否关闭，拒单或者超时无人接单即为空单，要关闭连接
                            if (insidePushMsg.objectForKey("val").objectForKey("type") as Int == 2) {
                                _socket!.close()
                                _socket = nil
                            }

                    
                //跳转入聊天页面
                if(insidePushMsg.objectForKey("val").objectForKey("type") as Int == 4){
                    
                    var toChatVC : ChatViewController = ChatViewController()
                    self.presentViewController(toChatVC, animated: true, completion: nil)
                    
                    isChat = true
                    }
                }
        
    }
    
    func webSocket(webSocket : SRWebSocket!, webSocketDidOpen socket : SRWebSocket) {
        //txtMsgs.text = txtMsgs.text + "连接成功\n"
        println("连接成功")
    }
    
    func webSocket(webSocket : SRWebSocket!, didFailWithError error : NSError) {
        //txtMsgs.text = txtMsgs.text + "错误:" + error.description + "\n"
        println("连接失败")
    }
    
    func webSocket(webSocket : SRWebSocket!, didCloseWithCode
        code : Int, reason: NSString, wasClean:Bool) {
            //txtMsgs.text = txtMsgs.text + "关闭成功\n"
            println("关闭成功")
    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var btn : UIButton = self.view.viewWithTag(80) as UIButton
        btn.layer.cornerRadius = 10
        showDriverInfo()
        //getDriverEvaluations()
        
       
        /**在这调用接口，获得指定司机的近期评价*/
        //commmentArray = [["grade":2.0,"comment":"very good","time":"20140620163234"],["grade":4.0,"comment":"good","time":"20140630163234"]]
        
        
       
        
       
        
       
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
   override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.title = "司机信息"
    var clientBtn : UIButton = nearDriverNav!.navigationBar.viewWithTag(12) as UIButton
    var seg : UISegmentedControl = nearDriverNav!.navigationBar.viewWithTag(13) as UISegmentedControl
    var userBtn : UIButton = nearDriverNav!.navigationBar.viewWithTag(14) as UIButton
    clientBtn.hidden = true
    seg.hidden = true
    userBtn.hidden = true
    
    tabBarView!.hidden = true
    
//    if navBackMark == 0{
//        var backItem1 : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("back"))
//       self.navigationItem.rightBarButtonItem = backItem1
//    }
//    else{
//        var backItem2 : UIBarButtonItem = UIBarButtonItem(title: "司机列表", style:UIBarButtonItemStyle.Plain , target:self , action: Selector("back"))
//         self.navigationItem.rightBarButtonItem = backItem2
//    }
 
}
    func back(){
        self.navigationController.popToRootViewControllerAnimated(true)
    }
    
    func showDriverInfo(){
        for var i = 0; i < driverListArray!.count ; i++ {
            var driver : NSDictionary = driverListArray!.objectAtIndex(i) as NSDictionary
            var driverNO = driver["no"] as String
            if driverNO == selectDriverNo{
                //getDriverEvaluations()
                self.driverPhoto!.image = driver["pic"] as UIImage
                self.driverName!.text = driver["name"] as String
                self.driverLicense!.text = driver["lType"] as String
                var driverY = driver["dAge"] as String
                self.driveYears!.text = "驾龄\(driverY)年"
                var driverT = driver["sCount"] as String
                self.driveTimes!.text =  "代驾\(driverT)次"
                self.driverHome!.text = driver["place"] as String
                var driverD = driver["dist"] as String
                self.driverDistance!.text = "距离" + driverD + "公里"
                var grade = driver["grade"].floatValue
                StarUtil.showDriverStar(grade, view: self.driverStarView!)
                
            }
        }

    }
    //获取司机近期评分
    func getDriverEvaluations(){
        var evaluations : String = SERVICEURL + "getDriverEvaluations?driverNo=\(selectDriverNo!)"
        println(evaluations)
        var url : NSURL = NSURL(string:evaluations)
        var driverEvaluationsRequest = ASIFormDataRequest(URL: url)
        driverEvaluationsRequest.delegate = self
        driverEvaluationsRequest.requestMethod = "GET"
        driverEvaluationsRequest.didFinishSelector = "driverEvaluationsFinish:"
        driverEvaluationsRequest.didFailSelector = "driverEvaluationsFail:"
        driverEvaluationsRequest.startAsynchronous()
    }
    //获取司机近期评分请求成功和失败的代理
    func driverEvaluationsFinish(request : ASIHTTPRequest){
        var dic : NSDictionary = NSJSONSerialization.JSONObjectWithData(request.responseData(), options: NSJSONReadingOptions.MutableContainers, error:NSErrorPointer()) as NSDictionary
        if dic["res"].isEqual("0"){
            
            var dic1 : NSDictionary = dic["msg"] as NSDictionary
            commmentArray = dic1["evaluations"] as? NSArray
            println("commmentArray:\(commmentArray!)")
            
            self.commentTableView!.delegate = self
            self.commentTableView!.dataSource = self
            self.commentTableView!.registerClass(DriverCommentTableViewCell.self, forCellReuseIdentifier:"commentCell")
            showDriverInfo()
            
        }
        else{
            var errStr : String = dic["msg"] as String
        }
        
    }
    func driverEvaluationsFail(request :ASIFormDataRequest){
        /**未连接到网络*/
        if request.error.code == 1{
            //appDelegate.window!.addSubview(NONETVIEWVC.view)
        }
        
        
    }

    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return commmentArray!.count
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        var dic : NSDictionary = commmentArray![indexPath.row] as NSDictionary
        var cell : DriverCommentTableViewCell = tableView.dequeueReusableCellWithIdentifier("commentCell") as DriverCommentTableViewCell
        if cell == nil{
            cell = DriverCommentTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "commentCell")
        }
       cell.cellData = dic
       cell.updateCell()
        return cell
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 40.0
    }
    
    

    //指定司机下单方法
    func createOrderByDriver(){
        if NSUserDefaults.standardUserDefaults().objectForKey("login"){
            var lng  = loc!.longitude
            var lat  = loc!.latitude
            var starAdd : String = "12334"
            var createOrderString : String = SERVICEURL + "createOrderByDriver?tokenNo=\(tokenNo!)&driverNo=\(selectDriverNo!)&contactPhone=\(telephone!)&pmId=354632&startLng=\(lng)&startLat=\(lat)&startAddress=\(starAdd)"
            println(createOrderString)
            var url : NSURL = NSURL(string:createOrderString)
            var OrderByDriverRequest = ASIFormDataRequest(URL: url)
            OrderByDriverRequest.delegate = self
            OrderByDriverRequest.requestMethod = "GET"
            OrderByDriverRequest.didFinishSelector = "OrderByDriverFinish:"
            OrderByDriverRequest.didFailSelector = "OrderByDriverFail:"
            OrderByDriverRequest.startAsynchronous()
        }
        else{
            var registerNav : UINavigationController = PackViewControllerUtil.ViewControllerUtil( storyName: "Register", viewControllerName: "registerNav") as UINavigationController
            self.presentViewController(registerNav, animated: true, completion: nil)
        }
      
    }
    //指定司机下单请求成功和失败的代理
    func OrderByDriverFinish(request : ASIHTTPRequest){
        var dic : NSDictionary = NSJSONSerialization.JSONObjectWithData(request.responseData(), options: NSJSONReadingOptions.MutableContainers, error:NSErrorPointer()) as NSDictionary
        println("OrderByDriverDic:\(dic)")
        if dic["res"].isEqual("0"){
            var dic1 : NSDictionary = dic["msg"] as NSDictionary
            orderNo = dic1["orderNo"] as? String
            AlertUtil.showAlert("orderNo:\(orderNo!)")
            //TODO 开启消息推送进行实时会话
        }
        else{
            var err = dic["msg"] as String
            if err == "黑名单"{
                alertViewString = BLACKLISTALERT
                var arr : NSArray = NSBundle.mainBundle().loadNibNamed("AlertView", owner: self, options: nil)
                var alertView : AlertView = arr.objectAtIndex(0) as AlertView
                alertView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.8)
                UIApplication.sharedApplication().keyWindow!.rootViewController.view.addSubview(alertView)

            }
            else {
                AlertUtil.showAlert(err as String)
            }
            
        }
    }
    
    func OrderByDriverFail(theError :NSError ){
        println("OrderByDriverfailWithError is \(theError)")
    }
    
  
  
}
