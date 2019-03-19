//
//  UIBarButtonItem+TFExtension.h
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/21.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TFExtension)
/*** 图标 ***/
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

/*** 文字 ***/
+ (instancetype)itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;
@end
