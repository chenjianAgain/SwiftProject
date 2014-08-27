// Playground - noun: a place where people can play

import UIKit

var serviceurl = "http://192.168.2.13:9001/autobook-app/service/customerService/"
var url = NSURL(string: serviceurl + "login?imsi=460011418603054&versionNo=0.1")
var data = NSData.dataWithContentsOfURL(url, options: NSDataReadingOptions.DataReadingUncached, error: nil)
var json  : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
if json["res"].integerValue == 0{
    var tokenNo = json["msg"] as? String
    println(tokenNo!)
}

