//
//  UIViewController+NDExtension.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "UIViewController+NDExtension.h"

@implementation UIViewController (NDExtension)

/*** 快速创建AlertController：包括Alert 和 ActionSheet ***/
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray<NSString *> *)actions cancelTitle:(NSString *)cancelTitle style:(UIAlertControllerStyle)style completion:(void(^)(NSInteger index))completion
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    for (NSInteger index = 0; index < actions.count; index ++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:actions[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !completion ? : completion(index);
        }];
        [alert addAction:action];
    }
    if (cancelTitle.length) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
    }
    
    UIViewController *vc = [[UIApplication sharedApplication] keyWindow].rootViewController;
    [vc presentViewController:alert animated:YES completion:nil];
}
@end
