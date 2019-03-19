//
//  CFLoginManager.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/14.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFLoginManager : NSObject
//用户三级用户数量
@property (nonatomic ,strong) NSString *RELATIONS_THREE_NUMBER;
//用户id
@property (nonatomic ,strong) NSString *USER_ID;
//用户状态（1.授权用户；2.发布过名片的；3.交过2元的; 4.已填写基本信息，但未添加职业信息）
@property (nonatomic ,strong) NSString *USER_STATU;
//用户一级用户数量
@property (nonatomic ,strong) NSString *RELATIONS_ONE_NUMBER;
//用户二级用户数量
@property (nonatomic ,strong) NSString *RELATIONS_TWO_NUMBER;
@end

NS_ASSUME_NONNULL_END
