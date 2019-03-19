
//
//  UIButton+TFExtension.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/11.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "UIButton+TFExtension.h"

@implementation UIButton (TFExtension)

+ (UIButton *)createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button sizeToFit];
    
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.xtfei_width - button.xtfei_width + button.titleLabel.xtfei_width, 0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -button.titleLabel.xtfei_width - button.xtfei_width + button.imageView.xtfei_width);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)setButtonImageTitleStyle:(TFButtonImageTitleStyle)style padding:(CGFloat)padding
{
    if (self.imageView.image != nil && self.titleLabel.text != nil) {
        
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        
        CGRect imageRect = self.imageView.frame;
        CGRect titleRect = self.titleLabel.frame;
        
        switch (style) {
            case TFButtonImageTitleStyleLeft: //图片在左，文字在右
                if (padding) {
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, padding/2, 0, -padding/2);
                    self.imageEdgeInsets = UIEdgeInsetsMake(0, -padding/2, 0, padding/2);
                }
                break;
                
            case TFButtonImageTitleStyleRight: //图片在右，文字在左
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageRect.size.width + padding/2), 0, (imageRect.size.width + padding/2));
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (titleRect.size.width+ padding/2), 0, -(titleRect.size.width + padding/2));
            }
                break;
            default:
                break;
        }
    } else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
@end
