//
//  CFRightCollectionViewCell.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFRightCollectionViewCell.h"

@interface CFRightCollectionViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation CFRightCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.xtfei_width, self.xtfei_height)];
        self.titleLabel.font = CFCommentTitleFont;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setRightCategory:(CFRightCategory *)rightCategory
{
    _rightCategory = rightCategory;
    
    self.titleLabel.text = rightCategory.TRADE_NAME ? rightCategory.TRADE_NAME : rightCategory.STATION_NAME;
}

@end
