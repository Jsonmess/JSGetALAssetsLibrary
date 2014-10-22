//
//  JSPhotoTool.h
//  GetAllLibiary
//
//  Created by json on 14/10/19.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSPhotoTool : NSObject

@property (nonatomic, strong) NSArray *photoAssets; //图片数组

- (NSUInteger)PhotoCount;//图片数量
- (UIImage *)GetPhotoWithIndex:(NSUInteger)index;
+ (JSPhotoTool *)sharedInstance;
@end
