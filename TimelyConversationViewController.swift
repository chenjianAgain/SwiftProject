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
    
    @IBOutlet var timelyConversationTableView: UITableView?
    
    @IBAction func back(sender: UIButton) {
    
    
        self.dismissViewControllerAnimated(true, completion: nil)
        
        tabBarView!.hidden = false
    }
    

    
    
    var chatVC : ChatViewController?
    var historyVC : HistoryConversationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatVC = (PackViewControllerUtil.ViewControllerUtil(storyName: "Chat", viewControllerName: "chat5S") as ChatViewController)
        
        historyVC = (PackViewControllerUtil.ViewControllerUtil(storyName: "HistoryConversation", viewControllerName: "history") as HistoryConversationViewController)
        
        timelyConversationTableView!.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)


    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
         /**设置NavigationController的标题*/
        self.title = "实时会话"
        tabBarView!.hidden = true
        
        println(_socket)
    }
    
    /** UITableViewDataSource Methods*/
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int{
        return 2
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            
//TODO真实数据为通过isChat来判断是否有聊天生成，来判断是否返回cell
//            if isChat{
//            
//                return 1
//            }
//            else{
//            
//                return 0
//            }
            return 1
        }
        else{
            return 2
        }
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = timelyConversationTableView!.dequeueReusableCellWithIdentifier("timelyConversationCell", forIndexPath: indexPath) as UITableViewCell!
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        
                
        return cell
    }
    
    /** UITableViewDelegate Methods*/
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 {
            self.presentViewController(chatVC, animated: true, completion: nil)
        } else {
           self.presentViewController(historyVC, animated: true, completion: nil)
        }
        
    }
  
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {

        return 95
    }
    
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
    
        return 30
   
   }
    
    func tableView(tableView: UITableView!, heightForFooterInSection section: Int) -> CGFloat {
    
        return 0.00000001
    }
    
    //header的一切相关设置
    func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
    
        var headerView : UIView = UIView(frame: CGRectMake(0, 0, timelyConversationTableView!.bounds.size.width, 30))
        headerView.backgroundColor = UIColor(red: 207/255, green: 207/255, blue: 207/255, alpha: 1)
        var headerTitle : UILabel = UILabel(frame: CGRectMake(10, 0, timelyConversationTableView!.bounds.size.width, 30))
        
        if section == 0 {
            
            headerTitle.text = "当前会话"
            
        }
        else {
        
            headerTitle.text = "历史会话"
        }
        
        headerView.addSubview(headerTitle)
        
        
        return headerView
    }

  
}
