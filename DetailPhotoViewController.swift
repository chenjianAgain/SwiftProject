//
//  DetailPhotoViewController.swift
//  iDriver
//
//  Created by tp on 14-8-20.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit


var detailImg : UIImage = UIImage()

class DetailPhotoViewController: UIViewController {

    
    
    @IBAction func sendPhoto(sender: UIButton) {
    }
    
    
    
    @IBAction func reselectPhoto(sender: UIButton) {
    
    
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBOutlet weak var detailPhoto: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailPhoto.image = detailImg
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
