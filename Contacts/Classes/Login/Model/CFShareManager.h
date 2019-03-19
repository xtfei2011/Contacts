//
//  CFShareManager.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/14.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFShareManager : NSObject
/**
 *  设置分享的AppKey，Appdelegate中执行一次即可。
 */
+ (void)setupShareAppKey;
@end

NS_ASSUME_NONNULL_END
