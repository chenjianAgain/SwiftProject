//
//  UserCenterViewController.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/10.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit
/**
用户中心页面
*/

class UserCenterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /**用户中心列表*/
    var userCenterTableView : UITableView?
    /**列表内容即数据源*/
    let userItemsArray : NSArray = ["我的信息","我的爱车","历史订单","常见问题","如何收费","代驾协议","关于车谱"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        self.view.autoresizesSubviews = true
        /**将用户中心列表放到视图上并进行属性设置*/
        self.userCenterTableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        self.userCenterTableView!.delegate = self
        self.userCenterTableView!.dataSource = self
        self.userCenterTableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "userCenterCell")
        self.view.addSubview(self.userCenterTableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        /**设置NavigationController的标题*/
        self.title = "用户中心"
        
    }
     // UITableViewDataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.userItemsArray.count
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCenterCell", forIndexPath: indexPath) as UITableViewCell!
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel.text = self.userItemsArray[indexPath.row] as String
        return cell
    }
    
     // UITableViewDelegate Methods
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        
    }



}
