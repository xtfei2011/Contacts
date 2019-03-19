//
//  CFCommDetail.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/9.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFCommDetail : NSObject
//用户ID
@property (nonatomic ,strong) NSString *USER_ID;
//用户姓名
@property (nonatomic ,strong) NSString *USER_NAME;
//职位
@property (nonatomic ,strong) NSString *STATION_NAME;
//邮箱
@property (nonatomic ,strong) NSString *USER_EMAIL;
//性别
@property (nonatomic ,assign) NSInteger USER_SEX;
//用户头像
@property (nonatomic ,strong) NSString *USER_PHOTO;
//用户被浏览数
@property (nonatomic ,assign) NSInteger USER_BROWSE_NUMBER;
//用户被点赞次数
@property (nonatomic ,assign) NSInteger USER_LIKE_NUMBER;
//用户被收藏次数
@property (nonatomic ,assign) NSInteger USER_COLLECTION_NUMBER;
//公司名称
@property (nonatomic ,strong) NSString *UNIT_NAME;
//手机号
@property (nonatomic ,strong) NSString *USER_PHONE;
//微信号
@property (nonatomic ,strong) NSString *USER_WECHAT;
//用户qq号
@property (nonatomic ,strong) NSString *USER_QQ;
//行业名称
@property (nonatomic ,strong) NSString *TRADE_NAME;
//详细地址
@property (nonatomic ,strong) NSString *UNIT_DETAILED_ADDRESS;
//省市地址
@property (nonatomic ,strong) NSString *UNIT_CONTACT_ADDRESS;
//是否点赞
@property (nonatomic ,strong) NSString *LIKE;
//是否收藏
@property (nonatomic ,strong) NSString *COLLECTION;
@end

NS_ASSUME_NONNULL_END
