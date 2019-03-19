//
//  CFLeftTableViewCell.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFLeftTableViewCell.h"

@interface CFLeftTableViewCell ()
@property (nonatomic ,strong) UIView *lineView;
@end

@implementation CFLeftTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CFLeftTableViewCell";
    CFLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CFLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    self.baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, 44)];
    self.baseView.backgroundColor = CFCommonBgColor;
    [self.contentView addSubview:self.baseView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, _baseView.xtfei_width - 3, _baseView.xtfei_height)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.font = CFCommentTitleFont;
    self.titleLabel.textColor = CFColor(82, 86, 101);
    self.titleLabel.highlightedTextColor = CFColor(23, 181, 104);
    [self.baseView addSubview:self.titleLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 44)];
    self.lineView.backgroundColor = CFColor(23, 181, 104);
    [self.baseView addSubview:self.lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.baseView.backgroundColor = selected ? [UIColor whiteColor] : CFCommonBgColor;
    
    self.highlighted = selected;
    self.titleLabel.highlighted = selected;
    self.lineView.backgroundColor = selected ? CFColor(23, 181, 104) : CFCommonBgColor;
}

- (void)setLeftCategory:(CFLeftCategory *)leftCategory
{
    _leftCategory = leftCategory;
    
    self.titleLabel.text = leftCategory.TRADE_NAME ? leftCategory.TRADE_NAME : leftCategory.STATION_NAME;
}

@end
