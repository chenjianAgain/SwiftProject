//
//  LoginPath.swift
//  iDriver
//
//  Created by Gao  Li on 14/8/6.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

class LoginPath: NSObject {
   
   class func getLoginPath() -> NSString{
        var loginPath : NSString = NSHomeDirectory().stringByAppendingPathComponent("Documents")
        println(loginPath)
        loginPath = loginPath.stringByAppendingPathComponent("login.plist")
        return loginPath
    }

}
