//
//  CFEditorController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/8.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFEditorController.h"
#import "CFEditorHeaderCell.h"
#import "CFPersonalInformationCell.h"

@interface CFEditorController ()

@end

@implementation CFEditorController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"完善个人信息";
    
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
        return 312.5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CFEditorHeaderCell *cell = [CFEditorHeaderCell cellWithTableView:tableView];
        return cell;
    } else {
        CFPersonalInformationCell *cell = [CFPersonalInformationCell cellWithTableView:tableView];
        return cell;
    }
}
@end
