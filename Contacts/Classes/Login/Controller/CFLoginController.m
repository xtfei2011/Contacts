//
//  CFLoginController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/14.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFLoginController.h"
#import "CFEditorController.h"
#import "CFNavigationController.h"
#import "CFLoginManager.h"
#import "CFAddBusinessCardController.h"
#import "CFTabBarController.h"

@interface CFLoginController ()

@property (nonatomic ,strong) CFLoginManager *login;
@end

@implementation CFLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([WXApi isWXAppInstalled]) {
        CFLog(@"---》微信登录");
        [self getAuthWithUserInfoWithPlatform:UMSocialPlatformType_WechatSession];
    } else {
        [TFProgressHUD showInfoMsg:@"系统检测到您没有安装微信应用"];
    }
}

- (void)getAuthWithUserInfoWithPlatform:(UMSocialPlatformType)type
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            CFLog(@"--->错误: %@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            NSUserDefaults *user = CFUSER_DEFAULTS;
            [user setObject:resp.openid forKey:@"openid"];
            [user setObject:resp.unionId forKey:@"unionId"];
            [user setObject:resp.iconurl forKey:@"header_image"];
            [user setObject:resp.name forKey:@"nickname"];
            [CFUSER_DEFAULTS synchronize];
            
            // 授权信息
            CFLog(@"Wechat uid: %@", resp.uid);
            CFLog(@"Wechat openid: %@", resp.openid);
            CFLog(@"Wechat unionid: %@", resp.unionId);
            CFLog(@"Wechat accessToken: %@", resp.accessToken);
            CFLog(@"Wechat refreshToken: %@", resp.refreshToken);
            CFLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            CFLog(@"Wechat name: %@", resp.name);
            CFLog(@"Wechat iconurl: %@", resp.iconurl);
            CFLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            CFLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"userOpenId"] = resp.openid;
            params[@"userUnionId"] = resp.unionId;
            params[@"nickName"] = resp.name;
            params[@"userPhoto"] = resp.iconurl;
            params[@"userSex"] = [resp.gender isEqualToString:@"男"] ? @"1" : @"2";
            params[@"sjUserId"] = @"";
            
            [TFProgressHUD showLoading:@"登录中···"];
            __weak typeof(self) weakSelf = self;
            [CFNetworkTools postResultWithUrl:Login_Interface params:params success:^(id _Nonnull responseObject) {
                CFLog(@"--->%@",responseObject);
                if ([responseObject[@"code"] isEqualToString:@"200"]) {
                    [TFProgressHUD showSuccess:@"登录成功"];
                    weakSelf.login = [CFLoginManager mj_objectWithKeyValues:responseObject[@"user"]];
                }
            } failure:^(NSError * _Nonnull error) {
                [TFProgressHUD dismiss];
            }];
        }
    }];
}

- (void)setLogin:(CFLoginManager *)login
{
    _login = login;
    
    NSUserDefaults *user = CFUSER_DEFAULTS;
    [user setObject:login.USER_ID forKey:@"userID"];
    [user setObject:login.USER_STATU forKey:@"USER_STATU"];
    [CFUSER_DEFAULTS synchronize];
    [CFNetworkTools loadPersonalInformation];
    
    if ([login.USER_STATU isEqualToString:@"1"]) {
        CFNavigationController *editor = [[CFNavigationController alloc] initWithRootViewController:[[CFEditorController alloc] init]];
        CFkeyWindowView.rootViewController = editor;
    } else if ([login.USER_STATU isEqualToString:@"4"]) {
        CFAddBusinessCardController *addBusiness = [[CFAddBusinessCardController alloc] init];
        addBusiness.isFirst = YES;
        CFNavigationController *addBusinessNav = [[CFNavigationController alloc] initWithRootViewController:addBusiness];
        CFkeyWindowView.rootViewController = addBusinessNav;
    } else {
        /*** 已经登录 ***/
        CFkeyWindowView.rootViewController = [[CFTabBarController alloc] init];
    }
}
@end
