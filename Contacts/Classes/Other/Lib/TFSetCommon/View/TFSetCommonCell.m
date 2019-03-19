//
//  TFSetCommonCell.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/10.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "TFSetCommonCell.h"
#import "TFSetCommonItem.h"
#import "TFSetCommonArrowItem.h"
#import "TFSetCommonSwitchItem.h"
#import "TFSetCommonLabelItem.h"
#import "TFSetBadgeView.h"
#import "TFSetCommonClearItem.h"
#import "TFSetCommonIconArrowItem.h"
#import "TFIconArrowView.h"

@interface TFSetCommonCell ()
/*** 箭头 ***/
@property (nonatomic ,strong) UIImageView *rightArrow;
/*** 开关 ***/
@property (nonatomic ,strong) UISwitch *rightSwitch;
/*** 文字 ***/
@property (nonatomic ,strong) UILabel *rightLabel;
/*** 提示数 ***/
@property (nonatomic ,strong) TFSetBadgeView *bageView;
/*** 文字 + 箭头 ***/
@property (nonatomic ,strong) TFIconArrowView *iconArrowView;
@end

@implementation TFSetCommonCell

#pragma mark - 懒加载右边的view
- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        self.rightSwitch = [[UISwitch alloc] init];
        self.rightSwitch.onTintColor = CFColor(249, 60, 94);
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textColor = [UIColor grayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:14];
    }
    return _rightLabel;
}

- (TFSetBadgeView *)bageView
{
    if (_bageView == nil) {
        self.bageView = [[TFSetBadgeView alloc] init];
    }
    return _bageView;
}

- (TFIconArrowView *)iconArrowView
{
    if (_iconArrowView == nil) {
        self.iconArrowView = [[TFIconArrowView alloc] init];
    }
    return _iconArrowView;
}

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"common";
    TFSetCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TFSetCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.textLabel.font = CFPromptTitleFont;
        self.detailTextLabel.font = CFCommodityTitleFont;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;
}

#pragma mark - 调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailTextLabel.xtfei_x = CGRectGetMaxX(self.textLabel.frame) + 5;
}

#pragma mark - setter
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows
{
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    if (rows == 1) {
        bgView.image = [UIImage resizedImage:@"common_card_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_background_highlighted"];
    } else if (indexPath.row == 0) { // 首行
        bgView.image = [UIImage resizedImage:@"common_card_top_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == rows - 1) { // 末行
        bgView.image = [UIImage resizedImage:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted"];
    } else { // 中间
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
    }
}

- (void)setItem:(TFSetCommonItem *)item
{
    _item = item;
    
    /*** 设置基本数据 ***/
    self.imageView.image = [UIImage imageWithName:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    /*** 设置右边的内容 ***/
    if (item.badgeValue) {
        
        self.bageView.badgeValue = item.badgeValue;
        self.accessoryView = self.bageView;
        
    } else if ([item isKindOfClass:[TFSetCommonArrowItem class]]) {
        
        self.accessoryView = self.rightArrow;
        
    } else if ([item isKindOfClass:[TFSetCommonSwitchItem class]]) {
        
        self.accessoryView = self.rightSwitch;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else if ([item isKindOfClass:[TFSetCommonLabelItem class]]) {
        
        TFSetCommonLabelItem *labelItem = (TFSetCommonLabelItem *)item;
        self.rightLabel.text = labelItem.text;
        /*** 根据文字计算尺寸 ***/
        self.rightLabel.xtfei_size = [labelItem.text sizeWithFont:self.rightLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.accessoryView = self.rightLabel;
        
    } else if ([item isKindOfClass:[TFSetCommonIconArrowItem class]]) {
        TFSetCommonIconArrowItem *iconArrowItem = (TFSetCommonIconArrowItem *)item;
        self.iconArrowView.text = iconArrowItem.text;
        self.accessoryView = self.iconArrowView;
        
    } else if ([item isKindOfClass:[TFSetCommonClearItem class]]) {
        [self clearItem:item];
    } else {
        self.accessoryView = nil;
    }
}

- (void)clearItem:(TFSetCommonItem *)item
{
    __weak typeof(self) weakSelf = self;
    
    // 在子线程计算缓存大小
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 获得缓存文件夹路径
        unsigned long long size = 0;
        size += [SDImageCache sharedImageCache].getSize;
        
        // 如果cell已经销毁了, 就直接返回
        if (weakSelf == nil) return;
        
        NSString *sizeText = nil;
        if (size >= pow(10, 9)) { // size >= 1GB
            sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
        } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
            sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
        } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
            sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
        } else { // 1KB > size
            sizeText = [NSString stringWithFormat:@"0B"];
        }
        // 生成文字
        NSString *text = [NSString stringWithFormat:@"%@", sizeText];
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.rightLabel.text = text;
            /*** 根据文字计算尺寸 ***/
            self.rightLabel.xtfei_size = [text sizeWithFont:self.rightLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            self.accessoryView = self.rightLabel;
            
            // 添加手势监听器
            [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clearCache)]];
            
            // 恢复点击事件
            weakSelf.userInteractionEnabled = YES;
        });
    });
}

/**
 *  清除缓存
 */
- (void)clearCache
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.labelText = @"正在清理中";
    hud.mode = MBProgressHUDModeDeterminate;
    [CFkeyWindowView addSubview:hud];
    
    [hud showAnimated:YES whileExecutingBlock:^{
        
        while (hud.progress < 1.0) {
            hud.progress += 0.01;
            [NSThread sleepForTimeInterval:0.02];
        }
        hud.labelText = @"清理完成";
    } completionBlock:^{
        
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.rightLabel.text = @"0B";
                    /*** 根据文字计算尺寸 ***/
                    self.rightLabel.xtfei_size = [@"0B" sizeWithFont:self.rightLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                });
            });
        }];
    }];
}
@end
