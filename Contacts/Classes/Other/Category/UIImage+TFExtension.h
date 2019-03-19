//
//  UIImage+TFExtension.h
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TFExtension)

+ (UIImage *)originImageWithName:(NSString *)name;

- (UIImage *)circleImage;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/*** 规则 View 绘制 ***/
+ (UIImage *)imageWithWidth:(CGFloat)width height:(CGFloat)height color:(UIColor *)color;

/*** 获取图片路径 ***/
+ (NSString *)getImagePath:(UIImage *)image;

/*** 根据图片名自动加载适配的图片 ***/
+ (UIImage *)imageWithName:(NSString *)name;

/*** 根据图片名返回一张能够自由拉伸的图片 ***/
+ (UIImage *)resizedImage:(NSString *)name;

@end
