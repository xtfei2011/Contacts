//
//  CFCommDetailController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFCommDetailController.h"
#import "CFCommDetailCell.h"
#import "CFBrowseViewCell.h"
#import "TFPaymentView.h"

@interface CFCommDetailController ()
@property (nonatomic ,strong) NSMutableArray<CFCommDetail *> *commDetail;
/*** 通知 ***/
@property (nonatomic ,weak) id observe;
@property (nonatomic ,strong) NSMutableArray<CFComm *> *comm;
@property (nonatomic ,strong) TFPaymentView *paymentView;
@end

@implementation CFCommDetailController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /*** 统计浏览人数 ***/
    CFAccount *account = [CFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] =  account.USER_ID;
    params[@"userBId"] = self.other_people_id;
    
    [CFNetworkTools postResultWithUrl:Browse_Detail_Interface params:params success:^(id  _Nonnull responseObject) {
        [self loadCommDetail];
    } failure:^(NSError * _Nonnull error) {}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@的名片",self.other_people_name];

    [self setupTableView];
    [self setUpExceptions];
    
    __weak typeof(self) weakSelf = self;
    self.observe = [[NSNotificationCenter defaultCenter] addObserverForName:@"RefreshDetailContent" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf loadCommDetail];
    }];
}

- (void)setUpExceptions
{
    if ([[CFUSER_DEFAULTS objectForKey:@"USER_STATU"] isEqualToString:@"3"]) return;
    self.tableView.scrollEnabled = NO;
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(-10, CFMainScreen_Width + 10, CFMainScreen_Width + 20, CFMainScreen_Height - CFMainScreen_Width - 10);
    [self.tableView addSubview:effectview];
    
    UIButton *paymentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CFMainScreen_Height - 44, CFMainScreen_Width, 44)];
    paymentBtn.backgroundColor = CFColor(23, 181, 104);
    [paymentBtn setTitle:@"缴纳2元/年查看所有人名片" forState:UIControlStateNormal];
    [paymentBtn addTarget:self action:@selector(paymentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:paymentBtn];
}

- (void)loadCommDetail
{
    CFAccount *account = [CFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = self.other_people_id ? self.other_people_id : CustomerService;
    params[@"browseUserId"] = account.USER_ID;
    
    [TFProgressHUD showLoading:@"加载中···"];
    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:Business_Card_Interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            weakSelf.commDetail = [CFCommDetail mj_objectArrayWithKeyValuesArray:responseObject[@"PageData"]];
            [weakSelf.tableView reloadData];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"userId"] = self.other_people_id ? self.other_people_id : CustomerService;
            dict[@"pageSize"] = @(5);
            dict[@"pageNo"] = @(1);
            dict[@"statu"] = @(0);
            
            [CFNetworkTools postResultWithUrl:Browse_Interface params:dict success:^(id _Nonnull responseObject) {
                CFLog(@"--->%@",responseObject);
                [TFProgressHUD dismiss];
                if ([responseObject[@"code"] isEqualToString:@"200"]) {
                    weakSelf.comm = [CFComm mj_objectArrayWithKeyValuesArray:responseObject[@"PageData"]];
                    [weakSelf.tableView reloadData];
                }
            } failure:^(NSError * _Nonnull error) {}];
        }
    } failure:^(NSError * _Nonnull error) {}];
}

- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, iPhoneX_BOTTOM_HEIGHT, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row) ? 64 : CFMainScreen_Width + 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CFCommDetailCell *cell = [CFCommDetailCell cellWithTableView:tableView];
        cell.commDetail = self.commDetail;
        return cell;
    } else {
        CFBrowseViewCell *cell = [CFBrowseViewCell cellWithTableView:tableView];
        cell.comm = self.comm;
        cell.other_people_id = self.other_people_id;
        return cell;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self.observe];
}

- (void)paymentButtonClick:(UIButton *)sender
{
    self.paymentView = [[TFPaymentView alloc] initWithPaymentInfo:@"升级会员" paymentMoney:@"￥ 2.00" payment:@"" paymentManner:0];
    
    [self.paymentView show];
}
@end
