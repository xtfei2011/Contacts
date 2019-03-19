//
//  UIColor+CFExtension.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/12.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (CFExtension)
// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *)colorWithHexString:(NSString *)color;
@end

NS_ASSUME_NONNULL_END
