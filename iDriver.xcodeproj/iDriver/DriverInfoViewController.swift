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
var navBackMark : Int?
var commmentArray : NSArray?

class DriverInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var commentTableView: UITableView
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
        var btn : UIButton = self.view.viewWithTag(80) as UIButton
         btn.layer.cornerRadius = 10
        self.commentTableView.delegate = self
        self.commentTableView.dataSource = self
        self.commentTableView.registerClass(DriverCommentTableViewCell.self, forCellReuseIdentifier:"commentCell")
        showDriverInfo()
        /**在这调用接口，获得指定司机的近期评价*/
        commmentArray = [["grade":2.0,"comment":"very good","time":"20140620163234"],["grade":4.0,"comment":"good","time":"20140630163234"]]
        
       
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
   override func viewWillAppear(animated: Bool) {
       super.viewWillAppear(animated)
    self.title = "司机信息"
    var clientBtn : UIButton = nearDriverNav!.navigationBar.viewWithTag(12) as UIButton
    var seg : UISegmentedControl = nearDriverNav!.navigationBar.viewWithTag(13) as UISegmentedControl
    var userBtn : UIButton = nearDriverNav!.navigationBar.viewWithTag(14) as UIButton
    clientBtn.hidden = true
    seg.hidden = true
    userBtn.hidden = true
//    if navBackMark == 0{
//        var backItem1 : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("back"))
//       self.navigationController.navigationItem.rightBarButtonItem = backItem1
//    }
//    else{
//        var backItem2 : UIBarButtonItem = UIBarButtonItem(title: "司机列表", style:UIBarButtonItemStyle.Plain , target:self , action: Selector("back"))
//         self.navigationController.navigationItem.rightBarButtonItem = backItem2
//    }
 
}
    func back(){
        self.navigationController.popToRootViewControllerAnimated(true)
    }
    
    func showDriverInfo(){
        for var i = 0; i < driverListArray!.count ; i++ {
            var driver : NSDictionary = driverListArray!.objectAtIndex(i) as NSDictionary
            var driverNO = driver["no"] as String
            if driverNO == selectDriverNo{
                var imageStr : String = driver["pic"] as String
                self.driverPhoto.image = UIImage(named: imageStr)
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
                StarUtil.showDriverStar(grade, view: self.driverStarView)
            }
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return commmentArray!.count
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        var dic : NSDictionary = commmentArray![indexPath.row] as NSDictionary
        var cell : DriverCommentTableViewCell = tableView.dequeueReusableCellWithIdentifier("commentCell") as DriverCommentTableViewCell
        if cell == nil{
            cell = DriverCommentTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "commentCell")
        }
       cell.cellData = dic
       cell.updateCell()
        return cell
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 40.0
    }

  
}
