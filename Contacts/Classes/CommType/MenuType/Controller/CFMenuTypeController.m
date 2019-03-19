//
//  CFMenuTypeController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFMenuTypeController.h"
#import "CFMenuView.h"

@interface CFMenuTypeController ()<CFMenuViewDelegate>
/*** 顶部菜单栏 ***/
@property (nonatomic ,strong) CFMenuView *menuView;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic ,assign) NSInteger selectedIndex;

@property (nonatomic ,strong) NSString *partInterface;
@end

@implementation CFMenuTypeController

- (CFMenuView *)menuView
{
    if (!_menuView) {
        CGFloat menuView_Y = 0;
        _menuView = [[CFMenuView alloc] initWithFrame:CGRectMake(0, CFNavigationBarH + menuView_Y, CFMainScreen_Width, 40)];
        _menuView.delegate = self;
    }
    return _menuView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.menuView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.menuView.xtfei_bottom + 5, 0, iPhoneX_BOTTOM_HEIGHT, 0);
    
    /*** 获取默认数据 ***/
    [self setupRefresh:@"0"];
}

- (void)setupRefresh:(NSString *)loadkey
{
    self.tableView.mj_header = [CFRefreshHeader headerWithRefreshingBlock:^{
        [self loadIndustryList:loadkey];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [CFRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreIndustryList:loadkey];
    }];
}

- (void)initWithMenuView:(CFMenuView *)menuView selectedIndex:(NSInteger)index clickType:(CFButtonClickType)clickType
{
    self.selectedIndex = index;
    if (index == 100) {
        CFLog(@"综合");
        switch (clickType) {
            case CFButtonClickTypeNormal:
                CFLog(@"默认排序");
                [self setupRefresh:@"0"];
                break;
            case CFButtonClickTypeUp:
                CFLog(@"升序排序");
                [self setupRefresh:@"2"];
                break;
            case CFButtonClickTypeDown:
                CFLog(@"降序排序");
                [self setupRefresh:@"1"];
                break;
            default:
                break;
        }
    } else if (index == 101) {
        CFLog(@"销量");
        switch (clickType) {
            case CFButtonClickTypeNormal:
                CFLog(@"默认排序");
                [self setupRefresh:@"0"];
                break;
            case CFButtonClickTypeUp:
                CFLog(@"升序排序");
                [self setupRefresh:@"6"];
                break;
            case CFButtonClickTypeDown:
                CFLog(@"降序排序");
                [self setupRefresh:@"5"];
                break;
            default:
                break;
        }
        
    } else if (index == 102) {
        switch (clickType) {
            case CFButtonClickTypeNormal:
                CFLog(@"默认排序");
                [self setupRefresh:@"0"];
                break;
            case CFButtonClickTypeUp:
                CFLog(@"升序排序");
                [self setupRefresh:@"4"];
                break;
            case CFButtonClickTypeDown:
                CFLog(@"降序排序");
                [self setupRefresh:@"3"];
                break;
            default:
                break;
        }
    }
}

/*** 获取商品列表 ***/
- (void)loadIndustryList:(NSString *)loadKey
{
    self.page = 1;
    CFAccount *acount = [CFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.industry_id) {
        params[@"tradeId"] = self.industry_id;
        self.partInterface = Classification_Content_Interface;
    } else if (self.browse_id) {
        params[@"userId"] = self.browse_id;
        self.partInterface = Browse_Interface;
    } else {
        params[@"userId"] = acount.USER_ID;
        self.partInterface = ([self.interface length] > 0) ? self.interface : Collection_Interface;
        
        CFLog(@"--->%@",self.partInterface);
    }
    
    params[@"pageSize"] = @(10);
    params[@"pageNo"] = @(self.page);
    params[@"statu"] = loadKey;

    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:self.partInterface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        [weakSelf.tableView.mj_header endRefreshing];
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            weakSelf.comm = [CFComm mj_objectArrayWithKeyValuesArray:responseObject[@"PageData"]];
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {}];
}

- (void)loadMoreIndustryList:(NSString *)loadKey
{
    self.page ++;
    CFAccount *acount = [CFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.industry_id) {
        params[@"tradeId"] = self.industry_id;
        self.partInterface = Classification_Content_Interface;
    } else if (self.browse_id) {
        params[@"userId"] = self.browse_id;
        self.partInterface = Browse_Interface;
    } else {
        params[@"userId"] = acount.USER_ID;
        self.partInterface = ([self.interface length] > 0) ? self.interface : Collection_Interface;
    }
    params[@"pageSize"] = @(10);
    params[@"pageNo"] = @(self.page);
    params[@"statu"] = loadKey;

    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:self.partInterface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            NSArray<CFComm *> *moredcomm = [CFComm mj_objectArrayWithKeyValuesArray:responseObject[@"PageData"]];
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.comm addObjectsFromArray:moredcomm];
        } else {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError * _Nonnull error) {}];
}

@end
