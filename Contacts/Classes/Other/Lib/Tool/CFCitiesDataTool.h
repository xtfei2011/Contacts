//
//  CFCitiesDataTool.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/17.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFCitiesDataTool : NSObject

+ (instancetype)sharedManager;

- (void)requestData;

/*** 查询所有的省 ***/
- (NSMutableArray *)queryAllProvincialLevel;

/*** 查询所有的市 ***/
- (NSMutableArray *)queryRecordWithProvincial:(NSString *)provincial;

/*** 查询所有的区 ***/
- (NSMutableArray *)queryRecordWithProvincial:(NSString *)provincial city:(NSString *)city;

/*** 根据areaCode, 查询地址 ***/
- (NSString *)queryRecordWithAreaCode:(NSString *)areaCode;

@end

NS_ASSUME_NONNULL_END
