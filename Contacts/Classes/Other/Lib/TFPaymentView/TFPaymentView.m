//
//  TFPaymentView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/13.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "TFPaymentView.h"
#import "TFPaymentInfoView.h"
#import <AlipaySDK/AlipaySDK.h>

@interface TFPaymentView ()<TFPaymentInfoViewDelegate>

@property (nonatomic ,strong) TFPaymentInfoView *infoView;

@property (nonatomic ,assign) TFPaymentManner manner;
@property (nonatomic ,strong) NSString *info;
@property (nonatomic ,strong) NSString *money;
@property (nonatomic ,strong) TFPayment *payment;
@end

@implementation TFPaymentView

- (instancetype)initWithPaymentInfo:(NSString *)info paymentMoney:(NSString *)money payment:(TFPayment *)payment paymentManner:(TFPaymentManner)manner
{
    if (self = [super init]) {
        
        self.manner = manner;
        self.info = info;
        self.money = money;
        self.payment = payment;
    }
    return self;
}

- (void)show
{
    self.backgroundColor = CFRGBColor(5, 5, 5, 0.3);
    self.frame = CFScreeFrame;
    [CFkeyWindowView addSubview:self];
    
    self.infoView = [TFPaymentInfoView viewFromXib];
    self.infoView.delegate = self;
    self.infoView.moneyLabel.text = self.money;
    self.infoView.infoLabel.text = self.info;
    
    if (self.manner == TFPaymentMannerAlipay) {
        [self.infoView alipayPaymentButtonClick:self.infoView.alipayBtn];
    } else {
        [self.infoView weChatPaymentButtonClick:self.infoView.weChatBtn];
    }
    
    self.infoView.frame = CGRectMake(0, CFMainScreen_Height, CFMainScreen_Width, 350);
    [CFkeyWindowView addSubview:self.infoView];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.infoView.transform = CGAffineTransformTranslate(self.infoView.transform, 0, -350);
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.infoView.transform = CGAffineTransformTranslate(self.infoView.transform, 0, 350);
        
    } completion:^(BOOL finished) {
        [self.infoView removeFromSuperview];
        [self removeFromSuperview];
        self.manner = 0;
        self.info = nil;
        self.money = nil;
        self.payment = nil;
    }];
}

/*** 关闭视图 ***/
- (void)closePaymentInfoViewButtonClick:(UIButton *)closeButton
{
    [self dismiss];
}

/*** 确认支付 ***/
- (void)countersignPaymentButtonClick:(UIButton *)countersignButton paymentManner:(TFPaymentManner)manner
{
    [self dismiss];
    self.manner = manner;
    
    if (manner == TFPaymentMannerAlipay) {
        CFLog(@"--->支付宝");
        [[AlipaySDK defaultService] payOrder:@"" fromScheme:APPSCHEME callback:^(NSDictionary *resultDic) {
            
            CFLog(@"---->%@",resultDic);
            [TFProgressHUD showMessage:resultDic[@"memo"]];
        }];
        
    } else {
        if ([WXApi isWXAppInstalled]) {
            
            [TFProgressHUD showMessage:@"你猜你丫能不能支付成功"];
            return;
            PayReq *req = [[PayReq alloc] init];
            req.partnerId = self.payment.partnerid;
            req.prepayId = self.payment.prepayid;
            req.nonceStr = self.payment.noncestr;
            req.timeStamp = self.payment.timestamp.intValue;
            req.package = self.payment.package;
            req.sign = self.payment.sign;
            
            [WXApi sendReq:req];
            
        } else {
            [TFProgressHUD showInfoMsg:@"系统检测到您手机未安装微信"];
        }
        
    }
}
@end
