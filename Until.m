//
//  Until.m
//  iDriver
//
//  Created by tp on 14-8-8.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

#import "Until.h"



@implementation Until

    static int count=0;




-(CGSize)selfAdaptionSize :(NSString *)string{
    
    NSDictionary *a = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(200, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:a context:nil].size;
    
    _size = size;
    return _size;
}



-(CGFloat)heightForAlbum :(NSInteger)photoNumbers
{
    CGFloat height;
    
    if (photoNumbers % 4 == 0) {
        
        height = photoNumbers / 4 * 60 + (photoNumbers / 4) * 7;
    }
    else{
    
        height = (photoNumbers / 4 + 1) * 60 + (photoNumbers / 4 + 1) * 7;
    }
    
    return height;
}



-(void)getAllAlbum{

    
    
    imageArray=[[NSArray alloc] init];
    
    mutableArray =[[NSMutableArray alloc]init];
    
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    
    
    
    library = [[ALAssetsLibrary alloc] init];
    
    
    
    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if(result != nil) {
            
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                
                
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                
                
            //若用户确认可以访问相册，余下操作在resultBlock里，否则调用failureBlock
                
                [library assetForURL:url
                 
                         resultBlock:^(ALAsset *asset) {
                             
                             [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation]fullResolutionImage]]];
                             
                             
                             
                             if ([mutableArray count]==count)
                                 
                             {
                                 
                                 imageArray=[[NSArray alloc] initWithArray:mutableArray];
                                 
                                 [self allPhotosCollected:imageArray];
                                 
                             }
                             
                         }
                 
                        failureBlock:^(NSError *error){
                            
                            NSLog(@"operation was not successfull!");
                        
                        } ];
                
                
                
            }
            
        }
        
    };
    
    
    
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    
    
    
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        
        if(group != nil) {
            
            [group enumerateAssetsUsingBlock:assetEnumerator];
            
            [assetGroups addObject:group];
            
            count=[group numberOfAssets];
            
        }
        
    };
    
    
    
    //assetGroups = [[NSMutableArray alloc] init];
    
    
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
     
                           usingBlock:assetGroupEnumerator
     
                         failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
   
}





-(void)allPhotosCollected:(NSArray*)imgArray

{
    
    photoArr = imgArray;
    
    _photoNumbers = photoArr.count;
    //write your code here after getting all the photos from library...
    
    NSLog(@"all pictures are %@",photoArr);
    
}


-(NSArray *)photoArrMethod{

    [self getAllAlbum];
    
    
    return photoArr;
}





@end
