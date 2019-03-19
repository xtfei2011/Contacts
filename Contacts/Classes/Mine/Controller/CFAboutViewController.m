//
//  CFAboutViewController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/13.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFAboutViewController.h"
#import "CFAboutViewCell.h"
#import "CFAboutTopView.h"
#import "CFAboutBottomView.h"
#import "TFWebViewController.h"
#import "TFPopupView.h"

@interface CFAboutViewController ()

@property (nonatomic ,strong) UIImageView *pictureView;
@end

@implementation CFAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [CFAboutTopView viewFromXib];
    self.tableView.tableFooterView = [CFAboutBottomView viewFromXib];
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, iPhoneX_BOTTOM_HEIGHT, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFAboutViewCell *cell = [CFAboutViewCell cellWithTableView:tableView];
    cell.index = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4) return;
    if (indexPath.row == 0) {
        TFWebViewController *webView = [[TFWebViewController alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Introduction" ofType:@"html"];
        NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [webView loadWebHTMLSring:html];
        [self.navigationController pushViewController:webView animated:YES];
    } else if (indexPath.row == 1) {
        [TFProgressHUD showMessage:@"版本更新"];
    } else if (indexPath.row == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ServicePhone]];
    } else if (indexPath.row == 3) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ServiceEmail]];
    } else {
    
        [TFPopupView coverFrom:self.navigationController.view contentView:self.pictureView style:TFPopupViewStyleTranslucent showStyle:TFPopupViewShowStyleCenter animStyle:TFPopupViewAnimStyleCenter notClick:NO showBlock:nil hideBlock:^{
            
        }];
    }
}

- (UIImageView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(CFMainScreen_Width /5, (CFMainScreen_Height - CFMainScreen_Width * 3/5) * 0.5, CFMainScreen_Width * 3/5, CFMainScreen_Width * 3/5)];
        _pictureView.backgroundColor = [UIColor whiteColor];
        _pictureView.image = [UIImage imageNamed:@"wechat_image.jpeg"];
    }
    return _pictureView;
}
@end
