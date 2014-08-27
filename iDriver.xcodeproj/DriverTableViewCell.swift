//
//  DriverTableViewCell.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/31.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit



class DriverTableViewCell: UITableViewCell {
   
    
    var data : NSDictionary?
    var driverPhoto: UIImageView?
    var driverStatus : UIImageView?
    var driverStar : UIView?
    var driverName: UILabel?
    var driverLicense: UILabel?
    var driveYears: UILabel?
    var driveTimes: UILabel?
    var driverHome: UILabel?
    var driverDistance: UILabel?
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       driverPhoto = UIImageView(frame: CGRectMake(10,10,75,75))
       driverName = UILabel(frame: CGRectMake(driverPhoto!.frame.origin.x + driverPhoto!.frame.size.width + 10,driverPhoto!.frame.origin.y ,70 ,25 ))
       driverStar = UIView(frame: CGRectMake(driverName!.frame.origin.x + driverName!.frame.size.width, driverName!.frame.origin.y, 88, driverName!.frame.size.height))
       driverStatus = UIImageView(frame: CGRectMake(driverStar!.frame.origin.x + driverStar!.frame.size.width, driverStar!.frame.origin.y, 60, driverStar!.frame.size.height))
        driverStatus!.image = UIImage(named: "driver_statusicon_usable")
        var label : UILabel = UILabel (frame: driverStatus!.frame)
        label.text = "空闲"
        label.textAlignment = NSTextAlignment.Center
        label.backgroundColor = UIColor.redColor()
        label.textColor = UIColor.redColor()
        label.hidden = false
        driverStatus!.insertSubview(label, atIndex: 2)
       driverLicense = UILabel(frame: CGRectMake(driverName!.frame.origin.x, driverName!.frame.origin.y + driverName!.frame.size.height,30 ,25 ))
       driverLicense!.font = UIFont.systemFontOfSize(14.0)
       driveYears = UILabel(frame: CGRectMake(driverLicense!.frame.origin.x + driverLicense!.frame.size.width , driverLicense!.frame.origin.y, 70, 25))
        driveYears!.font = UIFont.systemFontOfSize(14.0)
       driveTimes = UILabel(frame: CGRectMake(driveYears!.frame.origin.x + driveYears!.frame.size.width, driveYears!.frame.origin.y, 70, 25))
        driveTimes!.font = UIFont.systemFontOfSize(14.0)
       driverHome = UILabel(frame: CGRectMake(driveTimes!.frame.origin.x + driveTimes!.frame.size.width, driveTimes!.frame.origin.y,30 ,25 ))
       driverHome!.font = UIFont.systemFontOfSize(14.0)
       driverDistance = UILabel(frame: CGRectMake(driverLicense!.frame.origin.x, driverLicense!.frame.origin.y + driverLicense!.frame.size.height,100,25 ))
       driverDistance!.font = UIFont.systemFontOfSize(14.0)
       self.addSubview(driverPhoto)
       self.addSubview(driverName)
       self.addSubview(driverStar)
       self.addSubview(driverStatus)
       self.addSubview(driverLicense)
       self.addSubview(driveYears)
       self.addSubview(driveTimes)
       self.addSubview(driverHome)
       self.addSubview(driverDistance)
        
    }
   
    
    
    func updateCell(){
        var driver : NSDictionary = self.data!
        var imageStr : String = driver["pic"] as String
        driverPhoto!.image = UIImage(named: imageStr)
       driverName!.text = driver["name"] as String
       driverLicense!.text = driver["lType"] as String
        var driverY = driver["dAge"] as String
       driveYears!.text = "驾龄" + driverY + "年"
        var driverT = driver["sCount"] as String
       driveTimes!.text =  "代驾" + driverT + "次"
       driverHome!.text = driver["place"] as String
        var driverD = String(driver["dist"] as Int)
       driverDistance!.text = "距离" + driverD + "公里"
        var grade = driver["grade"] as CGFloat
        StarUtil.showDriverStar(grade, view: driverStar!)
        
    }
    
  
    
}
