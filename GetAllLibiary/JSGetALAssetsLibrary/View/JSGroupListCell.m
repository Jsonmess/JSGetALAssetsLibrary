//
//  JSGroupListCell.m
//  GetAllLibiary
//
//  Created by Json on 14-10-18.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import "JSGroupListCell.h"

@implementation JSGroupListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        [self SetUpCell];
    }
    return self;
}
-(void)SetUpCell
{
    [[NSBundle mainBundle]loadNibNamed:@"JSGroupListCell" owner:self options:nil];
    [self.contentView addSubview:self.contentview];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
