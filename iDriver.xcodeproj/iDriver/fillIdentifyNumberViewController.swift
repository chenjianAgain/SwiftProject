//
//  fillIdentifyNumberViewController.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/18.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

var captchaTextfield : UITextField?
var showCaptchaLabel : UILabel?
var tokenNo : String?

class fillIdentifyNumberViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 140.0 / 255.0, green: 167.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        captcha()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func captcha(){
        var fillIdentifyNumberlabel : UILabel = UILabel(frame: CGRectMake(20, self.navigationController.navigationBar.frame.size.height + 50, 100, 30))
        fillIdentifyNumberlabel.text = "获取验证码"
        self.view.addSubview(fillIdentifyNumberlabel)
        
        captchaTextfield = UITextField(frame: CGRectMake(fillIdentifyNumberlabel.frame.origin.x + 10 + fillIdentifyNumberlabel.frame.size.width, fillIdentifyNumberlabel.frame.origin.y, 150, fillIdentifyNumberlabel.frame.size.height))
        captchaTextfield!.delegate = self
        captchaTextfield!.borderStyle = UITextBorderStyle.RoundedRect
        captchaTextfield!.placeholder = "请输入验证码"
        self.view.addSubview(captchaTextfield)
        
        var registerBtn : UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        registerBtn.frame = CGRectMake(fillIdentifyNumberlabel.frame.origin.x + 50, fillIdentifyNumberlabel.frame.origin.y + fillIdentifyNumberlabel.frame.size.height + 50, 100, 50)
        registerBtn.setTitle("注册", forState: UIControlState.Normal)
        registerBtn.addTarget(self, action: "registerBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(registerBtn)
        
        /**显示验证码*/
        showCaptchaLabel = UILabel(frame:CGRectMake(130, 370, 112, 21))
        showCaptchaLabel!.text = getCaptcha
        showCaptchaLabel!.tag = 70
        self.view.addSubview(showCaptchaLabel)
        let removeIdentifyNumberLabel : NSTimer =  NSTimer.scheduledTimerWithTimeInterval(3.0, target:self, selector:"removeCaptchaLabel", userInfo:nil, repeats:false)

    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var leftItem : UIBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        self.navigationItem.leftBarButtonItem = leftItem
        self.title = "填写验证码"
    }
    
    func removeCaptchaLabel(){
        var identifyLabel : UILabel = self.view.viewWithTag(70) as UILabel
        identifyLabel.removeFromSuperview()
    }
    
    func back(){
        self.navigationController.popToRootViewControllerAnimated(true)
    }
    
    func registerBtn(sender : UIButton){

        if (captchaTextfield!.text == showCaptchaLabel!.text) {
            // FIXED 联网校验
            // TODO
            // XXX
            //加载一个NSURL对象
        /**先登录*/
        var serviceurl : String = NSBundle.mainBundle().objectForInfoDictionaryKey("service_url") as String
        var loginRequest : NSURLRequest = NSURLRequest(URL: NSURL.URLWithString(serviceurl + "login?imsi=460011418603054&versionNo=0.1"))
                    println(loginRequest.URL)
        var loginResponse : NSData = NSURLConnection.sendSynchronousRequest(loginRequest, returningResponse: AutoreleasingUnsafePointer.null(), error: AutoreleasingUnsafePointer.null()) as NSData
        var loginDic : NSMutableDictionary = NSJSONSerialization.JSONObjectWithData(loginResponse, options: NSJSONReadingOptions.MutableLeaves, error: AutoreleasingUnsafePointer.null()) as NSMutableDictionary
            if loginDic["res"].integerValue == 0{
                tokenNo = loginDic["msg"] as? String
                println("tokenNo :" + tokenNo!)
            }
            
            //else{
                /**登录失败，自动注册*/
    //        var serviceurl : String = NSBundle.mainBundle().objectForInfoDictionaryKey("service_url") as String
    //        var registerRequest : NSURLRequest = NSURLRequest(URL: NSURL.URLWithString(serviceurl + "register?imsi=460011418603054&code=" + showCaptchaLabel!.text + "&phone=" + phoneNumberTextField!.text + "&versionNo=0.1"))
    //        println(registerRequest.URL)
    //            //将请求的url数据放到NSData对象中
    //        var registerResponse : NSData = NSURLConnection.sendSynchronousRequest(registerRequest, returningResponse: AutoreleasingUnsafePointer.null(), error: AutoreleasingUnsafePointer.null()) as NSData
    //            //IOS自带解析类NSJSONSerialization从response中解析出数据放到字典中
    //        var registerDic : NSMutableDictionary? = NSJSONSerialization.JSONObjectWithData(registerResponse, options: NSJSONReadingOptions.MutableLeaves, error: AutoreleasingUnsafePointer.null()) as? NSMutableDictionary
    //            println(registerDic)
                /**页面跳转*/
    //            if registerDic!["res"].integerValue  == 0 {
    //                AlertUtil.showAlert("注册成功")
    //            }
//            else{
            //                var errorStr : String = registerDic!["msg"] as String
        //                AlertUtil.showAlert("注册失败," + errorStr)
        //            }

//            }

        }
        else{
           AlertUtil.showAlert("验证码错误")
        }
        
    
        
       
    }
  
}
