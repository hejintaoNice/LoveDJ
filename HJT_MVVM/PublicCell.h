//
//  PublicCell.h
//  HJT_MVVM
//
//  Created by Heige on 16/6/21.
//  Copyright © 2016年 Heige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBDataUser.h"

@interface PublicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *weiboText;


-(void)setModelWithData:(WBDataUser*)publicModel;
@end
