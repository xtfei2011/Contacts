//
//  CFBusinessCardInformationCell.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/11.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFBusinessCardInformationCell.h"
#import "UIImage+GIF.h"
#import "CFCommDetailController.h"
#import "CFSegmentTypeController.h"

@interface CFBusinessCardInformationCell ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *weChatLabel;
@property (weak, nonatomic) IBOutlet UILabel *tencentLabel;
@property (weak, nonatomic) IBOutlet UILabel *eailLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *industryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeBtn;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *duplicationBtn1;
@property (weak, nonatomic) IBOutlet UIButton *duplicationBtn2;
@property (weak, nonatomic) IBOutlet UIButton *duplicationBtn3;
@property (weak, nonatomic) IBOutlet UIButton *duplicationBtn4;
@end

@implementation CFBusinessCardInformationCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"swrm" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *image = [UIImage sd_animatedGIFWithData:imageData];
    self.gifView.image = image;
    
    [TFExtension chageControllerCircular:self.duplicationBtn1 cornerRadius:1.5 borderWidth:0.5 borderColor:CFColor(23, 181, 104) masksToBounds:YES];
    [TFExtension chageControllerCircular:self.duplicationBtn2 cornerRadius:1.5 borderWidth:0.5 borderColor:CFColor(23, 181, 104) masksToBounds:YES];
    [TFExtension chageControllerCircular:self.duplicationBtn3 cornerRadius:1.5 borderWidth:0.5 borderColor:CFColor(23, 181, 104) masksToBounds:YES];
    [TFExtension chageControllerCircular:self.duplicationBtn4 cornerRadius:1.5 borderWidth:0.5 borderColor:CFColor(23, 181, 104) masksToBounds:YES];
}

- (void)setCommDetail:(CFCommDetail *)commDetail
{
    _commDetail = commDetail;
    
    self.nameLabel.text = commDetail.USER_NAME;
    self.sexView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , (commDetail.USER_SEX == 1) ? @"gentleman" : @"madam"]];
    self.positionLabel.text = commDetail.STATION_NAME;
    self.phoneLabel.text = commDetail.USER_PHONE;
    self.weChatLabel.text = commDetail.USER_WECHAT;
    self.tencentLabel.text = commDetail.USER_QQ;
    self.eailLabel.text = commDetail.USER_EMAIL;
    self.companyLabel.text = commDetail.UNIT_NAME;
    self.industryLabel.text = commDetail.TRADE_NAME;
    self.addressLabel.text = commDetail.UNIT_DETAILED_ADDRESS;
    
    if ([commDetail.LIKE isEqualToString:@"0"]) {
        [self.praiseBtn setImage:[UIImage imageNamed:@"praise_normal"] forState:UIControlStateNormal];
    } else {
        [self.praiseBtn setImage:[UIImage imageNamed:@"praise_highlig"] forState:UIControlStateNormal];
    }
    
    if ([commDetail.COLLECTION isEqualToString:@"0"]) {
        [self.focusBtn setImage:[UIImage imageNamed:@"collection_normal"] forState:UIControlStateNormal];
    } else {
        [self.focusBtn setImage:[UIImage imageNamed:@"collection_highlighted"] forState:UIControlStateNormal];
    }
    
    [self setupButtonTitle:self.seeBtn count:commDetail.USER_BROWSE_NUMBER defaultTitle:@"0"];
    [self setupButtonTitle:self.focusBtn count:commDetail.USER_COLLECTION_NUMBER defaultTitle:@"0"];
    [self setupButtonTitle:self.praiseBtn count:commDetail.USER_LIKE_NUMBER defaultTitle:@"0"];
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count defaultTitle:(NSString *)defaultTitle
{
    if (count >= 10000) {
        defaultTitle = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    } else if (count > 0) {
        defaultTitle = [NSString stringWithFormat:@"%ld",count];
    }
    
    [button setTitle:defaultTitle forState:UIControlStateNormal];
}

- (IBAction)bottomToolBarButtonClick:(UIButton *)sender
{
    if (sender.tag == 1101) {
        CFLog(@"收藏");
        [self bottomToolBar:Add_Collection_Interface];
    } else {
        CFLog(@"点赞");
        [self bottomToolBar:Add_Praise_Interface];
    }
}

/*** 查看他的三维人脉 ***/
- (IBAction)checkConnectionsButtonClick:(UIButton *)sender
{
    CFCommDetailController *detail = (CFCommDetailController *)[sender currentViewController];
    
    CFSegmentTypeController *segment = [[CFSegmentTypeController alloc] init];
    segment.navigationItem.title = @"三维人脉";
    segment.user_id = self.commDetail.USER_ID;
    [detail.navigationController pushViewController:segment animated:YES];
}

- (void)bottomToolBar:(NSString *)interface
{
    CFAccount *account = [CFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = account.USER_ID;
    params[@"userBId"] = self.commDetail.USER_ID;

    [CFNetworkTools postResultWithUrl:interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            [TFProgressHUD showMessage:@"成功"];
            dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshDetailContent" object:nil];
            });
        }
    } failure:^(NSError * _Nonnull error) {}];
}

- (IBAction)copyButtonClick:(UIButton *)sender
{
    [TFProgressHUD showMessage:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (sender.tag == 2000) {
        pasteboard.string = self.phoneLabel.text;
    } else if (sender.tag == 2001) {
        pasteboard.string = self.weChatLabel.text;
    } else if (sender.tag == 2002) {
        pasteboard.string = self.tencentLabel.text;
    } else if (sender.tag == 2003) {
        pasteboard.string = self.eailLabel.text;
    }
}

@end
