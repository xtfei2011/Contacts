//
//  TFPaymentView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/13.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFPayment.h"

typedef enum : NSUInteger {

    TFPaymentMannerAlipay =  0,    // 支付宝付款
    TFPaymentMannerWeChat = 1,     // 微信付款
    
} TFPaymentManner;

NS_ASSUME_NONNULL_BEGIN
@interface TFPaymentView : UIView

/**
 *  快速创建一个付款视图
 *
 *  @param info          付款详情
 *  @param money         金额
 *  @param manner        付款方式
 *  @param payment       信息
 */
- (instancetype)initWithPaymentInfo:(NSString *)info paymentMoney:(NSString *)money payment:(TFPayment *)payment paymentManner:(TFPaymentManner)manner;

/*** 显示付款视图 ***/
- (void)show;

/*** 销毁付款视图 ***/
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
