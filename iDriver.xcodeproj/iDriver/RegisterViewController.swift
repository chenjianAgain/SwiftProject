//
//  RegisterViewController.swift
//  test
//
//  Created by Gao  Li on 14/7/18.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

/**用于填写电话号码*/
var phoneNumberTextField : UITextField?
/**记录是否阅读并同意条款*/
var isCheckBox : Bool = false
/**条款按钮*/
var clauseBtn : UIButton?
/**获取的验证码*/
var getCaptcha : String?

//var appDelegate1 : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate


class RegisterViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 140.0 / 255.0, green: 167.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        initFillPhoneNumberView()

        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "填写手机号码"
        
        var leftItem : UIBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        self.navigationItem.leftBarButtonItem = leftItem

    }
    func back(){
//        var tabBar = appDelegate1.tabBarVC
//        self.presentViewController(tabBar, animated: true, completion: nil)
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func initFillPhoneNumberView(){
        var titleLabel1 : UILabel = UILabel(frame: CGRectMake(50, 100, 250, 30))
        titleLabel1.text = "全国最快捷，最专业的代驾APP"
        titleLabel1.textAlignment = NSTextAlignment.Center
        self.view.addSubview(titleLabel1)
        
        /**输入电话号码*/
        phoneNumberTextField = UITextField(frame: CGRectMake(titleLabel1.frame.origin.x, titleLabel1.frame.origin.y + titleLabel1.frame.size.height + 5, titleLabel1.frame.size.width, 30))
        phoneNumberTextField!.borderStyle = UITextBorderStyle.RoundedRect
        phoneNumberTextField!.placeholder = "请输入电话号码"
        phoneNumberTextField!.delegate = self
        self.view.addSubview(phoneNumberTextField)
        /**勾选按钮*/
        clauseBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        clauseBtn!.frame = CGRectMake(phoneNumberTextField!.frame.origin.x, phoneNumberTextField!.frame.origin.y + phoneNumberTextField!.frame.size.height + 10, 10, 10)
        clauseBtn!.setImage(UIImage(named: "checkBoxNormal"), forState: UIControlState.Normal)
        clauseBtn!.addTarget(self, action: "selectCheckBox:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(clauseBtn)
        /**关于条款*/
        var clauseLabel : UILabel = UILabel(frame: CGRectMake(clauseBtn!.frame.origin.x + 5, clauseBtn!.frame.origin.y, 200, 10))
        clauseLabel.text = "我已阅读并同意条款"
        clauseLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(clauseLabel)
        /**next按钮*/
        var nextBtn : UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        nextBtn.frame = CGRectMake(clauseBtn!.frame.origin.x
            + 20, clauseBtn!.frame.origin.y
                + 40, 150, 50)
        nextBtn.tag = 50
        if isCheckBox{
            nextBtn.enabled = true
        }
        else{
            nextBtn.enabled = false
        }
        nextBtn.setTitle("下一步", forState: UIControlState.Normal)
               nextBtn.addTarget(self, action: "nextBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(nextBtn)
        
    }
    
    func selectCheckBox(sender : UIButton){
        var btn : UIButton = sender
        var nextBtn : UIButton = self.view.viewWithTag(50) as UIButton
        if isCheckBox{
            btn.setImage(UIImage(named: "checkBoxNormal"), forState: UIControlState.Normal)
            isCheckBox = false
            nextBtn.enabled = false
        }
        else{
            btn.setImage(UIImage(named: "checkBoxSelect"), forState: UIControlState.Normal)
            isCheckBox = true
            nextBtn.enabled = true
        }
    }
    
    func nextBtn(sender: UIButton){
       
        //加载一个NSURL对象
        var serviceurl : String = NSBundle.mainBundle().objectForInfoDictionaryKey("service_url") as String
        var totalString = serviceurl + "verifySms?imsi=460011418603054&phone=" + phoneNumberTextField!.text
        println("验证码接口：" + totalString)
        var encodingTotalString = totalString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var serviceRequest : NSURLRequest = NSURLRequest(URL: NSURL.URLWithString(encodingTotalString))
        //将请求的url数据放到NSData对象中
        var serviceResponse : NSData = NSURLConnection.sendSynchronousRequest(serviceRequest, returningResponse: AutoreleasingUnsafePointer.null(), error: AutoreleasingUnsafePointer.null()) as NSData
       //IOS自带解析类NSJSONSerialization从response中解析出数据放到字典中
        var serviceDic : NSDictionary = NSJSONSerialization.JSONObjectWithData(serviceResponse, options: NSJSONReadingOptions.MutableLeaves, error: AutoreleasingUnsafePointer.null()) as NSDictionary
        var msgDic : NSDictionary = serviceDic.objectForKey("msg") as NSDictionary
        getCaptcha = msgDic.objectForKey("code") as? String
        println("验证码：" + getCaptcha!)
        var fillIdentifyNumberVC : fillIdentifyNumberViewController = PackViewControllerUtil.ViewControllerUtil(storyName: "Register", viewControllerName: "fillIdentifyNumberVC") as fillIdentifyNumberViewController
        /**传递数据*/
        self.navigationController.pushViewController(fillIdentifyNumberVC, animated: true)
        
    }
    
    
    

    

   
}
