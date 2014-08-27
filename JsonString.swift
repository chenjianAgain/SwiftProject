//
//  JsonString.swift
//  iDriver
//
//  Created by GaoLi on 14-8-12.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

class JsonString: NSObject {
   
    class func isJsonString(str : String) -> Bool{
        if str.hasPrefix("{") || str.hasPrefix("["){
            return true
        }
        else{
            return false
        }
    }
}
