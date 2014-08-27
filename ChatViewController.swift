//
//  ChatViewController.swift
//  iDriver
//
//  Created by tp on 14-7-28.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

//http://www.cocoachina.com/bbs/read.php?tid=210482

import UIKit

var _socket : SRWebSocket?

class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate,SRWebSocketDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    var until : Until = Until()
    
    
    //发送的消息
    var textJSON : NSString = NSString()
   
    //排布聊天框左右的bool
    
    
    
    @IBOutlet var chatTable: UITableView?
    
    @IBAction func chatwithvoice(sender: UIButton) {
    
        
    }
    
    
    
    @IBOutlet var pressSpeak: UIButton?
    
    
    @IBAction func pressToSpeak(sender: UIButton) {
    
    
    
    }
    
    
    @IBOutlet var chatwithword: UITextField?
    
       
    
    /**返回前一个页面*/
    @IBAction func back(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //装聊天内容（jSON）的数组
    var sumChat : NSMutableArray = NSMutableArray()
    //装单个聊天内容的字典
    var oneChat : NSDictionary = NSDictionary()
    
    /**websocket需要实现的4个方法*/
    func webSocket(webSocket : SRWebSocket!, didReceiveMessage message : AnyObject) {
        //txtMsgs.text = txtMsgs.text + (message as String) + "\n"
       
       
       
        
        var messageData : NSData = NSData(data: (message as NSString).dataUsingEncoding(NSUTF8StringEncoding))
        
            println(messageData)
            
        oneChat = NSJSONSerialization.JSONObjectWithData(messageData, options: NSJSONReadingOptions.MutableLeaves, error: nil) as NSDictionary
        
        
        
//        //当为推送消息的时候，不显示，直接跳转界面
//        if oneChat.objectForKey("action") as Int == 0 {
//            
//            //跳转入聊天页面
//            var toChatVC : ChatViewController = ChatViewController()
//            self.presentViewController(toChatVC, animated: true, completion: nil)
//        }
        
        
        
        //当消息是文字的时候
        if oneChat.objectForKey("msgType") as Int == 0 {
        
            sumChat.addObject(oneChat.objectForKey("msg"))
        }
        
       
        
        chatTable!.reloadData()
        
        //保证tableview滚动至当前对话行
        if sumChat.count > 1 {
            
            chatTable!.scrollToRowAtIndexPath(NSIndexPath(forRow: sumChat.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            
        }
        
    }
    
    func webSocket(webSocket : SRWebSocket!, webSocketDidOpen socket : SRWebSocket) {
        //txtMsgs.text = txtMsgs.text + "连接成功\n"
        println("连接成功")
    }
    
    func webSocket(webSocket : SRWebSocket!, didFailWithError error : NSError) {
        //txtMsgs.text = txtMsgs.text + "错误:" + error.description + "\n"
        println("连接失败")
    }
    
    func webSocket(webSocket : SRWebSocket!, didCloseWithCode
        code : Int, reason: NSString, wasClean:Bool) {
            //txtMsgs.text = txtMsgs.text + "关闭成功\n"
            println("关闭成功")
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("keyBoardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
       
        
        
        //设置textField输入起始位置
        chatwithword!.leftView = UIView(frame: CGRectMake(0, 0, 5, 0))
        chatwithword!.leftViewMode = UITextFieldViewMode.Always
        chatwithword!.delegate = self
        
        
    }
    
    
    // 键盘处理
    // 键盘即将显示
    func keyBoardWillShow(note : NSNotification){
    
//        var rect : CGRect = (note.userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
//        var ty : CGFloat = -rect.size.height
//        UIView.animateWithDuration(note.userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue, animations:{
//            self.view.transform = CGAffineTransformMakeTranslation(0, ty)
//            })
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
    

//     TODO 真实数据要判断消息是否来自其他人
//            if a > 4 {
//            
//                var tom : NSDictionary = NSDictionary(objectsAndKeys: textField.text,"content",
//                "others","name",
//                "NoRecord","recordFile")
//                sumChat.addObject(tom)
//            }
//            else{
//            
//                var jackey : NSDictionary = NSDictionary(objectsAndKeys: textField.text,"content",
//                    "self","name",
//                    "NoRecord","recordFile")
//                sumChat.addObject(jackey)
//            }
            
        if (_socket != nil) {
            
            if chatwithword!.text == "" {
                
                //                var alert = UIAlertView()
                //                alert.title = "warning"
                //                alert.message = "please input your message"
                //                alert.addButtonWithTitle("OK")
                //                alert.show()
            }
            else{
                
                //oneChat = NSDictionary(object: chatwithword!.text, forKey: "body")
               // sumChat.addObject(oneChat)

                
                
                
                 textJSON =  "{\"action\":0,\"user\":15800929404,\"userType\":1,\"room\":\"testRoom\",\"roomType\":0,\"msg\":\"\(chatwithword!.text)\",\"msgType\":0}"
                
                
                _socket?.send(textJSON)
                
                sumChat.addObject(chatwithword!.text)
                
                //println(sumChat)

                
                chatwithword!.text = nil
                
            }

        }
        
        
        chatTable!.reloadData()

        //保证tableview滚动至当前对话行
        if sumChat.count > 1 {
        
            chatTable!.scrollToRowAtIndexPath(NSIndexPath(forRow: sumChat.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            
        }
        
        textField.text = nil
        
        return true
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** UITableViewDataSource Methods*/
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        
        return  sumChat.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        
        chatTable!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        var cell : UITableViewCell  = chatTable!.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        
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
        label.numberOfLines = 0
        //label.adjustsFontSizeToFitWidth = true
        
        
        label.text = sumChat.objectAtIndex(indexPath.row) as NSString
        
        //println(label.text)
        
        //计算文字内容的宽度和高度
        until.selfAdaptionSize(label.text)
        
        
        

        //TODO,正式数据要判断消息来源是否为其他人，设置头像文字气泡等
//        if rightChat {
//        
//            
//            
//            imageViewHead.image = UIImage(named: "2.png")
//            imageViewHead.frame = CGRectMake(320 - 60 - 10, 10, 60, 60)
//            imageView.image = UIImage(named: "chatto_bg_normal.png")
//            label.frame = CGRectMake(20, 0, until.selfAdaptionSize(label.text).width, cell.frame.size.height)
//            label.textAlignment = NSTextAlignment.Right
//            
//            imageView.frame = CGRectMake(320-imageViewHead.frame.size.width-until.selfAdaptionSize(label.text).width-60,10, until.selfAdaptionSize(label.text).width+50, cell.frame.size.height)
//
//        }
//        
//        if leftChat {
//        
//            imageViewHead.image = UIImage(named: "1.png")
//            imageViewHead.frame = CGRectMake(10, 10, 60, 60)
//            
//            imageView.image = UIImage(named: "chatfrom_bg_normal.png")
//            label.frame = CGRectMake(30, 0, until.selfAdaptionSize(label.text).width, cell.frame.size.height)
//            label.textAlignment = NSTextAlignment.Left
//            
//            imageView.frame = CGRectMake(70, 10, until.selfAdaptionSize(label.text).width+50, cell.frame.size.height)
//        }
        
        
        
        imageViewHead.image = UIImage(named: "1.png")
                    imageViewHead.frame = CGRectMake(10, 10, 60, 60)
        
                    imageView.image = UIImage(named: "chatfrom_bg_normal.png")
                    label.frame = CGRectMake(30, 0, until.selfAdaptionSize(label.text).width, cell.frame.size.height)
                    label.textAlignment = NSTextAlignment.Left
        
                    imageView.frame = CGRectMake(70, 10, until.selfAdaptionSize(label.text).width+50, cell.frame.size.height)
        
       
        
        
        
        var top : CGFloat = 50       // 顶端盖高度
        var bottom : CGFloat = 50     // 底端盖高度
        var left : CGFloat = 50      // 左端盖宽度
        var right : CGFloat = 50     // 右端盖宽度
        
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
        
        // TODO 调整聊天文本框界面
        var string : NSString = sumChat.objectAtIndex(indexPath.row) as NSString
        var chatTextFont : NSDictionary = [NSFontAttributeName : UIFont.systemFontOfSize(14)]
        
        
        until.selfAdaptionSize(string)
        println(until.selfAdaptionSize(string).height)
        
        return until.selfAdaptionSize(string).height + 70
    }
    
    

    
//    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat{
//    
//        return (_allMessagesFrame![indexPath.row] as MessageFrame).cellHeight
//    }
    
    
    
    
    
    
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
