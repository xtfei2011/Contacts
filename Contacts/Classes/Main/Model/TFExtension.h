//
//  TFExtension.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/10.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFExtension : NSObject
/**
 设置按钮的圆角
 
 @param controller 控件
 @param radius 圆角度
 @param width 边宽度
 @param borderColor 边线颜色
 @param can 是否裁剪
 @return 控件
 */
+ (id)chageControllerCircular:(id)controller cornerRadius:(NSInteger)radius borderWidth:(NSInteger)width borderColor:(UIColor *)borderColor masksToBounds:(BOOL)can;

/**
 选取部分数据变色（label）
 
 @param label label
 @param arrray 变色数组
 @param color 变色颜色
 @return label
 */
+ (id)setSomeOneChangeColor:(UILabel *)label selectArray:(NSArray *)arrray changeColor:(UIColor *)color;

/**
 *  返回字符串所占用的尺寸
 */
+ (CGSize)calculateTextSizeWithText:(NSString *)text sizeWithFont:(NSInteger)font maxWidth:(CGFloat)width;

/**
 利用贝塞尔曲线设置圆角
 
 @param controller 按钮
 @param size 圆角尺寸
 */
+ (void)bezierPathCircularLayerWithController:(UIButton *)controller size:(CGSize)size;

/**
 label首行缩进
 
 @param label label
 @param emptylen 缩进比
 */
+ (void)setLabel:(UILabel *)label content:(NSString *)content indentationFortheFirstLineWith:(CGFloat)emptylen;

/**
 字符串加星处理
 
 @param content NSString字符串
 @param findex 第几位开始加星
 @return 返回加星后的字符串
 */
+ (NSString *)encryptionDisplayMessageWith:(NSString *)content withFirstIndex:(NSInteger)findex;
@end

NS_ASSUME_NONNULL_END
