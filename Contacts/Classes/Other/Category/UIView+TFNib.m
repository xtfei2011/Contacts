//
//  UIView+TFNib.m
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "UIView+TFNib.h"
#import "NSObject+TFBundle.h"

@implementation UIView (TFNib)

+ (instancetype)loadFromNib
{
    UIView *view = [[self currentBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    
    return view;
}

- (UIViewController *)currentViewController
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
