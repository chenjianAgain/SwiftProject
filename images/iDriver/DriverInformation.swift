//
//  DriverInformation.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/24.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

var driverName : String?
var driverNumber : String?

class DriverInformation: NSObject {
   
  
    func initDictionary(dictionary : NSDictionary) -> AnyObject{
        
//        self.driverName = dictionary.objectForKey("name") as? String
//        self.driverNumber! = dictionary.objectForKey("no") as? String
        return self
    }
    
}
