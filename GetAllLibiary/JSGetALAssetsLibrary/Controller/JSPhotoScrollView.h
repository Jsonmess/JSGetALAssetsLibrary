//
//  JSPhotoScrollView.h
//  GetAllLibiary
//
//  Created by json on 14/10/19.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface JSPhotoScrollView : UIScrollView

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic) NSUInteger index;

+ (NSUInteger)imageCount;
@end
