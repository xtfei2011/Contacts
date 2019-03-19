//
//  TFSetCommonGroup.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/10.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFSetCommonGroup : NSObject
/*** 组头 ***/
@property (nonatomic ,copy) NSString *header;
/*** 组尾 ***/
@property (nonatomic ,copy) NSString *footer;
/*** 这组的所有行模型 ***/
@property (nonatomic ,strong) NSArray *items;

+ (instancetype)group;
@end

NS_ASSUME_NONNULL_END
