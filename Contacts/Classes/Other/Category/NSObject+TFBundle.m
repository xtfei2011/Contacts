//
//  NSObject+TFBundle.m
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NSObject+TFBundle.h"

@implementation NSObject (TFBundle)

+ (NSBundle *)currentBundle
{
    NSBundle *bundle = [NSBundle bundleForClass:self];
    
    return bundle;
}

@end
