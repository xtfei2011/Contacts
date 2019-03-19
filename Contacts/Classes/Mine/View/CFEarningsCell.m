//
//  CFEarningsCell.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFEarningsCell.h"

@interface CFEarningsCell () 
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *earnLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@end

@implementation CFEarningsCell

static NSString *const cellID = @"CFEarningsCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CFEarningsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CFEarningsCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setEarnDetail:(CFEarnDetail *)earnDetail
{
    _earnDetail = earnDetail;
    
    self.timeLabel.text = [earnDetail.INCOME_TIME timeToyyyyMMddHHmmssString];
    
    if ([earnDetail.INCOME_TITLE isEqualToString:@"1"]) {
        self.titleLabel.text = @"一维人脉";
    } else if ([earnDetail.INCOME_TITLE isEqualToString:@"2"]) {
        self.titleLabel.text = @"二维人脉";
    } else if ([earnDetail.INCOME_TITLE isEqualToString:@"3"]) {
        self.titleLabel.text = @"三维人脉";
    } else {
        self.titleLabel.text = @"提现";
    }
    
    if ([earnDetail.INCOME_STATU isEqualToString:@"1"]) {
        self.earnLabel.text = [NSString stringWithFormat:@"+ %@",earnDetail.INCOME_MONEY];
    } else {
        self.earnLabel.text = [NSString stringWithFormat:@"- %@",earnDetail.INCOME_MONEY];
    }
    
    self.balanceLabel.text = earnDetail.INCOME_YE_ALL_MONEY;
}
@end
