//
//  ViewController.m
//  HJT_MVVM
//
//  Created by Heige on 16/6/21.
//  Copyright © 2016年 Heige. All rights reserved.
//

#import "PublicTableViewController.h"
#import "FaceToDataViewModel.h"
#import "PublicCell.h"
#import "HJTClearCacheTool.h"
#import "CustomTool.h"
#import <MJRefresh.h>

#import "FaceToDataViewModel.h"

@interface PublicTableViewController (){
    FaceToDataViewModel*tableViewModel;
}
@property (strong, nonatomic) NSMutableArray *publicModelArray;
@property (nonatomic,strong)UIBarButtonItem *rightButtonItem;
@end

@implementation PublicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavBar];
    _publicModelArray = [NSMutableArray array];
    tableViewModel=[[FaceToDataViewModel alloc] init];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoredata)];
    
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)loadNewData{
    [tableViewModel RefreshRequestWithCallback:^(NSArray *array) {
        _publicModelArray  =  [array mutableCopy];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
        
    } isHead:YES];
}

-(void)loadMoredata{
    [tableViewModel RefreshRequestWithCallback:^(NSArray *array) {
         _publicModelArray  =  [array mutableCopy];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } isHead:NO];
}

-(void)configureNavBar{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(0, 0, 20, 20);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"Clear"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(ClearMemory) forControlEvents:UIControlEventTouchDown];
    
    self.rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = self.rightButtonItem;
}

-(void)ClearMemory{
    NSString *fileSize = [HJTClearCacheTool getCacheSizeWithFilePath:filePath];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"缓存大小%@确定清除么?",fileSize] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //创建一个取消和一个确定按钮
    UIAlertAction *actionCancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //因为需要点击确定按钮后改变文字的值，所以需要在确定按钮这个block里面进行相应的操作
    UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //清楚缓存
        BOOL isSuccess = [HJTClearCacheTool clearCacheWithFilePath:filePath];
        if (isSuccess) {
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    }];
    //将取消和确定按钮添加进弹框控制器
    [alert addAction:actionCancle];
    [alert addAction:actionOk];
    //显示弹框控制器
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _publicModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PublicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublicCell" forIndexPath:indexPath];
    
    [cell setModelWithData:_publicModelArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FaceToDataViewModel *publicViewModel = [[FaceToDataViewModel alloc] init];
    [publicViewModel weiboDetailWithPublicModel:_publicModelArray[indexPath.row] WithViewController:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
