//
//  CFComm.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/9.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFComm : NSObject
//用户ID
@property (nonatomic ,strong) NSString *USER_ID;
//用户姓名
@property (nonatomic ,strong) NSString *USER_NAME;
//职位名称
@property (nonatomic ,strong) NSString *STATION_NAME;
//用户头像
@property (nonatomic ,strong) NSString *USER_PHOTO;
//用户被浏览数
@property (nonatomic ,strong) NSString *USER_BROWSE_NUMBER;
//用户被点赞次数
@property (nonatomic ,strong) NSString *USER_LIKE_NUMBER;
//用户被收藏次数
@property (nonatomic ,strong) NSString *USER_COLLECTION_NUMBER;
//公司名称
@property (nonatomic ,strong) NSString *UNIT_NAME;
//手机号
@property (nonatomic ,strong) NSString *USER_PHONE;
@end

NS_ASSUME_NONNULL_END
