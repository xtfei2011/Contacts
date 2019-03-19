//
//  CFAccountTool.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/21.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFAccountTool.h"

@implementation CFAccountTool
/**
 *  保存账户
 */
+ (void)saveAccount:(CFAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:CFCustomCacheFile];
}

/**
 *  返回账户 */
+ (CFAccount *)account
{
    CFAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:CFCustomCacheFile];
    return account;
}

/**
 *  销毁账户
 */
+ (void)logoutAccount
{
    NSFileManager *fileManeger = [NSFileManager defaultManager];
    if ([fileManeger isDeletableFileAtPath:CFCustomCacheFile]) {
        
        [fileManeger removeItemAtPath:CFCustomCacheFile error:nil];
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [TFProgressHUD showInfoMsg:@"您的账号成功退出"];
        });
    }
}
@end
