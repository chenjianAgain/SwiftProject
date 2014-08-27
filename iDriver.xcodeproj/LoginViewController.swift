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

class LoginViewController: UIViewController {
    
    
    @IBOutlet var timeLabel: UILabel
    @IBOutlet var captchaTextField: UITextField
    @IBAction func againGetCaptcha(sender: AnyObject) {
        var serviceResponse : NSData = dataRequest.dataRequest("verifySms?phone=" + telephone!)
        var serviceDic : NSDictionary = NSJSONSerialization.JSONObjectWithData(serviceResponse, options: NSJSONReadingOptions.MutableLeaves, error: AutoreleasingUnsafePointer.null()) as NSDictionary
        if(serviceDic.objectForKey("res").isEqual("0")){
            var msgDic : NSDictionary = serviceDic.objectForKey("msg") as NSDictionary
            captcha = msgDic.objectForKey("code") as? String
            println(captcha)
        }
        else{
            var errorString : String = serviceDic.objectForKey("msg") as String
            AlertUtil.showAlert(errorString)
        }

    }
    
    @IBOutlet var label: UILabel
    @IBOutlet var showCaptchaLabel: UILabel
    /**提交登录*/
    @IBAction func LoginBtnClick(sender: AnyObject) {
        if captcha == self.captchaTextField.text{
            var serviceResponse : NSData = dataRequest.dataRequest("login?phone=" + telephone! + "&code=" + self.captchaTextField.text + "&versionNo=0.1")
            var serviceDic : NSDictionary = NSJSONSerialization.JSONObjectWithData(serviceResponse, options: NSJSONReadingOptions.MutableLeaves, error: AutoreleasingUnsafePointer.null()) as NSDictionary
            if(serviceDic.objectForKey("res").isEqual("0")){
                timmer!.invalidate()
                var msgDic : NSDictionary = serviceDic.objectForKey("msg") as NSDictionary
                tokenNo = msgDic.objectForKey("tokenNo") as? String
//                self.navigationController.navigationBar.removeFromSuperview()
//                self.view.removeFromSuperview()
                println(tokenNo)
            }
            else{
                var errorString : String = serviceDic.objectForKey("msg") as String
                AlertUtil.showAlert(errorString)
            }

        }
        else{
            AlertUtil.showAlert("验证码错误")
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //开始重新发送验证码按钮失效
        var againBtn : UIButton = self.view.viewWithTag(110) as UIButton
        againBtn.userInteractionEnabled = false
        //重新发送按钮下的下划线
        var view : UIView = self.view.viewWithTag(111)
        view.hidden = true
        //显示验证码
        self.showCaptchaLabel.text = captcha
        //60秒倒计时
        timmer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:Selector("updateTime"), userInfo: nil, repeats: true)
    }
    /**60秒时间倒计时方法*/
    func updateTime(){
        if self.timeLabel.text == "0"{
            //倒计时完毕时，倒计时label隐藏，重新发送验证码
            timmer!.invalidate()
            self.timeLabel.hidden = true
            self.label.hidden = true
            
            var againBtn : UIButton = self.view.viewWithTag(110) as UIButton
            againBtn.titleLabel.textColor = UIColor(red: 46.0 / 255.0, green: 170.0 / 255.0, blue: 223.0 / 255.0, alpha: 1.0)
            againBtn.userInteractionEnabled = true
            var view : UIView = self.view.viewWithTag(111)
            view.hidden = false
            
        }
        else{
        var str : NSString = self.timeLabel.text
        var a  = str.intValue
        a = a - 1
        self.timeLabel.text = String(a)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "填写验证码"
    }

    

  
}
