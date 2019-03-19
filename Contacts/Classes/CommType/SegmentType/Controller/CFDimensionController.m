//
//  CFDimensionController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFDimensionController.h"

@interface CFDimensionController ()

@property (nonatomic ,assign) NSInteger page;
@end

@implementation CFDimensionController

#pragma mark - 仅仅是为了消除编译器发出的警告 : type方法没有实现
- (CFDimensionType)type {
    return 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(CFNavigationBarH + 40, 0, iPhoneX_BOTTOM_HEIGHT, 0);
    
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [CFRefreshHeader headerWithRefreshingBlock:^{
        [self loadDimensionList];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [CFRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreDimensionList];
    }];
}

- (void)loadDimensionList
{
    self.page = 1;
    
    CFAccount *acount = [CFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = ([self.user_id length] > 0) ? self.user_id : acount.USER_ID;
    params[@"pageSize"] = @(10);
    params[@"pageNo"] = @(self.page);
    params[@"statu"] = @"0";
    params[@"grade"] = @(self.type);
    
    CFLog(@"%@", params);
    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:Contacts_Interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        [weakSelf.tableView.mj_header endRefreshing];
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            weakSelf.comm = [CFComm mj_objectArrayWithKeyValuesArray:responseObject[@"PageData"]];
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [TFProgressHUD dismiss];
    }];
}

- (void)loadMoreDimensionList
{
    self.page ++;
    
    CFAccount *acount = [CFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = ([self.user_id length] > 0) ? self.user_id : acount.USER_ID;
    params[@"pageSize"] = @(10);
    params[@"pageNo"] = @(self.page);
    params[@"statu"] = @"0";
    params[@"grade"] = @(self.type);
    
    CFLog(@"%@", params);
    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:Contacts_Interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        [weakSelf.tableView.mj_header endRefreshing];
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            NSArray<CFComm *> *moredcomm = [CFComm mj_objectArrayWithKeyValuesArray:responseObject[@"PageData"]];
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.comm addObjectsFromArray:moredcomm];
        }
    } failure:^(NSError * _Nonnull error) {
        [TFProgressHUD dismiss];
    }];
}
@end
