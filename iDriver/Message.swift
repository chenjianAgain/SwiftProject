//
//  Message.swift
//  iDriver
//
//  Created by tp on 14-7-28.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

//enum MessageType : Int{
//    
//   case MessageTypeMe = 0 // 自己发的
//   case MessageTypeOther = 1  //别人发得
//    
//}


var icon : NSString?
var content : NSString?
var type : Int?
let MessageTypeMe = 0
let MessageTypeOther = 1


class Message: NSObject {
    
    func setDict(dict : NSDictionary){
    
        icon = dict["icon"] as? NSString
        content = dict["content"] as? NSString
        type = dict["type"] as? Int

    }
}
