//
//  JSGetALAssetsLibraryManager.m
//  GetAllLibiary
//
//  Created by Json on 14-10-18.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import "JSGetALAssetsLibraryManager.h"

@interface JSGetALAssetsLibraryManager()
{
    ALAssetsLibraryAccessFailureBlock _failureBlock ;//授权检测
    ALAssetsLibraryGroupsEnumerationResultsBlock _listGroupBlock;
    ALAssetsLibrary *_assetsLibrary;//定义资源库;
    NSMutableArray *_photoGroups;//相片组;
  
}
@end
@implementation JSGetALAssetsLibraryManager
static  JSGetALAssetsLibraryManager*_instance;
#pragma mark----创建单例
+(id)ShareGetALAssetsLibraryManager
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


-(void)InitTheAssetsLibrary
{
    if (_assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }

}
#pragma mark----检查用户授权
-(void)CheckUserAccess
{
    __weak JSGetALAssetsLibraryManager*showself=self;
    
   _failureBlock = ^(NSError *error) {

        
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"请为应用开放照片访问权限\n(设置-隐私-照片-CameraMini)";
                break;
            default:
                errorMessage = @"未知错误，请刷新重试";
                break;
        }
        [showself ShowAlert:errorMessage];
        };
}
#pragma mark----获取相册数组
-(void)GetPhotoGroupFromALAssetsLibraryWithSuccessBlock:(GetALAssetsLibrarySuccess)success
{
    if (_photoGroups == nil) {
        _photoGroups = [[NSMutableArray alloc] init];
    } else {
        [_photoGroups removeAllObjects];
    }
    __weak NSMutableArray *photogroups=_photoGroups;
  _listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
    

        ALAssetsFilter *thePhotosFilter = [ALAssetsFilter allPhotos];
        //组添加ALAssetsFilter过滤器
        [group setAssetsFilter:thePhotosFilter];
        if ([group numberOfAssets] > 0)
        {
            [photogroups addObject:group];
          
        }else
        {
            success(photogroups);
        }
      
    };
    
    // enumerate only photos
    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    [_assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:_listGroupBlock failureBlock:_failureBlock];
}
#pragma mark-- 从指定组中获取照片
-(void)GetPhotosFromALAssetsGroup:(ALAssetsGroup *)group WithSuccessBlock:(GetALAssetsPhotosSuccess)success
{
    NSMutableArray *assets=[NSMutableArray array];
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [assets addObject:result];
        }else{
            success(assets);
        }
    };
    //当前照片组
    ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
    [group setAssetsFilter:onlyPhotosFilter];
    [group enumerateAssetsUsingBlock:assetsEnumerationBlock];
 
}

-(void)ShowAlert:(NSString*)msg
{
    
    UIAlertView *alert;
    if (alert==nil) {
      alert=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];

    }
    [alert setTitle:@"抱歉"];
    [alert setMessage:msg];
    [alert show];
 }
@end
