//
//  CFFindController.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFFindController : UIViewController

@property (nonatomic ,copy) void(^changeIndustryBlock)(NSString *industry_id ,NSString *industry);
@property (nonatomic ,assign) NSInteger from;
@end

NS_ASSUME_NONNULL_END
