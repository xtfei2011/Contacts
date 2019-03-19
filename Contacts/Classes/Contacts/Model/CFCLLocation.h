//
//  CFCLLocation.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/9.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFCLLocation : CLLocationManager
+ (CFCLLocation *)shareLocation;

/// 判断定位操作是否被允许
- (BOOL)isEnabledLocation;

/// 定位开始后手动停止
- (void)locationStop;

/// 定位结果回调
- (void)locationStart:(void (^)(CLLocation *location, CLPlacemark *placemark))success faile:(void (^)(NSError *error))faile;
@end

NS_ASSUME_NONNULL_END
