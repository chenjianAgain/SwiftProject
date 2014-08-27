//
//  Until.h
//  iDriver
//
//  Created by tp on 14-8-8.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface Until : NSObject
{
    
    ALAssetsLibrary *library;
    
    NSArray *imageArray;
    
    NSMutableArray *mutableArray;
 
    NSArray * photoArr;
    
    
}


-(CGSize)selfAdaptionSize :(NSString *)string;

@property (nonatomic) CGSize size;

@property (nonatomic) NSInteger photoNumbers;


-(CGFloat)heightForAlbum :(NSInteger)photoNumbers;


-(void)getAllAlbum;

-(void)allPhotosCollected:(NSArray *)imgArray;

-(NSArray *)photoArrMethod;



@end
