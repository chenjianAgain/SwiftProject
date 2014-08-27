//
//  dataRequest.swift
//  iDriver
//
//  Created by Gao  Li on 14/8/1.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

class dataRequest: NSObject {
   
    class func dataRequest(urlStr : String) -> NSData{
        var serviceurl : String = NSBundle.mainBundle().objectForInfoDictionaryKey("service_url") as String
        var totalStr : String = serviceurl + urlStr
        var requestURL : NSURL = NSURL(string: totalStr)
        println(requestURL)
        var request : NSURLRequest = NSURLRequest(URL: requestURL)
        var response : AutoreleasingUnsafePointer<NSURLResponse?> = nil
        var error : AutoreleasingUnsafePointer<NSErrorPointer?>=nil
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse:response, error:nil)
        return data
    }
    
}
