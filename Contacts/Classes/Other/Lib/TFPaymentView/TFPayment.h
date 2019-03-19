//
//  TFPayment.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/12/12.
//  Copyright © 2018 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFPayment : NSObject
/*** 商家id ***/
@property (nonatomic ,strong) NSString *partnerid;
/*** 预支付订单 ***/
@property (nonatomic ,strong) NSString *prepayid;
/*** 随机串，防重发 ***/
@property (nonatomic ,strong) NSString *noncestr;
/*** 时间戳，防重发 ***/
@property (nonatomic ,strong) NSString *timestamp;
/*** 签名 ***/
@property (nonatomic ,strong) NSString *package;
/*** 微信开放平台文档对数据做的签名 ***/
@property (nonatomic ,strong) NSString *sign;
@end

NS_ASSUME_NONNULL_END
