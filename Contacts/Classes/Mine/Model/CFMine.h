//
//  CFMine.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/14.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CFUser;
@interface CFMine : NSObject

@property (nonatomic ,strong) NSString *sumMoney;
@property (nonatomic ,strong) CFUser *user;
@end


@interface CFUser : NSObject

@property (nonatomic ,strong) NSString *USER_BROWSE_NUMBER;
@property (nonatomic ,strong) NSString *USER_COLLECTION_NUMBER;
@property (nonatomic ,strong) NSString *USER_LIKE_NUMBER;
@property (nonatomic ,strong) NSString *USER_NAME;
@property (nonatomic ,strong) NSString *USER_PHOTO;
@end

NS_ASSUME_NONNULL_END
