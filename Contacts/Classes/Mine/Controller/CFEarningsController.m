//
//  CFEarningsController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFEarningsController.h"
#import "CFEarningsView.h"
#import "CFEarnHeaderView.h"
#import "CFEarningsCell.h"
#import "CFEarnings.h"
#import "CFBankCard.h"

@interface CFEarningsController ()
@property (nonatomic ,strong) CFEarnings *earning;
@property (nonatomic ,strong) CFEarningsView *earningsView;
@property (nonatomic ,strong) CFEarnHeaderView *headerView;
@property (nonatomic ,strong) NSMutableArray<CFBankCard *> *bankCard;

@end

@implementation CFEarningsController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CFAccount *account = [CFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = account.USER_ID;
    
    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:Card_Interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        [weakSelf.tableView.mj_header endRefreshing];
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            weakSelf.bankCard = [CFBankCard mj_objectArrayWithKeyValuesArray:responseObject[@"bank"]];
            self.earningsView.bankCard = weakSelf.bankCard;
            
            [self loadEarningsData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.earningsView = [CFEarningsView viewFromXib];
    self.earningsView.frame = CGRectMake(0, 0, CFMainScreen_Width, 150);
    self.tableView.tableHeaderView = self.earningsView;
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 35;
    self.tableView.sectionHeaderHeight = 35;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, iPhoneX_BOTTOM_HEIGHT, 0);
}

- (void)loadEarningsData
{
    CFAccount *account = [CFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = account.USER_ID;
    
    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:Earnings_Interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        [weakSelf.tableView.mj_header endRefreshing];
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            weakSelf.earning = [CFEarnings mj_objectWithKeyValues:responseObject];
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {}];
}

- (void)setEarning:(CFEarnings *)earning
{
    _earning = earning;
    
    self.earningsView.earnings = earning;
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.earning.dataList.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CFEarnHeaderView *headerView = [CFEarnHeaderView viewFromXib];
    headerView.frame = CGRectMake(0, 0, CFMainScreen_Width, 40);
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFEarningsCell *cell = [CFEarningsCell cellWithTableView:tableView];
    cell.earnDetail = self.earning.dataList[indexPath.row];
    return cell;
}

@end
