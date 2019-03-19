//
//  TFPaymentInfoView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/13.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFPaymentView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol  TFPaymentInfoViewDelegate <NSObject>
/*** 关闭视图 ***/
- (void)closePaymentInfoViewButtonClick:(UIButton *)closeButton;
/*** 确认支付 ***/
- (void)countersignPaymentButtonClick:(UIButton *)countersignButton paymentManner:(TFPaymentManner)manner;
@end

@interface TFPaymentInfoView : UIView
@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic ,weak) id<TFPaymentInfoViewDelegate> delegate;

/*** 支付宝支付 ***/
- (IBAction)alipayPaymentButtonClick:(UIButton *)sender;
/*** 微信支付 ***/
- (IBAction)weChatPaymentButtonClick:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
