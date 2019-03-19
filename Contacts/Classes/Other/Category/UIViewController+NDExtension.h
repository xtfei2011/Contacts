//
//  UIViewController+NDExtension.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NDExtension)

/*** 快速创建AlertController：包括Alert 和 ActionSheet ***/
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray<NSString *> *)actions cancelTitle:(NSString *)cancelTitle style:(UIAlertControllerStyle)style completion:(void(^)(NSInteger index))completion;
@end

NS_ASSUME_NONNULL_END
