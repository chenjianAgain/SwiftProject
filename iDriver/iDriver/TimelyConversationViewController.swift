//
//  TimelyConversationViewController.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/10.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit
/**
实时对话界面
*/
class TimelyConversationViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var mainView : UIView?
    /**定义实时对话列表*/
    var timelyConversationTableView : UITableView?
    /**获取AppDelegate*/
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    /**屏幕的宽*/
    let SCREENWIDTH : CGFloat = UIScreen.mainScreen().bounds.size.width
    /**屏幕的高*/
    let SCREENHEIGHT : CGFloat = UIScreen.mainScreen().bounds.size.height


    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        var timelyConversationNav  = appDelegate.timelyConversationNavigation
        println(timelyConversationNav!.navigationBar.frame)
        /**添加一张新的View.
        这边必须要添加一张新的视图，解决类似autolayout的问题
        */
        mainView = UIView(frame: CGRectMake(0, timelyConversationNav!.navigationBar.frame.size.height + timelyConversationNav!.navigationBar.frame.origin.y , SCREENWIDTH, SCREENHEIGHT - 49))
       mainView!.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        mainView!.autoresizesSubviews = true
        mainView!.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(mainView)
        
        /**在mainView上添加实时对话列表的属性设置*/
        self.timelyConversationTableView = UITableView(frame: CGRectMake(0, mainView!.frame.origin.y , SCREENWIDTH, SCREENHEIGHT), style: UITableViewStyle.Grouped)
        self.timelyConversationTableView!.delegate = self
        self.timelyConversationTableView!.dataSource = self
        self.timelyConversationTableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "timelyConversationCell")
        self.timelyConversationTableView!.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        self.timelyConversationTableView!.autoresizesSubviews = true
        self.view.addSubview(self.timelyConversationTableView)
       
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
         /**设置NavigationController的标题*/
        self.title = "实时会话"
        
    }
    
    /** UITableViewDataSource Methods*/
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int{
        return 2
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2
        }
        else{
            return 5
        }
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
         let cell = tableView.dequeueReusableCellWithIdentifier("timelyConversationCell", forIndexPath: indexPath) as UITableViewCell!
         return cell
    }
    
    /** UITableViewDelegate Methods*/
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        
        var chatVC : ChatViewController = PackViewControllerUtil.ViewControllerUtil(storyName: "Chat", viewControllerName: "chat5S") as ChatViewController
        
        
        self.navigationController.pushViewController(chatVC, animated: true)
        
        
    }
  
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0{
        return 30
    }
    else{
        return 20
    }
        
    }
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        if section == 0{
            return "当前会话"
        }
        else{
            return "历史会话"
        }
    }
    

  
}
