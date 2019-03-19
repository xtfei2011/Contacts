//
//  CFEarnings.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/12.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CFEarnDetail;
@interface CFEarnings : NSObject
//用户余额
@property (nonatomic ,strong) NSString *YeMoney;
//用户总收益
@property (nonatomic ,strong) NSString *SumSyMoney;
@property (nonatomic ,strong) NSArray *dataList;
@end

@interface CFEarnDetail : NSObject
//时间
@property (nonatomic ,strong) NSString *INCOME_TIME;
//标题
@property (nonatomic ,strong) NSString *INCOME_TITLE;
//收入金额
@property (nonatomic ,strong) NSString *INCOME_MONEY;
//收支状态
@property (nonatomic ,strong) NSString *INCOME_STATU;
//余额
@property (nonatomic ,strong) NSString *INCOME_YE_ALL_MONEY;
@end
NS_ASSUME_NONNULL_END
