//
//  CFChooseLocationView.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/17.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFChooseLocationView : UIView

/*** 拼接后的地址 ***/
@property (nonatomic ,copy) NSString *address;
/*** 单个地址 ***/
@property (nonatomic ,copy) NSString *city;

@property (nonatomic ,copy) void(^chooseFinish)(void);

/*** 省 ***/
@property (nonatomic ,copy) NSString *province_id;
/*** 市 ***/
@property (nonatomic ,copy) NSString *city_id;
/*** 区 ***/
@property (nonatomic ,copy) NSString *district_id;
@end

NS_ASSUME_NONNULL_END
