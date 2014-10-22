//
//  JSPhotoListController.m
//  GetAllLibiary
//
//  Created by json on 14/10/19.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import "JSPhotoListController.h"
#import "JSGetALAssetsLibraryManager.h"
#import "JSPhotoTool.h"
#import "JSPageViewController.h"
#define PhotoCellSize CGSizeMake(77.0f, 77.0f)

@interface JSPhotoListController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *_assets;
}

@end

@implementation JSPhotoListController

static NSString *CellIdentifier = @"photoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUpView];
}
-(void)viewWillAppear:(BOOL)animated
{
    if (!_assets) {
        _assets = [[NSMutableArray alloc] init];
    } else {
        [_assets removeAllObjects];
    }
    //[self GetPhotosFromALAssetsGroup];
    [[JSGetALAssetsLibraryManager ShareGetALAssetsLibraryManager] GetPhotosFromALAssetsGroup:_assetsGroup WithSuccessBlock:^(NSMutableArray *photos) {
        _assets=photos;
    }];
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self.PhotoList reloadData];
    
}
#pragma mark--初始化视图
- (void)SetUpView
{
    self.title=[self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    //设置返回按钮
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"Back_Setting.png"] forState:UIControlStateNormal];
    [leftbtn setBackgroundImage:[UIImage imageNamed: @"Back_Setting.png"] forState:UIControlStateHighlighted];
    [leftbtn addTarget:self action:@selector(BackToPhotoGroup) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setFrame:CGRectMake(0, 0, 28.0f, 28.0f)];
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem=backitem;
    //添加collection视图
    [self.view addSubview:_PhotoList];
    [_PhotoList setDelegate:self];
    [_PhotoList setDataSource:self];
    //register cell
    [_PhotoList registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    //设置Collectionflowlayout布局
    UICollectionViewFlowLayout *photolayout =[[UICollectionViewFlowLayout alloc]init];
    [photolayout setMinimumLineSpacing:4.0f];
    [photolayout setMinimumInteritemSpacing:4.0f];
    [photolayout setItemSize:PhotoCellSize];
    [photolayout setSectionInset:UIEdgeInsetsMake(5.0f, 0, 1.0f, 0)];
    [_PhotoList setCollectionViewLayout:photolayout];

}

#pragma mark ---UICollectionView代理方法

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return _assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    ALAsset *asset = _assets[indexPath.row];
    CGImageRef imageRef = [asset thumbnail];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithCGImage:imageRef]];
    [cell setBackgroundView:imageView];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"length------%d",indexPath.row);
    [JSPhotoTool sharedInstance].photoAssets = _assets;
    JSPageViewController *pagevc;
    if (!pagevc) {
        //设置分页style并设置分页间距为2.0f
        pagevc=[[JSPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{
                                                                                                                                                                                                  UIPageViewControllerOptionInterPageSpacingKey:@(2.0f)                                                                                                                                                                                }];
    }
    pagevc.startingIndex = indexPath.row;
    [self.navigationController pushViewController:pagevc animated:YES];
}
#pragma mark--返回照片组
-(void)BackToPhotoGroup
{

    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
@end
