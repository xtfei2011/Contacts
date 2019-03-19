//
//  CFLeftCategory.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFLeftCategory : NSObject

@property (nonatomic ,copy) NSString *TRADE_ID;
@property (nonatomic ,copy) NSString *TRADE_NAME;
@property (nonatomic ,copy) NSArray *trade_two;


@property (nonatomic ,copy) NSString *STATION_ID;
@property (nonatomic ,copy) NSString *STATION_NAME;
@property (nonatomic ,copy) NSArray *station_two;

@end

NS_ASSUME_NONNULL_END
