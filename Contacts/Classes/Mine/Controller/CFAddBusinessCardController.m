//
//  CFAddBusinessCardController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/8.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFAddBusinessCardController.h"
#import "TFPopupView.h"
#import "CFChooseLocationView.h"
#import "CFAddBusinessCardView.h"
#import "CFCitiesDataTool.h"
#import "CFNavigationController.h"
#import "CFTabBarController.h"

@interface CFAddBusinessCardController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
/*** 内容视图 ***/
@property (nonatomic ,strong) CFAddBusinessCardView *addLocationView;
/*** 地址选择视图 ***/
@property (nonatomic ,strong) CFChooseLocationView *chooseLocationView;
@end

@implementation CFAddBusinessCardController

- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CFNavigationBarH, CFMainScreen_Width, CFMainScreen_Height - (CFNavigationBarH + 45) - iPhoneX_BOTTOM_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

- (CFChooseLocationView *)chooseLocationView
{
    if (!_chooseLocationView) {
        _chooseLocationView = [[CFChooseLocationView alloc] initWithFrame:CGRectMake(0, CFMainScreen_Height *0.5, CFMainScreen_Width, CFMainScreen_Height *0.5)];
    }
    return _chooseLocationView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = (self.addBusinessCardType == CFAddBusinessCardSaveType) ? @"新增名片" : @"编辑名片";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    [[CFCitiesDataTool sharedManager] requestData];
    
    [self setAddLocationView];
}

- (void)setAddLocationView
{
    self.addLocationView = [CFAddBusinessCardView viewFromXib];
    self.addLocationView.frame = CGRectMake(0, 0, CFMainScreen_Width, 210);
    self.tableView.tableHeaderView = self.addLocationView;
    self.tableView.tableFooterView = [UIView new];
    
    if (_addBusinessCardType == CFAddBusinessCardCompileType) {
        
        self.addLocationView.companyField.text = self.businessCard.UNIT_NAME;
        self.addLocationView.jobsField.text = self.businessCard.STATION_NAME;
        self.addLocationView.industryField.text = self.businessCard.TRADE_NAME;
        self.addLocationView.addressField.text = self.businessCard.UNIT_CONTACT_ADDRESS;
        self.addLocationView.detailTextView.text = self.businessCard.UNIT_DETAILED_ADDRESS;
    }
    
    __weak typeof(self) weakSelf = self;
    _addLocationView.selectAddressBlock = ^{
        [weakSelf.view endEditing:YES];
        
        [TFPopupView coverFrom:weakSelf.navigationController.view contentView:weakSelf.chooseLocationView style:TFPopupViewStyleTranslucent showStyle:TFPopupViewShowStyleBottom animStyle:TFPopupViewAnimStyleBottom notClick:NO showBlock:nil hideBlock:^{
            
            weakSelf.addLocationView.addressField.text = weakSelf.chooseLocationView.address;
        }];
    };
    
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CFMainScreen_Height - 44, CFMainScreen_Width, 44)];
    [saveBtn setBackgroundColor:CFColor(23, 181, 104)];
    [saveBtn setTitle:@"保 存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/*** 保存按钮点击事件 ***/
- (void)saveBtnClick:(UIButton *)sender
{
    if (_addLocationView.companyField.text.length == 0 || _addLocationView.jobsField.text.length == 0 || _addLocationView.detailTextView.text.length == 0 || _addLocationView.industryField.text.length == 0 || _addLocationView.addressField.text.length == 0) {

        [TFProgressHUD showInfoMsg:@"请填写完整名片信息"];
        return;
    } else {
        if (self.addBusinessCardType == CFAddBusinessCardSaveType) {
            [self addBusinessCard];
        } else if (self.addBusinessCardType == CFAddBusinessCardCompileType) {
            [self editBusinessCard];
        }
    }
}

/*** 编辑名片 ***/
- (void)editBusinessCard
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"unitName"] = self.addLocationView.companyField.text;
    params[@"unitStationId"] = self.addLocationView.position_id ? self.addLocationView.position_id : self.businessCard.STATION_ID;
    params[@"unitTradeId"] = self.addLocationView.industry_id ? self.addLocationView.industry_id : self.businessCard.TRADE_ID;
    params[@"unitContactAddress"] = self.addLocationView.addressField.text;
    params[@"unitDetailedAddress"] = self.addLocationView.detailTextView.text;
    params[@"unitId"] = self.businessCard.UNIT_ID;
    
    CFLog(@"%@", params);
    [TFProgressHUD showLoading:nil];
    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:EditBusiness_Card_Interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            [TFProgressHUD showMessage:@"修改成功"];
            if (self.isFirst) {
                CFNavigationController *nav = [[CFNavigationController alloc] initWithRootViewController:[[CFTabBarController alloc] init]];
                CFkeyWindowView.rootViewController = nav;
            } else {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [TFProgressHUD dismiss];
    }];
}

/*** 添加名片 ***/
- (void)addBusinessCard
{
    CFAccount *account = [CFAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"unitName"] = self.addLocationView.companyField.text;
    params[@"unitStationId"] = self.addLocationView.position_id;
    params[@"unitTradeId"] = self.addLocationView.industry_id;
    params[@"unitContactAddress"] = self.addLocationView.addressField.text;
    params[@"unitDetailedAddress"] = self.addLocationView.detailTextView.text;
    params[@"userId"] = account.USER_ID ? account.USER_ID : [CFUSER_DEFAULTS objectForKey:@"userID"];
    
    [TFProgressHUD showLoading:nil];
    __weak typeof(self) weakSelf = self;
    [CFNetworkTools postResultWithUrl:AddBusiness_Card_Interface params:params success:^(id _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            [TFProgressHUD showMessage:@"保存成功"];
            if (self.isFirst) {
                CFkeyWindowView.rootViewController = [[CFTabBarController alloc] init];
            } else {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [TFProgressHUD dismiss];
    }];
}
@end
