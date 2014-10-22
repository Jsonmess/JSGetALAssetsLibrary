//
//  JSALAssetsListController.m
//  GetAllLibiary
//
//  Created by Json on 14-10-18.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import "JSALAssetsListController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "JSGroupListCell.h"
#import "JSGetALAssetsLibraryManager.h"
#import "JSPhotoListController.h"
@interface JSALAssetsListController ()<UITableViewDataSource,UITableViewDelegate>
{
    JSGetALAssetsLibraryManager *_manager;
    NSArray *_photoGroups;
}
@end

@implementation JSALAssetsListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self SetUpView];
    
}
#pragma mark ------ 初始化当前controller
-(void)SetUpView
{
    [self setTitle:@"系统相册"];
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed: @"refresh_pressed.png"] forState:UIControlStateNormal];
    [leftbtn setBackgroundImage:[UIImage imageNamed: @"refresh_pressed.png"] forState:UIControlStateHighlighted];
    [leftbtn addTarget:self action:@selector(RefreshPressed) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setFrame:CGRectMake(0, 0, 32.0f, 32.0f)];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    [self.navigationItem setLeftBarButtonItem:left];
    //添加表格
    [self.GroupListView setDelegate:self];
    [self.GroupListView setDataSource:self];
    [self.view addSubview:self.GroupListView];
    //初始化管理器
    _manager =[JSGetALAssetsLibraryManager ShareGetALAssetsLibraryManager];
    [_manager InitTheAssetsLibrary];
    [_manager CheckUserAccess];
    [_manager GetPhotoGroupFromALAssetsLibraryWithSuccessBlock:^(NSMutableArray *groups) {
        _photoGroups=groups;
        //主线程更新视图
        [_GroupListView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
     }];
    
}
//刷新列表
-(void)RefreshPressed
{
    
    [_manager InitTheAssetsLibrary];
    [_manager GetPhotoGroupFromALAssetsLibraryWithSuccessBlock:^(NSMutableArray *groups) {
        //主线程更新视图
       [_GroupListView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
}
#pragma mark ------ 表格代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _photoGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    JSGroupListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        cell=[[JSGroupListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    ALAssetsGroup*thegroup=_photoGroups[indexPath.row];
    
    CGImageRef posterImageRef = [thegroup posterImage];
    UIImage *posterImage = [UIImage imageWithCGImage:posterImageRef];
    [cell.PosterImageView setImage: posterImage];
    [cell.GroupName setText:[thegroup valueForProperty:ALAssetsGroupPropertyName]];
    [cell.GroupPhotoNumber setText:[@(thegroup.numberOfAssets) stringValue]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSPhotoListController *photoList;
    if (photoList==nil) {
        photoList=[[ JSPhotoListController alloc]init];
    }
    [photoList setAssetsGroup:_photoGroups[indexPath.row]];
    [self.navigationController pushViewController:photoList animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
