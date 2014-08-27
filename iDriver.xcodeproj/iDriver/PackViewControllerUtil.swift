//
//  PackStoryUtil.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/9.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

/**
封装方法：用来获取相应标识的故事版及视图控制器
*/
class PackViewControllerUtil: NSObject {
    
    class func ViewControllerUtil(storyName story: String!,viewControllerName: String!) -> AnyObject!{
        let story = UIStoryboard(name:story,bundle:NSBundle.mainBundle())
        let viewController : AnyObject! = story.instantiateViewControllerWithIdentifier(viewControllerName)
        return viewController
        
       
    }
      
   
}
