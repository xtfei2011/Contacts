//
//  CFAccount.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/21.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFAccount.h"

@implementation CFAccount

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.USER_ID forKey:@"USER_ID"];
    [encoder encodeObject:self.USER_NICKNAME forKey:@"USER_NICKNAME"];
    [encoder encodeObject:self.USER_PHONE forKey:@"USER_PHONE"];
    [encoder encodeObject:self.USER_PHOTO forKey:@"USER_PHOTO"];
    [encoder encodeObject:self.USER_SEX forKey:@"USER_SEX"];
    [encoder encodeObject:self.USER_QQ forKey:@"USER_QQ"];
    [encoder encodeObject:self.USER_NAME forKey:@"USER_NAME"];
    [encoder encodeObject:self.USER_WECHAT forKey:@"USER_WECHAT"];
    [encoder encodeObject:self.USER_EMAIL forKey:@"USER_EMAIL"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        self.USER_ID = [decoder decodeObjectForKey:@"USER_ID"];
        self.USER_NICKNAME = [decoder decodeObjectForKey:@"USER_NICKNAME"];
        self.USER_PHONE = [decoder decodeObjectForKey:@"USER_PHONE"];
        self.USER_PHOTO = [decoder decodeObjectForKey:@"USER_PHOTO"];
        self.USER_SEX = [decoder decodeObjectForKey:@"USER_SEX"];
        self.USER_QQ = [decoder decodeObjectForKey:@"USER_QQ"];
        self.USER_NAME = [decoder decodeObjectForKey:@"USER_NAME"];
        self.USER_WECHAT = [decoder decodeObjectForKey:@"USER_WECHAT"];
        self.USER_EMAIL = [decoder decodeObjectForKey:@"USER_EMAIL"];
    }
    return self;
}
@end
