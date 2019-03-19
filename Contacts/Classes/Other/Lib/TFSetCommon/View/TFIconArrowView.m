//
//  TFIconArrowView.m
//  FamousProduct
//
//  Created by 谢腾飞 on 2019/1/31.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "TFIconArrowView.h"

@interface TFIconArrowView ()

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIImageView *iconView;
@end

@implementation TFIconArrowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, CFMainScreen_Width * 0.5, 49);
        
        self.iconView = [[UIImageView alloc] init];
        self.iconView.image = [UIImage imageWithName:@"common_icon_arrow"];
        [self addSubview:self.iconView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = [UIColor grayColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imgW = self.iconView.image.size.width;
    CGFloat imgH = self.iconView.image.size.height;
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width - imgW * 1.5, self.frame.size.height);
    self.iconView.frame = CGRectMake(self.frame.size.width - imgW,(self.frame.size.height - imgH) / 2, imgW, imgH);
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.titleLabel.text = text;
}
@end
