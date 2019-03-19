//
//  NSString+TFExtension.h
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+TFExtension.h"

@interface NSString (TFExtension)
/**
 *  手机号码验证
 */
- (BOOL)isValidateMobile;

/**
 *  身份证验证
 */
+ (BOOL)isIdentityCard:(NSString *)IDCardNumber;

/**
 *  银行卡验证
 */
+ (BOOL)isBankCard:(NSString *)cardNumber;

/**
 *  邮箱验证
 */
+ (BOOL)isEmailAdress:(NSString *)Email;

/**
 *  判断字符串是否有值
 */
+ (BOOL)isStringNullValidate:(id)string;

/**
 *  返回字符串所占用的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 *  清理缓存
 */
- (unsigned long long)fileSize;

- (CGRect)textRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes;

//格林威志转 yyyy-MM-dd HH:mm:ss
- (NSString *)timeToyyyyMMddHHmmssString;
@end
