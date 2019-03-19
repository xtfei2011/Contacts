//
//  UIBarButtonItem+TFExtension.m
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/21.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "UIBarButtonItem+TFExtension.h"

@implementation UIBarButtonItem (TFExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    UIButton *textBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [textBtn setTitle:title forState:UIControlStateNormal];
    textBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [textBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [textBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [textBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [textBtn sizeToFit];
    textBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    
    return [[UIBarButtonItem alloc] initWithCustomView:textBtn];
}
@end
