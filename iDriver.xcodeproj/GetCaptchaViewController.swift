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
    @IBOutlet var telephoneTextField: UITextField
    /**获取验证码*/
    @IBAction func next(sender: AnyObject) {
        telephone = self.telephoneTextField.text
        var serviceResponse : NSData = dataRequest.dataRequest("verifySms?phone=" + self.telephoneTextField.text)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.telephoneTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "填写手机号码"
    }

    

}
