//
//  CFAccount.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/21.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFAccount : NSObject<NSCoding>
/*** 用户id ***/
@property (nonatomic ,strong) NSString *USER_ID;
/*** 用户昵称 ***/
@property (nonatomic ,strong) NSString *USER_NICKNAME;
/*** 微信号 ***/
@property (nonatomic ,strong) NSString *USER_WECHAT;
/*** 手机号 ***/
@property (nonatomic ,strong) NSString *USER_PHONE;
/*** 头像 ***/
@property (nonatomic ,strong) NSString *USER_PHOTO;
/*** 性别 ***/
@property (nonatomic ,strong) NSString *USER_SEX;
/*** 邮箱 ***/
@property (nonatomic ,strong) NSString *USER_EMAIL;
/*** QQ号 ***/
@property (nonatomic ,strong) NSString *USER_QQ;
/*** 用户真实姓名 ***/
@property (nonatomic ,strong) NSString *USER_NAME;
@end

NS_ASSUME_NONNULL_END
