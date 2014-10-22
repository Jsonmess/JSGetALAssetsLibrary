//
//  JSPageViewController.h
//  GetAllLibiary
//
//  Created by json on 14/10/19.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSPageViewController : UIPageViewController <UIPageViewControllerDataSource>
@property(nonatomic,assign) NSInteger startingIndex;//记录起始点
@end
