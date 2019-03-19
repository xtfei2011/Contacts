//
//  CFBusinessCard.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/12.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFBusinessCard : NSObject
//就职单位名称
@property (nonatomic ,strong) NSString *UNIT_NAME;
//职业
@property (nonatomic ,strong) NSString *STATION_NAME;
//职业ID
@property (nonatomic ,strong) NSString *STATION_ID;
//行业
@property (nonatomic ,strong) NSString *TRADE_NAME;
//行业ID
@property (nonatomic ,strong) NSString *TRADE_ID;
//省市地址
@property (nonatomic ,strong) NSString *UNIT_CONTACT_ADDRESS;
//详细地址
@property (nonatomic ,strong) NSString *UNIT_DETAILED_ADDRESS;
//职位记录ID
@property (nonatomic ,strong) NSString *UNIT_ID;
@end

NS_ASSUME_NONNULL_END
