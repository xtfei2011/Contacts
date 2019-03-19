//
//  CFCommViewController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFCommViewController.h"
#import "CFCommViewCell.h"
#import "CFCommDetailController.h"

@interface CFCommViewController ()

@end

@implementation CFCommViewController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(CFNavigationBarH + 5, 0, iPhoneX_BOTTOM_HEIGHT, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = CFCommonBgColor;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self tableView];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comm.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFCommViewCell *cell = [CFCommViewCell cellWithTableView:tableView];
    cell.comm = self.comm[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CFCommDetailController *commDetail = [[CFCommDetailController alloc] init];
    commDetail.self.other_people_id = self.comm[indexPath.row].USER_ID;
    commDetail.self.other_people_name = self.comm[indexPath.row].USER_NAME;
    [self.navigationController pushViewController:commDetail animated:YES];
}
@end
