//
//  JSPhotoListController.h
//  GetAllLibiary
//
//  Created by json on 14/10/19.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface JSPhotoListController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *PhotoList;
 @property (strong, nonatomic)  ALAssetsGroup *assetsGroup;
@end
