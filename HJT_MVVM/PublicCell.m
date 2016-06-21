//
//  PublicCell.m
//  HJT_MVVM
//
//  Created by Heige on 16/6/21.
//  Copyright © 2016年 Heige. All rights reserved.
//

#import "PublicCell.h"

@implementation PublicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImageView.layer.cornerRadius = _headImageView.layer.frame.size.height/2;
    _headImageView.clipsToBounds = YES;
   
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _headImageView.clipsToBounds = YES;
}


-(void)setModelWithData:(WBDataUser *)publicModel
{
    _userName.text = publicModel.screenName;
    _date.text = publicModel.location;
    _weiboText.text = publicModel.userDescription;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",publicModel.profileImageUrl]]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
