//
//  CFEditPersonalInformationController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/15.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFEditPersonalInformationController.h"
#import "CFEditorHeaderCell.h"
#import "CFEditPersonalInformationCell.h"

@interface CFEditPersonalInformationController ()

@end

@implementation CFEditPersonalInformationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"编辑个人信息";
    [CFNetworkTools loadPersonalInformation];
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, iPhoneX_BOTTOM_HEIGHT, 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    } else {
        return 202;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CFEditorHeaderCell *cell = [CFEditorHeaderCell cellWithTableView:tableView];
        return cell;
        
    } else {
        CFEditPersonalInformationCell *cell = [CFEditPersonalInformationCell cellWithTableView:tableView];
        return cell;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [CFNetworkTools loadPersonalInformation];
}
@end
