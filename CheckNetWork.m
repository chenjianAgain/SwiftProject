//
//  checkNetWork.m
//  iDriver
//
//  Created by GaoLi on 14-8-19.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

#import "CheckNetWork.h"

@implementation CheckNetWork

+(BOOL)NetWorkIsOk
{
    
    BOOL isEnableWIFI = [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable;
    BOOL isEnable3G = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable;
    if (isEnable3G==YES || isEnableWIFI==YES) {
        return YES;
    }
    else{
        return NO;
    }
    
}

@end
