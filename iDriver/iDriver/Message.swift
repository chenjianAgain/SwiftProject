//
//  Message.swift
//  iDriver
//
//  Created by tp on 14-7-28.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

enum MessageType{
    
   case MessageTypeMe  // 自己发的
   case MessageTypeOther  //别人发得
    
}


var icon : NSString?
var content : NSString?
var type : MessageType?
var _dict : NSDictionary?

class Message: NSObject {
    
}
