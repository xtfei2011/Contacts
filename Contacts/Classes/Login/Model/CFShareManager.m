//
//  CFShareManager.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/14.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFShareManager.h"

@implementation CFShareManager

+ (void)setupShareAppKey
{
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5767be1be0f55a1707001198"];
    /*** 微信 ***/
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAPPID appSecret:WXSecret redirectURL:nil];
}
@end
