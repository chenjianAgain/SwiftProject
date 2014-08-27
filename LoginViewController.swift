//
//  LoginViewController.swift
//  iDriver
//
//  Created by Gao  Li on 14/8/4.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

var captcha : String?
var telephone : String?
var tokenNo : String?
var timmer : NSTimer?
var loginStatus : Bool?


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var againBtn: UIButton!
    @IBOutlet var timeLabel: UILabel?
    @IBOutlet var captchaTextField: UITextField?
    //重新获取验证码
    @IBAction func againGetCaptcha(sender: AnyObject) {
        
        timmer!.invalidate()
        var againCaptcha : String = SERVICEURL + "verifySms?phone=" + telephone!
        println("againCaptchaRequestURL:\(againCaptcha)")
        var url : NSURL = NSURL(string:againCaptcha)
        var againCaptchaRequest = ASIFormDataRequest(URL: url)
        againCaptchaRequest.delegate = GetCaptchaViewController()
        againCaptchaRequest.requestMethod = "GET"
        againCaptchaRequest.didFinishSelector = "againGetCaptchaFinish:"
        againCaptchaRequest.didFailSelector = "againGetCaptchaFail:"
        againCaptchaRequest.startAsynchronous()

    }
    
    @IBOutlet var label: UILabel?
    @IBOutlet var showCaptchaLabel: UILabel?
    /**提交登录*/
    @IBAction func LoginBtnClick(sender: AnyObject) {
        if captcha == self.captchaTextField!.text{
            var login : String = SERVICEURL + "login?phone=" + telephone! + "&code=" + self.captchaTextField!.text + "&versionNo=0.1"
            println("loginURL:\(login)")
            var url : NSURL = NSURL(string:login)
            var loginRequest = ASIFormDataRequest(URL: url)
            loginRequest.delegate = self
            loginRequest.requestMethod = "GET"
            loginRequest.didFinishSelector = "loginFinish:"
            loginRequest.didFailSelector = "loginFail:"
            loginRequest.startAsynchronous()
        }
        else{
            AlertUtil.showAlert("验证码错误")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //确定该手机号登录的状态
        loginStatus = false
        //开始重新发送验证码按钮失效
        self.againBtn.userInteractionEnabled = false
        //重新发送按钮下的下划线
        var view : UIView = self.view.viewWithTag(111)!
        view.hidden = true
        //显示验证码
        self.showCaptchaLabel!.hidden = false
        self.showCaptchaLabel!.text = captcha
        //60秒倒计时
        timmer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:Selector("updateTime"), userInfo: nil, repeats: true)
    }
    /**60秒时间倒计时方法*/
    func updateTime(){
        if self.timeLabel!.text == "0"{
            //倒计时完毕时，倒计时label隐藏，重新发送验证码
            timmer!.invalidate()
            self.timeLabel!.hidden = true
            self.label!.hidden = true
            
            self.againBtn.titleLabel.textColor = UIColor(red: 46.0 / 255.0, green: 170.0 / 255.0, blue: 223.0 / 255.0, alpha: 1.0)
            againBtn.userInteractionEnabled = true
            var view : UIView = self.view.viewWithTag(111)!
            view.hidden = false
        }
        else{
        var str : NSString = self.timeLabel!.text
        var a  = str.intValue
        a = a - 1
        self.timeLabel!.text = String(a)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "填写验证码"
    }
    
    
    func loginSave(){
        var loginDic : NSMutableDictionary = NSMutableDictionary.dictionary()
        loginDic.setObject(telephone, forKey: "telephone")
        loginDic.setObject(tokenNo, forKey: "tokenNo")
        loginDic.setObject(captcha, forKey: "captcha")
       loginDic.setObject(loginStatus, forKey: "status")
        loginDic.writeToFile(LoginPath.getLoginPath(), atomically: true)
        
    }
    
    //登录请求成功和失败的代理
    func loginFinish(request : ASIHTTPRequest){
        var dic : NSDictionary = NSJSONSerialization.JSONObjectWithData(request.responseData(), options: NSJSONReadingOptions.MutableContainers, error:NSErrorPointer()) as NSDictionary
        println("loginDic:\(dic)")
        if dic["res"].isEqual("0"){
            var msgDic : NSDictionary = dic.objectForKey("msg") as NSDictionary
            tokenNo = msgDic.objectForKey("tokenNo") as? String
            println("tokenNo:\(tokenNo!)")
            timmer!.invalidate()
            AlertUtil.showAlert("登录成功")
            loginStatus = true
            loginSave()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "login")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        else{
            var errStr : String = dic["msg"] as String
            println(errStr)
        }

    }
    func loginFail(request :ASIFormDataRequest ){
        /**未连接到网络*/
        if request.error.code == 1{
           // appDelegate.window!.addSubview(NONETVIEWVC.view)
        }

    }
    
     //再次获得验证码请求成功和失败的代理
    func againGetCaptchaFinish(request : ASIHTTPRequest){
        var dic : NSDictionary = NSJSONSerialization.JSONObjectWithData(request.responseData(), options: NSJSONReadingOptions.MutableContainers, error:NSErrorPointer()) as NSDictionary
        println("captchaDic:\(dic)")
        if dic["res"].isEqual("0"){
            var dic1 : NSDictionary = dic["msg"] as NSDictionary
            captcha = dic1["code"] as? String
        }
        else{
            var errStr : String = dic["msg"] as String
            println(errStr)
        }
    }
    
    func againGetCaptchaFail(request :ASIFormDataRequest){
        /**未连接到网络*/
        if request.error.code == 1{
            //appDelegate.window!.addSubview(NONETVIEWVC.view)
        }

    }


  
}
