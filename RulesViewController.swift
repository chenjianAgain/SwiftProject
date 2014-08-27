//
//  RulesViewController.swift
//  iDriver
//
//  Created by GaoLi on 14-8-11.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "条款"
        var backItem : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: "backGetCaptcha")
        self.navigationItem.leftBarButtonItem = backItem

    }
    
    func backGetCaptcha(){
        self.navigationController.popToRootViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

 
}
