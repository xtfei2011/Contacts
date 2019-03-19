//
//  NSString+TFExtension.m
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NSString+TFExtension.h"

@implementation NSString (TFExtension)

/*** 手机号码验证 ***/
- (BOOL)isValidateMobile
{
    //手机号以13, 15, 17, 18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

/*** 身份证码验证 ***/
+ (BOOL)isIdentityCard:(NSString *)IDCardNumber
{
    if (IDCardNumber.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
}

/*** 银行卡验证 ***/
+ (BOOL)isBankCard:(NSString *)cardNumber
{
    if(cardNumber.length == 0) {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++) {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c)) {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--) {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo) {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        } else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

/*** 邮箱验证 ***/
+ (BOOL)isEmailAdress:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

/*** 判断字符串是否有值 ***/
+ (BOOL)isStringNullValidate:(id)string
{
    NSString *str = [NSString stringWithFormat:@"%@",string];
    if (str.length == 0 || [str isEqualToString:@""] || str == nil || [str isEqualToString:@"(null)"]) {
        return YES;
    } else {
        return NO;
    }
}

/*** 返回字符串所占用的尺寸 ***/
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    return [self sizeWithFont:font constrainedToSize:maxSize];
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

/*** 清理缓存 ***/
- (unsigned long long)fileSize
{
    unsigned long long size = 0;
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (!exists) return size;
    
    if (isDirectory) {
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
    } else {
        size = [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
    return size;
}

- (CGRect)textRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}

//格林威志转 yyyy-MM-dd HH:mm:ss
- (NSString *)timeToyyyyMMddHHmmssString
{
    // 时间字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"; // 3.利用时间格式化对象让字符串转换成时间 (自动转换0时区/东加西减)
    NSDate *date = [formatter dateFromString:self];
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    formatter1.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"yyyyMMddHHmmss"];
    NSString* dateString = [formatter1 stringFromDate:date];
    return dateString;
}
@end
