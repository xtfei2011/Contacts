//
//  UIView+TFExtension.h
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TFExtension)

@property (nonatomic ,assign) CGSize xtfei_size;
@property (nonatomic ,assign) CGFloat xtfei_width;
@property (nonatomic ,assign) CGFloat xtfei_height;
@property (nonatomic ,assign) CGFloat xtfei_x;
@property (nonatomic ,assign) CGFloat xtfei_y;
@property (nonatomic ,assign) CGFloat xtfei_centerX;
@property (nonatomic ,assign) CGFloat xtfei_centerY;

@property (nonatomic ,assign) CGFloat xtfei_right;
@property (nonatomic ,assign) CGFloat xtfei_bottom;

+ (instancetype)viewFromXib;

- (BOOL)intersectWithView:(UIView *)view;

/*
 此方法用于给无图片的控件设置阴影和圆角
 @params offSet 阴影的偏移量
 @params shadowColor 阴影的颜色
 @params shadowRadius 阴影的圆角半径
 @params shadowOpacity 阴影的透明度
 @params radius 需要的圆角半径
 */
- (void)setShadowWithShadowOffset:(CGSize)offSet shadowColor:(UIColor *)shadowColor shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius;
@end
