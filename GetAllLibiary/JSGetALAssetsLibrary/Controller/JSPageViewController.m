//
//  JSPageViewController.m
//  GetAllLibiary
//
//  Created by json on 14/10/19.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.

#import "JSPageViewController.h"
#import "JSPhotoViewController.h"
@interface JSPageViewController ()

@end

@implementation JSPageViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self SetUpView];
    // start by viewing the photo tapped by the user
    JSPhotoViewController *startingPage = [JSPhotoViewController photoViewControllerForPageIndex:self.startingIndex];
    if (startingPage != nil)
    {
        self.dataSource = self;
        
        [self setViewControllers:@[startingPage]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:YES
                      completion:NULL];
    }
    //设置背景
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
-(void)SetUpView
{
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"Back_Setting.png"] forState:UIControlStateNormal];
    [leftbtn setBackgroundImage:[UIImage imageNamed: @"Back_Setting.png"] forState:UIControlStateHighlighted];
    [leftbtn addTarget:self action:@selector(BackToPhotoList) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setFrame:CGRectMake(0, 0, 28.0f, 28.0f)];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    [self.navigationItem setLeftBarButtonItem:left];
}
#pragma mark--代理方法
- (UIViewController *)pageViewController:(UIPageViewController *)PageViewController viewControllerBeforeViewController:(JSPhotoViewController *)PhotoViewController
{
    NSUInteger index = PhotoViewController.pageIndex;
    return [JSPhotoViewController photoViewControllerForPageIndex:(index - 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)PageViewController viewControllerAfterViewController:(JSPhotoViewController *)PhotoViewController
{
    NSUInteger index = PhotoViewController.pageIndex;
    return [JSPhotoViewController photoViewControllerForPageIndex:(index + 1)];
}
-(void)BackToPhotoList
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
