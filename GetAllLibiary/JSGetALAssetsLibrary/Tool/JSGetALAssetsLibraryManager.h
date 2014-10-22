//
//  JSGetALAssetsLibraryManager.h
//  GetAllLibiary
//
//  Created by Json on 14-10-18.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
typedef void(^GetALAssetsLibrarySuccess)(NSMutableArray *groups);
typedef void(^GetALAssetsPhotosSuccess)(NSMutableArray *photos);
@interface JSGetALAssetsLibraryManager : NSObject
-(void)InitTheAssetsLibrary;
-(void)CheckUserAccess;//检查权限
-(void)GetPhotoGroupFromALAssetsLibraryWithSuccessBlock:(GetALAssetsLibrarySuccess)success;//获取相册
-(void)GetPhotosFromALAssetsGroup:(ALAssetsGroup *)group WithSuccessBlock:(GetALAssetsPhotosSuccess)success;//获取指定相册照片
+(id)ShareGetALAssetsLibraryManager;
@end
