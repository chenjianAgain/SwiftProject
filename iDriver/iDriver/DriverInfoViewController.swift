//
//  driverInfoViewController.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/28.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit
/**
展示司机的部分信息，并可以进行指定司机的下单*/

var selectDriverNo : String?

class DriverInfoViewController: UIViewController {

   
    @IBOutlet var driverStarView: UIView
    @IBOutlet var driverView: UIView
    @IBOutlet var driverHome: UILabel
    @IBOutlet var driveTimes: UILabel
    @IBOutlet var driveYears: UILabel
    @IBOutlet var driverLicense: UILabel
    @IBOutlet var driverDistance: UILabel
    @IBOutlet var driverName: UILabel
    @IBOutlet var driverPhoto: UIImageView
    
    @IBAction func clickOrder(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for var i = 0; i < driverListArray!.count ; i++ {
            var driver : NSDictionary = driverListArray!.objectAtIndex(i) as NSDictionary
            var driverNO = driver["no"] as String
            if driverNO == selectDriverNo{
            self.driverName.text = driver["name"] as String
            self.driverLicense.text = driver["lType"] as String
            var driverY = driver["dAge"] as String
            self.driveYears.text = "驾龄" + driverY + "年"
            var driverT = driver["sCount"] as String
            self.driveTimes.text =  "代驾" + driverT + "次"
            self.driverHome.text = driver["place"] as String
           var driverD = String(driver["dist"] as Int)
           self.driverDistance.text = "距离" + driverD + "公里"
            var grade = driver["grade"] as CGFloat
            showDriverStar(grade)
             
            }
            
        }
        
     
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
   override func viewWillAppear(animated: Bool) {
       super.viewWillAppear(animated)
    self.title = "司机信息"
    var nearDriverNav  = appDelegate.nearDriverNavigation
    var clientBtn : UIButton = nearDriverNav!.navigationBar.viewWithTag(12) as UIButton
    var seg : UISegmentedControl = nearDriverNav!.navigationBar.viewWithTag(13) as UISegmentedControl
    var userBtn : UIButton = nearDriverNav!.navigationBar.viewWithTag(14) as UIButton
    clientBtn.hidden = true
    seg.hidden = true
    userBtn.hidden = true
    
    }
    func showDriverStar(grade : CGFloat){
        /*取得整数部分*/
        var fullStar  = floor(grade)
        if CGFloat(fullStar) == CGFloat(grade){
            for var i = 0; i < Int(fullStar); i++ {
                var fullStarImg : UIImageView = UIImageView(frame: CGRectMake(CGFloat(i) * 14, 0, 14, self.driverStarView.frame.size.height))
                if i == Int(fullStar) - 1{
                    emptyStarRect = fullStarImg.frame
                }
                
                fullStarImg.image = UIImage(named: "star_light")
                self.driverStarView.addSubview(fullStarImg)
            }
            if Int(fullStar) < 5{
                for var j = 0; j < 5 - Int(fullStar); j++ {
                    var emptyStarImg : UIImageView = UIImageView(frame: CGRectMake(emptyStarRect!.origin.x + emptyStarRect!.size.width, 0, 14, self.driverStarView.frame.size.height))
                    emptyStarImg.image = UIImage(named: "star_unlight")
                    self.driverStarView.addSubview(emptyStarImg)
                    
                }
            }
        }
        else{
            for var i = 0; i < Int(fullStar); i++ {
                var fullStarImg : UIImageView = UIImageView(frame: CGRectMake(CGFloat(i) * 14, 0, 14, self.driverStarView.frame.size.height))
                if i == Int(fullStar) - 1{
                    halfStarRect = fullStarImg.frame
                }
                fullStarImg.image = UIImage(named: "star_light")
                self.driverStarView.addSubview(fullStarImg)
            }
            halfStar = UIImageView(frame: CGRectMake(halfStarRect!.origin.x + halfStarRect!.size.width, 0,14, self.driverStarView.frame.size.height ))
            halfStar!.image = UIImage(named: "star_half_light")
            self.driverStarView.addSubview(halfStar)
            if Int(fullStar) + 1 < 5{
                for var j = 0; j < 4 - Int(fullStar); j++ {
                    var emptyStarImg : UIImageView = UIImageView(frame: CGRectMake(halfStar!.frame.origin.x + halfStar!.frame.size.width + CGFloat(j) * 14, 0, 14, self.driverStarView.frame.size.height))
                    emptyStarImg.image = UIImage(named: "star_unlight")
                    self.driverStarView.addSubview(emptyStarImg)
                    
                }
            }
            
        }
        
        

    }

  
}
