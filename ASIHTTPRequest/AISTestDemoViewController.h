//
//  AISTestDemoViewController.h
//  AISTestDemo
//
//  Created by 李晓川 on 11-8-11.
//  Copyright 2011 哈尔滨理工大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface AISTestDemoViewController : UIViewController {
	UIProgressView *pv;
	UIAlertView *alert;
}

@property (nonatomic,retain) UIProgressView *pv;
@property (nonatomic,retain) UIAlertView *alert;

@end

