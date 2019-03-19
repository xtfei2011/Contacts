//
//  CFBusinessCardController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/8.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFBusinessCardController.h"
#import "CFBusinessCardCell.h"
#import "CFAddBusinessCardController.h"

@interface CFBusinessCardController ()<CFBusinessCardCellDelegate>
@property (nonatomic ,strong) NSMutableArray<CFBusinessCard *> *businessCard;
@end

@implementation CFBusinessCardController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupRefresh];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的名片";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_btn_add" highImage:@"nav_btn_add" target:self action:@selector(addButtonClick:)];
    
    [self setupTableView];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [CFRefreshHeader headerWithRefreshingBlock:^{
        [self loadBusinessCardList];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadBusinessCardList
{
    CFAccount *account = [CFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = account.USER_ID;
    
    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:Business_Interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        [weakSelf.tableView.mj_header endRefreshing];
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            weakSelf.businessCard = [CFBusinessCard mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {}];
}

- (void)addButtonClick:(UIButton *)sender
{
    CFAddBusinessCardController *addBusinessCard = [[CFAddBusinessCardController alloc] init];
    
    [self.navigationController pushViewController:addBusinessCard animated:YES];
}

- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, iPhoneX_BOTTOM_HEIGHT, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.businessCard.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 262;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFBusinessCardCell *cell = [CFBusinessCardCell cellWithTableView:tableView];
    cell.delegate = self;
    if (indexPath.row == 0) {
        cell.deleteBtn.hidden = YES;
    } else {
        cell.deleteBtn.hidden = NO;
    }
    cell.businessCard = self.businessCard[indexPath.row];
    return cell;
}

- (void)deleteBusinessCardButtonClick:(CFBusinessCardCell *)cell
{
    [UIAlertController showAlertWithTitle:@"温馨提示" message:@"删除该名片后，如要找回需要您重新添加，您确认删除该名片吗？" actionTitles:@[@"确定"] cancelTitle:@"取消" style:UIAlertControllerStyleAlert completion:^(NSInteger index) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"unitId"] = cell.businessCard.UNIT_ID;
        
        __weak typeof(self) weakSelf = self;
        [CFNetworkTools postResultWithUrl:DeleBusiness_Card_Interface params:params success:^(id _Nonnull responseObject) {
            CFLog(@"--->%@",responseObject);
            [weakSelf.tableView.mj_header endRefreshing];
            if ([responseObject[@"code"] isEqualToString:@"200"]) {
                [weakSelf setupRefresh];
            }
        } failure:^(NSError * _Nonnull error) {}];
    }];
}
@end
