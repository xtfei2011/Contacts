//
//  CFRightReusableView.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFRightReusableView.h"

@implementation CFRightReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 15, 3, self.xtfei_height - 20)];
        lineView.backgroundColor = CFColor(23, 181, 104);
        [self addSubview:lineView];
        
        self.headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.xtfei_width - 20, self.xtfei_height - 10)];
        self.headerTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        [self addSubview:self.headerTitle];
    }
    return self;
}

@end
