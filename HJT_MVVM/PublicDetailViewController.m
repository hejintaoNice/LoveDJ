//
//  PublicDetailViewController.m
//  HJT_MVVM
//
//  Created by Heige on 16/6/21.
//  Copyright © 2016年 Heige. All rights reserved.
//

#import "PublicDetailViewController.h"
#import "UIViewController+changeNavBarItem.h"

@interface PublicDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation PublicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeNaviBar];
    [self configureUI];
}

-(void)configureUI{
    _userNameLabel.text = _publicModel.screenName;
    
    _textLabel.text = _publicModel.userDescription;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_publicModel.profileImageUrl]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
