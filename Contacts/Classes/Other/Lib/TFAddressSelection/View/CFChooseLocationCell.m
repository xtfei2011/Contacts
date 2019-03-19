//
//  CFChooseLocationCell.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/17.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFChooseLocationCell.h"

@interface CFChooseLocationCell ()

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkedView;
@end

@implementation CFChooseLocationCell
static NSString *const ChooseLocationID = @"CFChooseLocationCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CFChooseLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseLocationID];
    if (!cell) {
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"CFChooseLocationCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setAddressItem:(CFAddressItem *)addressItem
{
    _addressItem = addressItem;
    
    _addressLabel.text = addressItem.name;
    _addressLabel.textColor = addressItem.isSelected ? CFColor(23, 181, 104) : [UIColor blackColor];
    _checkedView.hidden = !addressItem.isSelected;
}
@end
