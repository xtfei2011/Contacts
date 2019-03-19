//
//  CFAccountTool.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/21.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(CFAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (CFAccount *)account;

/**
 *  注销登录，删掉账户
 */
+ (void)logoutAccount;
@end

NS_ASSUME_NONNULL_END
