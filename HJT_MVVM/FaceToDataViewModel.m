//
//  PublicWeiboViewModel.m
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/8.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "FaceToDataViewModel.h"
#import "PublicDetailViewController.h"
#import "CustomTool.h"
#import "WBDataWBData.h"
#import "WBDataUser.h"
#import "WBDataStatuses.h"
#import <MJRefresh.h>



@interface FaceToDataViewModel()
@property (assign,nonatomic)NSInteger page;
@property (strong,nonatomic)WBDataWBData*model;
@end



@implementation FaceToDataViewModel


#pragma 对ErrorCode进行处理
-(void) errorCodeWithDic: (NSDictionary *) errorDic
{
    self.errorBlock(errorDic);
}

#pragma 对网路异常进行处理
-(void) netFailure
{
    self.failureBlock();
}


#pragma 跳转到详情页面，如需网路请求的，可在此方法中添加相应的网络请求
-(void) weiboDetailWithPublicModel:(WBDataUser *)publicModel WithViewController:(UIViewController *)superController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PublicDetailViewController *detailController = [storyboard instantiateViewControllerWithIdentifier:@"PublicDetailViewController"];
    detailController.publicModel = publicModel;
    [superController.navigationController pushViewController:detailController animated:YES];
    
}

-(void)RefreshRequestWithCallback:(callback)callback isHead:(BOOL)result{
    if (result) {
        _page = 1;
    }else{
        if (_page < 2) {
            _page = 2;
        }
    }
    [HJTNetTool get:[NSString stringWithFormat:@"%@?access_token=%@&count=100",GetData,ACCESSTOKEN] progress:^(NSProgress * _Nonnull progress) {
        
    } success:^(id  _Nonnull responseObject) {
        _model = [[WBDataWBData alloc]initWithDictionary:responseObject];
        if (_model.statuses) {
            NSMutableArray *dataArray=[NSMutableArray array];
            if (result) {
                [dataArray removeAllObjects];
            }else{
                _page ++;
            }
            
            for (WBDataStatuses* statues in _model.statuses) {
                [dataArray addObject:statues.user];
            }
           
            callback(dataArray);
        }
    } failure:^(NSString * _Nonnull errorLD) {
        SHOW_NTERROR
        
    }];
}






@end
