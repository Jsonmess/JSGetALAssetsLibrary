//
//  JSViewController.m
//  GetAllLibiary
//
//  Created by Json on 14-10-18.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import "JSViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "JSALAssetsListController.h"
@interface JSViewController ()
{  NSMutableArray *_dataArray;
}
@end

@implementation JSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}
- (IBAction)OpenTableView:(id)sender {
    JSALAssetsListController *listcontroller=[[JSALAssetsListController alloc]init];
    UINavigationController *listNav=[[UINavigationController alloc]initWithRootViewController:listcontroller];
    [self presentViewController:listNav animated:YES completion:nil];
}

@end
