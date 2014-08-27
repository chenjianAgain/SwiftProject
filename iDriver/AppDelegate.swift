                      //
//  AppDelegate.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/9.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit
                      
var alertViewString : String?
let NONETALERT : String = "noNet"
let CALLSERVICEALERT : String = "callService"
let BLACKLISTALERT : String = "blackList"


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    /**定义全局常量:欢迎界面持续的时间*/
    let SPLASH_SCREEN_WAIT_TIME  = 3.0
    /**定义全局常量:欢迎界面使用的图片*/
    let SPLASH_SCREEN_PIC = "welcome.png"
    /**定义全局常量:自定义的tabBarController控制器*/
    var tabBarVC:CustomTabBarViewController?
    /**定义全局常量:实时会话视图控制器*/
    var timelyConversationNavigation : UINavigationController?
    /**定义全局常量:附近司机视图控制器*/
    var nearDriverNavigation : UINavigationController?
    /**定义全局常量:一键下单控制器*/
    var clickOrderNavigation : UINavigationController?
    /**屏幕的宽*/
    let SCREENWIDTH : CGFloat = UIScreen.mainScreen().bounds.size.width
    /**屏幕的高*/
    let SCREENHEIGHT : CGFloat = UIScreen.mainScreen().bounds.size.height
    var welcomeTimmer : NSTimer?
    

   
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        if NSFileManager.defaultManager().fileExistsAtPath(LoginPath.getLoginPath()){
            var loginDic : NSMutableDictionary = NSMutableDictionary(contentsOfFile: LoginPath.getLoginPath())
            println(loginDic)
            tokenNo = loginDic["tokenNo"] as? String
            telephone = loginDic["telephone"] as? String
            println(tokenNo!)
            println(telephone!)
            
        }
        /*使用自定义的封装方法来拿取相应的故事版和视图的方法*/
        self.tabBarVC = PackViewControllerUtil.ViewControllerUtil( storyName: "CustomTabBarController", viewControllerName: "customTabBarVC") as? CustomTabBarViewController
        /**出现几秒的欢迎界面*/
        let images = UIImage(named :SPLASH_SCREEN_PIC)
        let imageView = UIImageView(frame:CGRect(x:0,y:0,width:SCREENWIDTH,
            height:SCREENHEIGHT))
        imageView.image = images
        imageView.tag = 10
        self.tabBarVC!.view.addSubview(imageView)
        /*欢迎界面几秒后移除*/
        welcomeTimmer =  NSTimer.scheduledTimerWithTimeInterval(SPLASH_SCREEN_WAIT_TIME, target:self, selector:"removePIC", userInfo:nil, repeats:false)
       
        self.timelyConversationNavigation = PackViewControllerUtil.ViewControllerUtil(storyName: "TimelyConversation", viewControllerName: "timelyConversationNav") as? UINavigationController
        self.nearDriverNavigation = PackViewControllerUtil.ViewControllerUtil(storyName: "NearDriver", viewControllerName: "nearDriverNav") as? UINavigationController
        self.clickOrderNavigation = PackViewControllerUtil.ViewControllerUtil(storyName: "ClickOrder", viewControllerName: "clickOrderNav") as? UINavigationController
        self.tabBarVC!.viewControllers = [self.nearDriverNavigation!,self.timelyConversationNavigation!,self.clickOrderNavigation!]
        self.tabBarVC!.selectedViewController = nearDriverNavigation
        self.window!.makeKeyAndVisible()
        self.window!.rootViewController = tabBarVC
        return true
    }

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    /**移除的方法*/
    func removePIC()
    {
        let imageView:UIImageView = self.tabBarVC!.view.viewWithTag(10) as UIImageView
        if CheckNetWork.NetWorkIsOk(){
            imageView.removeFromSuperview()
            welcomeTimmer!.invalidate()
        }
        else{
            alertViewString = NONETALERT
            var arr : NSArray = NSBundle.mainBundle().loadNibNamed("AlertView", owner: self, options: nil)
            var alertView : AlertView = arr.objectAtIndex(0) as AlertView
            alertView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.8)
            UIApplication.sharedApplication().keyWindow!.rootViewController.view.addSubview(alertView)
        }
        
    }

    
   

}

