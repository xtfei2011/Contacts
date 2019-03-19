//
//  CFDimension.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, CFDimensionType) {
    /** 一维 */
    CFDimensionTypeFirst = 1,
    /** 二维 */
    CFDimensionTypeSecond = 2,
    /** 三维 */
    CFDimensionTypeThird = 3
};

@interface CFDimension : NSObject

@property (nonatomic ,assign) CFDimensionType type;
@end

NS_ASSUME_NONNULL_END
