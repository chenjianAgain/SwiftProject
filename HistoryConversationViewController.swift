//
//  HistoryConversationViewController.swift
//  iDriver
//
//  Created by tp on 14-8-7.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

class HistoryConversationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBAction func back(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        tabBarView!.hidden = false
    }

    
    @IBOutlet var historyChatTable: UITableView?
    
    //装会话的数组
    var sumChat : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        
        return  sumChat.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        
        historyChatTable!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        var cell : UITableViewCell  = historyChatTable!.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            
        }
        
        //清除上一次的视图
        var view : UIView = UIView()
        for view in cell.contentView.subviews {
            
            if view.tag == 1001 || view.tag == 1002 {
                
                view.removeFromSuperview()
            }
        }
        
        //头像
        var imageViewHead : UIImageView = UIImageView()
        imageViewHead.tag = 1001
        
        //气泡
        var imageView : UIImageView = UIImageView()
        imageView.tag = 1002
        
        //文字
        var label : UILabel = UILabel()
        label.tag = 1003
        
        
        label.text = sumChat.objectAtIndex(indexPath.row).objectForKey("content") as NSString
        
        //计算文字内容的宽度和高度
        var chatTextFont : NSDictionary = [NSFontAttributeName : UIFont.systemFontOfSize(16)]
        let width : CGFloat = 200
        let height : CGFloat = 100000
        
        
        
        var size : CGSize = label.text.boundingRectWithSize(CGSizeMake(width,height), options: NSStringDrawingOptions.TruncatesLastVisibleLine , attributes: chatTextFont, context: nil).size
        
        //        var size : CGSize = label.text.boundingRectWithSize(CGSizeMake(width,height), options: NSStringDrawingOptions.TruncatesLastVisibleLine | NSStringDrawingOptions.UsesFontLeading | NSStringDrawingOptions.UsesLineFragmentOrigin , attributes: chatTextFont, context: nil).size
        
        //设置头像文字气泡等
        if (sumChat.objectAtIndex(indexPath.row).objectForKey("name")).isEqual("tom") {
            
            imageViewHead.image = UIImage(named: "icon01.png")
            imageViewHead.frame = CGRectMake(10, 10, 45, 45)
            
            imageView.image = UIImage(named: "convo_bg_left.png")
            label.frame = CGRectMake(20, 10, size.width+80, size.height+40)
            label.textAlignment = NSTextAlignment.Center
            
            imageView.frame = CGRectMake(45 + 15, 10, size.width+100, size.height+60)
            
            
        }
            
        else {
            
            imageViewHead.image = UIImage(named: "icon02.png")
            imageViewHead.frame = CGRectMake(320 - 45 - 10, 10, 45, 45)
            imageView.image = UIImage(named: "convo_bg_right.png")
            label.frame = CGRectMake(20, 10, size.width+80, size.height+40)
            imageView.frame = CGRectMake(320-imageViewHead.frame.size.width-size.width-45-15-55, 10, size.width+100, size.height+60)
            
        }
        
        var top : CGFloat = 20       // 顶端盖高度
        var bottom : CGFloat = 20     // 底端盖高度
        var left : CGFloat = 20      // 左端盖宽度
        var right : CGFloat = 20     // 右端盖宽度
        
        var insets : UIEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right)
        // 指定为拉伸模式，伸缩后重新赋值
        imageView.image = imageView.image.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
        
        cell.backgroundColor = UIColor.clearColor()
        imageView.addSubview(label)
        cell.contentView.addSubview(imageView)
        cell.contentView.addSubview(imageViewHead)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    
    
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat{
        
        var string : NSString = sumChat.objectAtIndex(indexPath.row).objectForKey("content") as NSString
        var chatTextFont : NSDictionary = [NSFontAttributeName : UIFont.systemFontOfSize(16)]
        let width : CGFloat = 200
        let height : CGFloat = 10000
        
        var size : CGSize = string.boundingRectWithSize(CGSizeMake(width,height), options: NSStringDrawingOptions.TruncatesLastVisibleLine , attributes: chatTextFont, context: nil).size
        
        
        return size.height + 70
    }

    
    
    
    
    
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
