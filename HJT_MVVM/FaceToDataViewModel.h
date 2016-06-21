//
//  PublicWeiboViewModel.h
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/8.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "ViewModelClass.h"
#import "WBDataUser.h"

typedef void (^callback) (NSArray *array);
@interface FaceToDataViewModel : ViewModelClass

//跳转到微博详情页
-(void) weiboDetailWithPublicModel: (WBDataUser *) publicModel WithViewController: (UIViewController *)superController;

//tableView刷新的网络请求
-(void)RefreshRequestWithCallback:(callback)callback isHead:(BOOL)result;
@end
