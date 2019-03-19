//
//  UIView+TFExtension.m
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "UIView+TFExtension.h"

@implementation UIView (TFExtension)

- (CGSize)xtfei_size
{
    return self.frame.size;
}

- (void)setXtfei_size:(CGSize)xtfei_size
{
    CGRect frame = self.frame;
    frame.size = xtfei_size;
    self.frame = frame;
}

- (CGFloat)xtfei_width
{
    return self.frame.size.width;
}

- (CGFloat)xtfei_height
{
    return self.frame.size.height;
}

- (void)setXtfei_width:(CGFloat)xtfei_width
{
    CGRect frame = self.frame;
    frame.size.width = xtfei_width;
    self.frame = frame;
}

- (void)setXtfei_height:(CGFloat)xtfei_height
{
    CGRect frame = self.frame;
    frame.size.height = xtfei_height;
    self.frame = frame;
}

- (CGFloat)xtfei_x
{
    return self.frame.origin.x;
}

- (void)setXtfei_x:(CGFloat)xtfei_x
{
    CGRect frame = self.frame;
    frame.origin.x = xtfei_x;
    self.frame = frame;
}

- (CGFloat)xtfei_y
{
    return self.frame.origin.y;
}

- (void)setXtfei_y:(CGFloat)xtfei_y
{
    CGRect frame = self.frame;
    frame.origin.y = xtfei_y;
    self.frame = frame;
}

- (CGFloat)xtfei_centerX
{
    return self.center.x;
}

- (void)setXtfei_centerX:(CGFloat)xtfei_centerX
{
    CGPoint center = self.center;
    center.x = xtfei_centerX;
    self.center = center;
}

- (CGFloat)xtfei_centerY
{
    return self.center.y;
}

- (void)setXtfei_centerY:(CGFloat)xtfei_centerY
{
    CGPoint center = self.center;
    center.y = xtfei_centerY;
    self.center = center;
}

- (CGFloat)xtfei_right
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)xtfei_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setXtfei_right:(CGFloat)xtfei_right
{
    self.xtfei_x = xtfei_right - self.xtfei_width;
}

- (void)setXtfei_bottom:(CGFloat)xtfei_bottom
{
    self.xtfei_y = xtfei_bottom - self.xtfei_height;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

/*
 此方法用于给无图片的控件设置阴影和圆角
 @params offSet 阴影的偏移量
 @params shadowColor 阴影的颜色
 @params shadowRadius 阴影的圆角半径
 @params shadowOpacity 阴影的透明度
 @params radius 需要的圆角半径
 */
- (void)setShadowWithShadowOffset:(CGSize)offSet shadowColor:(UIColor *)shadowColor shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius
{
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = offSet;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = NO;
}
@end
