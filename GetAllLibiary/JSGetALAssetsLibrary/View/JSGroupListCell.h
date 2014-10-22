//
//  JSGroupListCell.h
//  GetAllLibiary
//
//  Created by Json on 14-10-18.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSGroupListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PosterImageView;//组封面图
@property (weak, nonatomic) IBOutlet UILabel *GroupName;//照片组名称
@property (weak, nonatomic) IBOutlet UILabel *GroupPhotoNumber;//当前组内照片数
@property (strong, nonatomic) IBOutlet UIView *contentview;

@end
