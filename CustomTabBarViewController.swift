//
//  CustomTabBarViewController.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/10.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

/**
自定义的tabBarController
*/


/**自定义tabBar所在的view*/
var tabBarView : UIView?

class CustomTabBarViewController: UITabBarController {
    
    
    /**纪录tabBar前一个按钮*/
    var previousBtn : CustomTabBarButton?
    /**屏幕的宽*/
    let SCREENWIDTH : CGFloat = UIScreen.mainScreen().bounds.size.width
    /**屏幕的高*/
    let SCREENHEIGHT : CGFloat = UIScreen.mainScreen().bounds.size.height
     /**tabBar的纵坐标*/
    let TABBARVIEWY : CGFloat = UIScreen.mainScreen().bounds.size.height - 49.0
     /**按钮个数*/
    let BUTTONCOUNT = 3
    /*创建自定义按钮和普通按钮*/
    var button : UIButton?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        self.view.autoresizesSubviews = true
        
        self.tabBar.hidden = true
        /*自定义tabBarController中的tabBar视图*/
        tabBarView = UIView(frame: CGRect(x:0,y:TABBARVIEWY,width:SCREENWIDTH,height:49))
        tabBarView!.userInteractionEnabled = true
        tabBarView!.backgroundColor = UIColor.whiteColor()
        tabBarView!.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(tabBarView!)
        
        /*调用自定义按钮的方法，用来创建按钮，以便视图之间的切换*/
       
        createButton("tabbar_nearbydriver", selectedimageName: "tabbar_nearbydriver_seleted", titleName: "附近司机", indexBtn: 0)
        createButton("communicate_btn", selectedimageName: "timeNormal", titleName: "", indexBtn: 1)
        createButton("tabbar_order", selectedimageName: "tabbar_order_seleted", titleName: "一键下单", indexBtn: 2)
        
        /*设置默认选中的按钮和视图*/
        var button : CustomTabBarButton = tabBarView!.subviews[0] as CustomTabBarButton
        previousBtn = button
        SwitchViewController(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    /*创建自定义按钮的方法*/
    func createButton(NormalName: String!,selectedimageName: String!,titleName: String!,indexBtn:Int){
        if indexBtn == 1{
             button  = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
            
            button!.addTarget(self, action: Selector("goToTimely"), forControlEvents: UIControlEvents.TouchUpInside)
        }
        else{
            button  = CustomTabBarButton.buttonWithType(UIButtonType.Custom) as CustomTabBarButton
            
            button!.addTarget(self, action: "SwitchViewController:", forControlEvents: UIControlEvents.TouchDown)
        }
        button!.tag = indexBtn
        var buttonWidth = tabBarView!.frame.size.width / CGFloat(BUTTONCOUNT)
        var buttonHeight = tabBarView!.frame.size.height
        if indexBtn == 1{
             button!.frame = CGRectMake(buttonWidth * CGFloat(indexBtn),0,buttonWidth, tabBarView!.frame.size.height)
        }
        else{
             button!.frame = CGRectMake(buttonWidth * CGFloat(indexBtn),0,buttonWidth, buttonHeight)
        }
        button!.titleLabel.font = UIFont.systemFontOfSize(15.0)
        button!.setImage(UIImage(named: NormalName), forState: UIControlState.Normal)
        button!.setImage(UIImage(named: selectedimageName), forState: UIControlState.Disabled)
        if indexBtn == 1{
            button!.setTitle("", forState: UIControlState.Normal)
        }
        else{
            button!.setTitle(titleName, forState: UIControlState.Normal)
        }
        
        button!.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        /**使得button的图片按比例使用*/
        button!.contentMode = UIViewContentMode.ScaleAspectFit
        /**三个按钮：居左、中间、居右*/
        if indexBtn == 0{
            button!.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleWidth

        }
        else if indexBtn == 1{
            button!.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        }

        else {
            button!.autoresizingMask =  UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleWidth

        }
        
        
        button!.imageView.contentMode = UIViewContentMode.Center
        button!.titleLabel.textAlignment = NSTextAlignment.Center
        tabBarView!.addSubview(button!)
        
   }
    /*点击按钮的触发方法，用于切换界面*/
    func SwitchViewController(sender: CustomTabBarButton){
        sender.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        if sender.tag == 1{
            
        }
        self.selectedIndex = sender.tag
        sender.enabled = false
        if previousBtn != sender{
            previousBtn!.enabled = true
            previousBtn!.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }
        previousBtn = sender
    }
    
    
    func goToTimely() {
        
        var timelyVC : TimelyConversationViewController = PackViewControllerUtil.ViewControllerUtil(storyName: "TimelyConversation", viewControllerName: "timelyConversationVC") as TimelyConversationViewController
        self.presentViewController(timelyVC, animated: true, completion: nil)
    }


  
}
