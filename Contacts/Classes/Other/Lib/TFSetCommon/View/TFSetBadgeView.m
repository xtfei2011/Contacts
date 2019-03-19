//
//  TFSetBadgeView.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/10.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "TFSetBadgeView.h"

@implementation TFSetBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage resizedImage:@"main_badge"] forState:UIControlStateNormal];
        self.xtfei_height = self.currentBackgroundImage.size.height;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    CGSize titleSize = [badgeValue sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    if (titleSize.width < self.currentBackgroundImage.size.width) {
        self.xtfei_width = self.currentBackgroundImage.size.width;
    } else {
        self.xtfei_width = titleSize.width + 10;
    }
}

@end
