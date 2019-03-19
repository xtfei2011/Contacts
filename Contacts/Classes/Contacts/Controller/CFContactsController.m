//
//  CFContactsController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFContactsController.h"
#import "CFContactsTopView.h"
#import "TFPopupView.h"
#import "CFChooseLocationView.h"
#import "CFCitiesDataTool.h"
#import "CFHTTPSessionManager.h"

@interface CFContactsController ()
/** 任务管理者 */
@property (nonatomic ,strong) CFHTTPSessionManager *manager;

@property (nonatomic ,strong) CFContactsTopView *topView;
/*** 地址选择视图 ***/
@property (nonatomic ,strong) CFChooseLocationView *chooseLocationView;

@property (nonatomic ,assign) NSInteger page;
/*** 通知 ***/
@property (nonatomic ,weak) id notificationObj;

@property (nonatomic ,strong) NSString *location;
@end

@implementation CFContactsController

- (CFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [CFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [CFNetworkTools loadPersonalInformation];
    
    [[CFCitiesDataTool sharedManager] requestData];
    
    [self setTopView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.topView.xtfei_bottom + 5, 0, iPhoneX_BOTTOM_HEIGHT, 0);
    [self acceptanceNotification];
}

- (void)setTopView
{
    self.topView = [CFContactsTopView viewFromXib];
    self.topView.frame = CGRectMake(0, CFNavigationBarH, CFMainScreen_Width, 40);
    
    __weak typeof(self) weakSelf = self;
    self.topView.clickAddressBlock = ^{
        
        [TFPopupView coverFrom:weakSelf.navigationController.view contentView:weakSelf.chooseLocationView style:TFPopupViewStyleTranslucent showStyle:TFPopupViewShowStyleBottom animStyle:TFPopupViewAnimStyleBottom notClick:NO showBlock:nil hideBlock:^{
            if ([weakSelf.chooseLocationView.address length] == 0) {
                [weakSelf.topView.cityBtn setTitle:@"点击选择" forState:UIControlStateNormal];
            } else {
                [weakSelf.topView.cityBtn setTitle:weakSelf.chooseLocationView.city forState:UIControlStateNormal];
                
                if ([weakSelf.location isEqualToString:weakSelf.chooseLocationView.address]) {
                    return;
                } else {
                    weakSelf.location = weakSelf.chooseLocationView.address;
                    [weakSelf setupRefresh:weakSelf.chooseLocationView.address];
                }
            }
        }];
    };
    [self.view addSubview:self.topView];
}

- (void)acceptanceNotification
{
    __weak typeof(self) weakSelf = self;
    
    self.notificationObj = [[NSNotificationCenter defaultCenter] addObserverForName:@"loadHomeList" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        NSString *province = note.userInfo[@"province"];
        NSString *city = note.userInfo[@"city"];
        NSString *area = note.userInfo[@"area"];
        
        NSString *locationStr = [NSString stringWithFormat:@"%@ %@ %@",province ,city ,area];
        if ([weakSelf.location isEqualToString:locationStr]) {
            return;
        } else {
            weakSelf.location = locationStr;
            [weakSelf setupRefresh:locationStr];
        }
    }];
}

- (CFChooseLocationView *)chooseLocationView
{
    if (!_chooseLocationView) {
        _chooseLocationView = [[CFChooseLocationView alloc] initWithFrame:CGRectMake(0, CFMainScreen_Height *0.5, CFMainScreen_Width, CFMainScreen_Height *0.5)];
        _chooseLocationView.chooseFinish = ^{
            [TFPopupView hideView];
        };
    }
    return _chooseLocationView;
}

- (void)setupRefresh:(NSString *)address
{
    self.tableView.mj_header = [CFRefreshHeader headerWithRefreshingBlock:^{
        [self loadHomeList:address];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [CFRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreHomeList:address];
    }];
}

- (void)loadHomeList:(NSString *)address
{
    self.page = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"address"] = address;
    params[@"pageSize"] = @(10);
    params[@"pageNo"] = @(self.page);
    params[@"userId"] = [CFUSER_DEFAULTS objectForKey:@"userID"];
    
    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:Home_Interface params:params success:^(id _Nonnull responseObject) {
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

- (void)loadMoreHomeList:(NSString *)address
{
    self.page ++;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"address"] = address;
    params[@"pageSize"] = @(10);
    params[@"pageNo"] = @(self.page);
    params[@"userId"] = [CFUSER_DEFAULTS objectForKey:@"userID"];
    
    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:Home_Interface params:params success:^(id _Nonnull responseObject) {
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self.notificationObj];
}
@end
