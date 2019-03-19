//
//  CFTitleButton.m
//  FamousProduct
//
//  Created by 谢腾飞 on 2019/1/28.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFTitleButton.h"

@implementation CFTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:CFColor(23, 181, 104) forState:UIControlStateSelected];
        self.titleLabel.font = CFCommentTitleFont;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setHighlighted:(BOOL)highlighted{}
@end
