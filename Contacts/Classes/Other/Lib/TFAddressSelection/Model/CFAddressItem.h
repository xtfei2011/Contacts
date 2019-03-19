//
//  CFAddressItem.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/17.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFAddressItem : NSObject

@property (nonatomic ,copy) NSString *code;
@property (nonatomic ,copy) NSString *province;
@property (nonatomic ,copy) NSString *city;
@property (nonatomic ,copy) NSString *area;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *level;

@property (nonatomic ,assign) BOOL isSelected;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
