//
//  TFExtension.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/10.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "TFExtension.h"

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

@implementation TFExtension
/**
 设置按钮的圆角
 
 @param controller 控件
 @param radius 圆角度
 @param width 边宽度
 @param borderColor 边线颜色
 @param can 是否裁剪
 @return 控件
 */
+ (id)chageControllerCircular:(id)controller cornerRadius:(NSInteger)radius borderWidth:(NSInteger)width borderColor:(UIColor *)borderColor masksToBounds:(BOOL)can
{
    CALayer *layer = [controller layer];
    [layer setCornerRadius:radius];
    [layer setBorderWidth:width];
    [layer setBorderColor:[borderColor CGColor]];
    [layer setMasksToBounds:can];
    
    return controller;
}

/**
 选取部分数据变色（label）
 
 @param label label
 @param arrray 变色数组
 @param color 变色颜色
 @return label
 */
+ (id)setSomeOneChangeColor:(UILabel *)label selectArray:(NSArray *)arrray changeColor:(UIColor *)color
{
    if (label.text.length == 0) {
        return 0;
    }
    int i;
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    for (i = 0; i < label.text.length; i++) {
        NSString *str = [label.text substringWithRange:NSMakeRange(i, 1)];
        NSArray *number = arrray;
        if ([number containsObject:str]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(i, 1)];
        }
    }
    label.attributedText = attributeString;
    
    return label;
}

/**
 *  返回字符串所占用的尺寸
 */
+ (CGSize)calculateTextSizeWithText:(NSString *)text sizeWithFont:(NSInteger)font maxWidth:(CGFloat)width
{
    CGFloat textMaxWidth = width;
    CGSize textMaxSize = CGSizeMake(textMaxWidth, MAXFLOAT);
    
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:PFR size:font]} context:nil].size;
    
    return textSize;
}

/**
 利用贝塞尔曲线设置圆角
 
 @param controller 按钮
 @param size 圆角尺寸
 */
+ (void)bezierPathCircularLayerWithController:(UIButton *)controller size:(CGSize)size
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:controller.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft |UIRectCornerTopRight cornerRadii:size];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = controller.bounds;
    shapeLayer.path = bezierPath.CGPath;
    
    controller.layer.mask = shapeLayer;
}

/**
 label首行缩进
 
 @param label label
 @param emptylen 缩进比
 */
+ (void)setLabel:(UILabel *)label content:(NSString *)content indentationFortheFirstLineWith:(CGFloat)emptylen
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = emptylen; //首行缩进
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName:style}];
    
    label.attributedText = str;
}

/**
 字符串加星处理
 
 @param content NSString字符串
 @param findex 第几位开始加星
 @return 返回加星后的字符串
 */
+ (NSString *)encryptionDisplayMessageWith:(NSString *)content withFirstIndex:(NSInteger)findex
{
    if (findex <= 0) {
        findex = 2;
    } else if (findex + findex > content.length) {
        findex --;
    }
    return [NSString stringWithFormat:@"%@***%@",[content substringToIndex:findex],[content substringFromIndex:content.length - findex]];
}
@end
