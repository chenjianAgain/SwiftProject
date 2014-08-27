//
//  ChatViewController.swift
//  iDriver
//
//  Created by tp on 14-7-28.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit


class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var chatTable: UITableView
    
    @IBAction func chatwithvoice(sender: UIButton) {
    }
    
    
    
    @IBOutlet var pressSpeak: UIButton
    
    
    @IBAction func pressToSpeak(sender: UIButton) {
    }
    
    
    @IBOutlet var chatwithword: UITextField
    
    
    @IBAction func addPicture(sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chatTable.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /** UITableViewDataSource Methods*/
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = chatTable.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath) as UITableViewCell!
        return cell
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
