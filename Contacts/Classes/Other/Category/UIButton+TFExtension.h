//
//  UIButton+TFExtension.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/11.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

/*** UIButton中图片和文字的关系 ***/
typedef NS_ENUM(NSInteger, TFButtonImageTitleStyle) {
    TFButtonImageTitleStyleLeft      = 0,     //图片在左，文字在右，整体居中。
    TFButtonImageTitleStyleRight     = 2,     //图片在右，文字在左，整体居中。
};

@interface UIButton (TFExtension)

+ (UIButton *)createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName target:(id)target action:(SEL)action;

/**
 *  调整按钮的文本图片布局
 *
 *  @param style            按钮样式
 *  @param padding          间距
 */
- (void)setButtonImageTitleStyle:(TFButtonImageTitleStyle)style padding:(CGFloat)padding;
@end

