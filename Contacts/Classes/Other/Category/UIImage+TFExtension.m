//
//  UIImage+TFExtension.m
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "UIImage+TFExtension.h"

@implementation UIImage (TFExtension)

+ (UIImage *)originImageWithName:(NSString *)name
{
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)circleImage
{
    CGSize size = self.size;
    CGFloat drawWH = size.width < size.height ? size.width : size.height;
    
    // 1. 开启图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(drawWH, drawWH));
    // 2. 绘制一个圆形区域, 进行裁剪
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect clipRect = CGRectMake(0, 0, drawWH, drawWH);
    CGContextAddEllipseInRect(context, clipRect);
    CGContextClip(context);
    
    // 3. 绘制大图片
    CGRect drawRect = CGRectMake(0, 0, size.width, size.height);
    [self drawInRect:drawRect];
    
    // 4. 取出结果图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5. 关闭上下文
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*** 规则 View 绘制 ***/
+ (UIImage *)imageWithWidth:(CGFloat)width height:(CGFloat)height color:(UIColor *)color
{
    UIView *view = [[UIView alloc] init];
    view.xtfei_width = width;
    view.xtfei_height = height;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = width *0.5;
    view.backgroundColor = color;
    
    CGSize size = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*** 获取图片路径 ***/
+ (NSString *)getImagePath:(UIImage *)image
{
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image ,1.0);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *imagePath = [[NSString alloc] initWithFormat:@"/direct_hire.png"];
    [fileManager createFileAtPath:[documentsPath stringByAppendingString:imagePath] contents:data attributes:nil];
    filePath = [[NSString alloc] initWithFormat:@"%@%@",documentsPath ,imagePath];
    
    return filePath;
}

+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = nil;
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    return image;
}

+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height *0.5];
}
@end
