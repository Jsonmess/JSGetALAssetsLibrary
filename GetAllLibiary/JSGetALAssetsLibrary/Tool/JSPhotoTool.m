//
//  JSPhotoTool.m
//  GetAllLibiary
//
//  Created by json on 14/10/19.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import "JSPhotoTool.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation JSPhotoTool
#pragma mark--创建单例
static JSPhotoTool *_instance;
+ (JSPhotoTool *)sharedInstance
{
    if (_instance==nil) {
        _instance=[[self alloc]init];
    }
    return _instance;
}
+(id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[super allocWithZone:zone];
    });
    return _instance;
}

- (NSUInteger)PhotoCount
{
    return self.photoAssets.count;
}
#pragma mark---index获取指定图片
-(UIImage*)GetPhotoWithIndex:(NSUInteger)index
{
    ALAsset *photoAsset = self.photoAssets[index];
    
    ALAssetRepresentation *assetRepresentation = [photoAsset defaultRepresentation];

    UIImage *fullScreenImage=[UIImage imageWithCGImage:[assetRepresentation fullScreenImage] scale:[assetRepresentation scale] orientation:UIImageOrientationUp];
    return fullScreenImage;
}
@end
