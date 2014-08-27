//
//  GetCaptchaViewController.swift
//  iDriver
//
//  Created by Gao  Li on 14/8/4.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

class GetCaptchaViewController: UIViewController,UITextFieldDelegate {
   /**填写手机号*/
    @IBOutlet var telephoneTextField: UITextField?
    @IBOutlet weak var isAgreeBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    var isAgree : Bool?
    
    @IBAction func isAgreeBtnClick(sender: AnyObject) {
        if isAgree == true{
            isAgree! = false
            self.nextBtn.enabled = false
            isAgreeBtn.setImage(UIImage(named: "user_selectbox"), forState: UIControlState.Normal)
        }
        else{
            isAgree! = true
            self.nextBtn.enabled = true
            isAgreeBtn.setImage(UIImage(named: "user_selectbox_selected"), forState: UIControlState.Normal)
        }
    }
    @IBAction func rulesBtnClick(sender: AnyObject) {
        var rulesVC : RulesViewController = PackViewControllerUtil.ViewControllerUtil(storyName: "Register", viewControllerName: "rulesVC") as RulesViewController
        self.navigationController.pushViewController(rulesVC, animated: true)
    }
    /**获取验证码*/
    @IBAction func next(sender: AnyObject) {
        telephone = self.telephoneTextField!.text
        var getCaptcha : String = SERVICEURL + "verifySms?phone=" + self.telephoneTextField!.text
        var url : NSURL = NSURL(string:getCaptcha)
        var captchaRequest = ASIFormDataRequest(URL: url)
        captchaRequest.delegate = self
        captchaRequest.requestMethod = "GET"
        captchaRequest.didFinishSelector = "getCaptchaFinish:"
        captchaRequest.didFailSelector = "getCaptchaFail:"
        captchaRequest.startAsynchronous()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.telephoneTextField!.delegate = self
        isAgree = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "填写手机号码"
    }

    //网络请求成功和失败的代理
    func getCaptchaFinish(request : ASIHTTPRequest){
        var dic : NSDictionary = NSJSONSerialization.JSONObjectWithData(request.responseData(), options: NSJSONReadingOptions.MutableContainers, error:NSErrorPointer()) as NSDictionary
        println("captchaDic:\(dic)")
        if dic["res"].isEqual("0"){
            var dic1 : NSDictionary = dic["msg"] as NSDictionary
            captcha = dic1["code"] as? String
            var loginVC : UINavigationController = PackViewControllerUtil.ViewControllerUtil(storyName: "Register", viewControllerName: "loginNav") as UINavigationController
            self.presentViewController(loginVC, animated: true, completion: nil)
        }
        else{
            var errStr : String = dic["msg"] as String
        }
    }
    
    func getCaptchaFail(request :ASIFormDataRequest){
        /**未连接到网络*/
        if request.error.code == 1{
            //appDelegate.window!.addSubview(NONETVIEWVC.view)
        }
    }


}
