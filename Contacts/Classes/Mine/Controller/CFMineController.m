//
//  CFMineController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFMineController.h"
#import "TFSetCommonGroup.h"
#import "TFSetCommonArrowItem.h"
#import "TFSetCommonIconArrowItem.h"
#import "CFMineTopView.h"
#import "CFMenuTypeController.h"
#import "CFSegmentTypeController.h"
#import "CFEarningsController.h"
#import "CFBusinessCardController.h"
#import "CFBankCardController.h"
#import "CFAboutViewController.h"
#import "CFMine.h"
#import "CFCommDetailController.h"
#import "CFLaboratoryController.h"

@interface CFMineController ()
@property (nonatomic ,strong) CFMineTopView *topView;
@property (nonatomic ,strong) TFSetCommonIconArrowItem *earnings;
@property (nonatomic ,strong) CFMine *mine;
@end

@implementation CFMineController

- (CFMineTopView *)topView
{
    if (!_topView) {
        _topView = [CFMineTopView viewFromXib];
        _topView.frame = CGRectMake(0, 0, CFMainScreen_Width, 90);
    }
    return _topView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadPersonalInformation];
}

- (void)loadPersonalInformation
{
    CFAccount *account = [CFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = account.USER_ID;
    
    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:Mine_Interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            weakSelf.mine = [CFMine mj_objectWithKeyValues:responseObject];
        }
    } failure:^(NSError * _Nonnull error) {}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroups];
}

- (void)setMine:(CFMine *)mine
{
    _mine = mine;
    
    self.tableView.tableHeaderView = self.topView;
    self.topView.user = self.mine.user;
    self.earnings.text = [NSString stringWithFormat:@"¥ %@", self.mine.sumMoney];
    [self.tableView reloadData];
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    TFSetCommonGroup *group = [TFSetCommonGroup group];
    [self.groups addObject:group];
    
    TFSetCommonArrowItem *favorite = [TFSetCommonArrowItem itemWithTitle:@"收藏夹"];
    favorite.destVcClass = [CFMenuTypeController class];
    group.items = @[favorite];
}

- (void)setupGroup1
{
    TFSetCommonGroup *group = [TFSetCommonGroup group];
    [self.groups addObject:group];
    
    TFSetCommonArrowItem *connection = [TFSetCommonArrowItem itemWithTitle:@"三维人脉"];
    connection.destVcClass = [CFSegmentTypeController class];
    
    TFSetCommonArrowItem *card = [TFSetCommonArrowItem itemWithTitle:@"我的名片"];
    card.destVcClass = [CFBusinessCardController class];
    
    self.earnings = [TFSetCommonIconArrowItem itemWithTitle:@"我的收益"];
    self.earnings.destVcClass = [CFEarningsController class];
    
    group.items = @[connection, card, self.earnings];
}

- (void)setupGroup2
{
    TFSetCommonGroup *group = [TFSetCommonGroup group];
    [self.groups addObject:group];
    
    TFSetCommonArrowItem *card = [TFSetCommonArrowItem itemWithTitle:@"银行卡"];
    card.destVcClass = [CFBankCardController class];
    
    TFSetCommonArrowItem *about = [TFSetCommonArrowItem itemWithTitle:@"关于我们"];
    about.destVcClass = [CFAboutViewController class];
    
    TFSetCommonArrowItem *service = [TFSetCommonArrowItem itemWithTitle:@"联系客服"];
    service.destVcClass = [CFCommDetailController class];
    
    TFSetCommonArrowItem *attempt = [TFSetCommonArrowItem itemWithTitle:@"实验室"];
    attempt.destVcClass = [CFLaboratoryController class];
    
    group.items = @[card, about, service, attempt];
}
@end
