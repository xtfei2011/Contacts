//
//  AppDelegate.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "AppDelegate.h"
#import "CFNavigationController.h"
#import "CFTabBarController.h"
#import "CFLoginController.h"
#import "CFShareManager.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = CFCommonBgColor;
    
    /*** 登录判断 ***/
    [self loginDetermine];
    
    /*** 友盟分享 ***/
    [CFShareManager setupShareAppKey];
    
    /*** 微信支付 ***/
    [WXApi registerApp:WXAPPID];
    
    [self.window makeKeyAndVisible];
    return YES;
}

/*** 登录判断 ***/
- (void)loginDetermine
{
    if ([[CFUSER_DEFAULTS objectForKey:@"USER_STATU"] isEqualToString:@"2"] || [[CFUSER_DEFAULTS objectForKey:@"USER_STATU"] isEqualToString:@"3"]) {
        /*** 已经登录 ***/
        self.window.rootViewController = [[CFTabBarController alloc] init];
    } else {
        /*** 没有登录 ***/
        CFNavigationController *loginVC = [[CFNavigationController alloc] initWithRootViewController:[[CFLoginController alloc] init]];
        self.window.rootViewController = loginVC;
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return result;
}

/*** 分享回调方法 ***/
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url host] isEqualToString:@"com.tencent.xin"]) {
        return [WXApi handleOpenURL:url delegate:self];
    } else {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            CFLog(@"result = %@",resultDic);
        }];
        if ([url.host isEqualToString:@"platformapi"]){ //支付宝钱包快登授权返回 authCode
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                CFLog(@"result = %@",resultDic);
            }];
        }
    }
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
    if (result == false) {
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        switch(response.errCode){
            case WXSuccess:
                CFLog(@"支付成功");
                /*** 支付状态通知（成功） ***/
                //                [[NSNotificationCenter defaultCenter] postNotificationName:@"paymentstatus" object:@(YES)];
                break;
            default:
                CFLog(@"支付失败，retcode=%d",resp.errCode);
                /*** 支付状态通知（失败） ***/
                //                [[NSNotificationCenter defaultCenter] postNotificationName:@"paymentstatus" object:@(NO)];
                break;
        }
    }
}
@end
