//
//  JSPhotoViewController.h
//  GetAllLibiary
//
//  Created by json on 14/10/19.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSPhotoViewController : UIViewController
@property (nonatomic, strong) NSArray *photos; //照片数组

@property NSUInteger pageIndex;

+ (JSPhotoViewController *)photoViewControllerForPageIndex:(NSUInteger)pageIndex;
@end
