//
//  AISTestDemoAppDelegate.h
//  AISTestDemo
//
//  Created by 李晓川 on 11-8-11.
//  Copyright 2011 哈尔滨理工大学. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AISTestDemoViewController;

@interface AISTestDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AISTestDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AISTestDemoViewController *viewController;

@end

