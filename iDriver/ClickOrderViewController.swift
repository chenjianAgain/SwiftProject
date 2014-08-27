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
var addressBooktemp : NSMutableArray?
var selectPlace : String?


class ClickOrderViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate, AMapSearchDelegate,SRWebSocketDelegate{
    
    /**显示所选开始地点*/
    @IBOutlet weak var selectPlaceLabel: UILabel!
    /**显示联系电话*/
    @IBOutlet weak var contactPhone: UILabel!
    /**订单成功，保存订单号*/
    var orderNos : NSArray?
    var previousBtn : UIButton?
    /**记录选择的司机人数*/
    var driverNum : Int?
        
    /**一键下单*/
    @IBAction func orderBtnClick(sender: AnyObject) {
        
        
        
            var socketUrl : String = "ws://192.168.2.13:9090/im/server?userId=15800929404"
            
            println(socketUrl)
            
            _socket = SRWebSocket(URL : NSURL(string:socketUrl))
            _socket!.delegate = self
            
            _socket?.open()
      
        
        
        
            var createOrderString : String = SERVICEURL + "createOrderByPlace?tokenNo=\(tokenNo!)&orderNum=\(driverNum!)&contactPhone=\(contactPhone.text)&pmId=57957&startLng=\(startLng!)&startLat=\(startLat!)&startAddress=henhao"
            println(createOrderString)
            var url : NSURL = NSURL(string: createOrderString)
            var createOrderByPlace : ASIFormDataRequest = ASIFormDataRequest(URL: url)
            createOrderByPlace.requestMethod = "GET"
            createOrderByPlace.delegate = self
            createOrderByPlace.didFinishSelector = "createOrderByPlaceFinish:"
            createOrderByPlace.didFailSelector = "createOrderByPlaceFail:"
            createOrderByPlace.startAsynchronous()

        
    
        
    }
    
    
    /**websocket需要实现的4个方法*/
    func webSocket(webSocket : SRWebSocket!, didReceiveMessage message : AnyObject) {
        //txtMsgs.text = txtMsgs.text + (message as String) + "\n"
        
        
        var messageData : NSData = NSData(data: (message as NSString).dataUsingEncoding(NSUTF8StringEncoding))
        
        println(messageData)
        
        pushMsg = NSJSONSerialization.JSONObjectWithData(messageData, options: NSJSONReadingOptions.MutableLeaves, error: nil) as NSDictionary
        
        
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

    
    
    
    
    
    /**从电话簿选择联系电话*/
    @IBAction func addressBookBtnClick(sender: AnyObject) {
        //电话簿界面用手机自带的界面
        var contactsVC : ABPeoplePickerNavigationController = ABPeoplePickerNavigationController()
        contactsVC.peoplePickerDelegate = self
        self.presentViewController(contactsVC, animated: true, completion: nil)
    }
    /**
    电话簿协议
    */
    //选择电话号码(模拟器走此方法)
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecordRef!) {
        var phoneMulti : ABMutableMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneProperty).takeUnretainedValue()
        for var i = 0; i < ABMultiValueGetCount(phoneMulti); i++ {
            var aPhone : String  = ABMultiValueCopyValueAtIndex(phoneMulti, i).takeUnretainedValue() as String
            convertTelFromSimulator(aPhone)
        }

    }
    
    //取消按钮代理
    func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController!) {
       peoplePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    //选择电话号码(真机走此方法)
   func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, shouldContinueAfterSelectingPerson person: ABRecordRef!) -> Bool {
    var phoneMulti : ABMutableMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneProperty).takeUnretainedValue()
    for var i = 0; i < ABMultiValueGetCount(phoneMulti); i++ {
        var aPhone : String  = ABMultiValueCopyValueAtIndex(phoneMulti, i).takeUnretainedValue() as String
       convertTelFromPhone(aPhone)
    }
    peoplePicker.dismissViewControllerAnimated(true, completion: nil)
    return false
    }
    /**选择司机数量*/
    @IBAction func driverNumberBtnClick(sender: AnyObject) {
        var btn : UIButton = sender as UIButton
        switch(btn.tag){
        case 90 :
                driverNum = 1
        case 91 :
            driverNum = 2
        case 92 :
            driverNum = 3
        case 93 :
            driverNum = 4
        default :
            driverNum = 0
        }
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
        
        
        AMsearch!.delegate = self
        /**默认所选司机人数是1*/
        driverNum = 1
        /**TODO 默认电话为本机的*/
                
        initView()
      
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        /**设置NavigationController的标题*/
        self.title = "一键下单"
        var clickOrderNav = appDelegate.clickOrderNavigation
        clickOrderNav!.navigationBar.backgroundColor = UIColor(red: 226.0 / 255.0, green: 234.0 / 255.0, blue: 237.0 / 255.0, alpha: 1)
        if selectPlace != nil {
            selectPlaceLabel.text = selectPlace!
        }
        else{
            selectPlaceLabel.text = currentLabel!.text
            
        }
        
    }
    
    /**界面的一些初始化*/
    func initView(){
        var phoneVC : UIView = self.view.viewWithTag(100)!
        var location : UIView = self.view.viewWithTag(101)!
        var btn : UIButton = self.view.viewWithTag(90) as UIButton
        btn.layer.cornerRadius = 7
        previousBtn = btn
        previousBtn!.backgroundColor = UIColor(patternImage: UIImage(named: "order_driver_num_selected"))
        var clickBtn : UIButton = self.view.viewWithTag(94) as UIButton
        phoneVC.layer.cornerRadius = 7
        location.layer.cornerRadius = 7
        clickBtn.layer.cornerRadius = 10
       
        
    }
     //订单网络请求成功和失败的代理
    func createOrderByPlaceFinish(request : ASIFormDataRequest){
        var dic : NSDictionary = NSJSONSerialization.JSONObjectWithData(request.responseData(), options: NSJSONReadingOptions.MutableContainers, error:NSErrorPointer()) as NSDictionary
        if dic["res"].isEqual("0"){
        var msg : NSDictionary = dic["msg"] as NSDictionary
        orderNos = msg["orderNos"] as? NSArray
        AlertUtil.showAlert("下单成功")
        println("orderNos:\(orderNos!)")
            //TODO 开启消息推送进行实时会话
        }
        else{
            var err = dic["msg"] as String
            AlertUtil.showAlert(err as String)
        }

    }
    func createOrderByPlaceFail(request :ASIFormDataRequest){
        /**未连接到网络*/
        if request.error.code == 1{
            //appDelegate.window!.addSubview(NONETVIEWVC.view)
        }

    }

    /**选择所在位置*/
    @IBAction func searchPlace(sender: AnyObject) {
        var selectPlaceVC : selectPlaceViewController = PackViewControllerUtil.ViewControllerUtil(storyName: "ClickOrder", viewControllerName: "selectPlaceVC") as selectPlaceViewController
        self.presentViewController(selectPlaceVC, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    /**将手机号码转为标准格式(真机)*/
    func convertTelFromPhone(tel : String){
        var str1 : NSString = tel as NSString
        var a : NSString = str1.substringWithRange(NSRange(location: 0, length: 3))
        var b : NSString = str1.substringWithRange(NSRange(location: 4, length: 4))
        var c : NSString = str1.substringWithRange(NSRange(location: 9, length: 4))
        contactPhone.text = "\(a)\(b)\(c)"
    }
    /**将手机号码转为标准格式(模拟器)*/
    func convertTelFromSimulator(tel : String){
        var str1 : NSString = tel as NSString
        var a : NSString = str1.substringWithRange(NSRange(location: 0, length: 1))
        var b : NSString = str1.substringWithRange(NSRange(location: 3, length: 3))
        var c : NSString = str1.substringWithRange(NSRange(location: 8, length: 3))
        var d : NSString = str1.substringWithRange(NSRange(location: 12, length: 4))
        contactPhone.text = "\(a)\(b)\(c)\(d)"
    }
    
//    //转换为地址信息
//    func convertReGeocode(){
//        var reGeoRequest : AMapReGeocodeSearchRequest = AMapReGeocodeSearchRequest()
//        reGeoRequest.searchType = AMapSearchType_ReGeocode
//        reGeoRequest.location = AMapGeoPoint.locationWithLatitude(CGFloat(startLat!), longitude: CGFloat(startLng!))
//        //reGeoRequest.requireExtension = true
//        AMsearch!.AMapReGoecodeSearch(reGeoRequest)
//    }
//    //转换成地址信息的代理
//    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
//        var reGeo : AMapReGeocode = response.regeocode
//        selectPlaceLabel.text = reGeo.formattedAddress
//    }
//
    


}
