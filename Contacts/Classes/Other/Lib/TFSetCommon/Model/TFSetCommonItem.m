//
//  TFSetCommonItem.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/10.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "TFSetCommonItem.h"

@implementation TFSetCommonItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    TFSetCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    NSString *icon = nil;
    return [self itemWithTitle:title icon:icon];
}
@end
