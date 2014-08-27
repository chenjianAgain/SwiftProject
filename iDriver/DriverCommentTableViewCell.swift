//
//  DriverCommentTableViewCell.swift
//  iDriver
//
//  Created by Gao  Li on 14/8/4.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit



class DriverCommentTableViewCell: UITableViewCell {

    let TIME : Int = 60 * 60
    var commentLabel: UILabel?
    var commentTimeLabel: UILabel?
    var starView: UIView?
    var cellData : NSDictionary?

    override init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        starView = UIView(frame: CGRectMake(0, 0, 160, 20))
        self.addSubview(starView!)
        
        commentTimeLabel = UILabel(frame: CGRectMake(160, 0, 160, 20))
        commentTimeLabel!.font = UIFont(name: commentTimeLabel!.font.fontName, size: 14.0)
        commentTimeLabel!.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1)
        self.addSubview(commentTimeLabel!)
        
        commentLabel = UILabel(frame: CGRectMake(0, 20, 320, 20))
        self.addSubview(commentLabel!)
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(){
        var dic : NSDictionary = self.cellData!
        var grade : Float = dic["grade"].floatValue
        StarUtil.showDriverStar(grade, view: starView!)
        commentLabel!.text = dic["comment"] as String
        var timeString : String = dic["time"] as NSString
        commentTimeLabel!.text = convertTime(timeString)
        
    }
    
    func convertTime(str : NSString!) -> String{
    var s1 : Float = str.floatValue / 1000
    var s2 : NSString = NSNumber(float: s1).stringValue
    var date : NSDate = NSDate(timeIntervalSince1970: s2.doubleValue)
    let dateStringFormatter = NSDateFormatter()
    dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    var dStr = dateStringFormatter.stringFromDate(date)
    return dStr
    }
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
 
}
