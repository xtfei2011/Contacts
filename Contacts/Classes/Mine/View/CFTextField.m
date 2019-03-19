//
//  CFTextField.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/8.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFTextField.h"
#import "UITextField+TFExtension.h"

@implementation CFTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 设置光标颜色
    self.tintColor = CFColor(23, 181, 104);
    // 设置默认的占位文字颜色
    self.placeholderColor = [UIColor lightGrayColor];
}

/**
 *  调用时刻 : 成为第一响应者(开始编辑\弹出键盘\获得焦点)
 */
- (BOOL)becomeFirstResponder
{
    self.placeholderColor = [UIColor grayColor];
    return [super becomeFirstResponder];
}

/**
 *  调用时刻 : 不做第一响应者(结束编辑\退出键盘\失去焦点)
 */
- (BOOL)resignFirstResponder
{
    self.placeholderColor = [UIColor lightGrayColor];
    return [super resignFirstResponder];
}

@end
