//
//  CFAboutViewCell.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/13.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFAboutViewCell.h"

#define titles  @[@"简介", @"版本更新", @"官方电话", @"官方邮箱", @"官方微博", @"官方公众号"]
#define subtitles  @[@"", @"", @"027-59881994", @"rmzj@malisten.com", @"@三维人脉", @"三维人脉"]
@interface CFAboutViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@end

@implementation CFAboutViewCell
static NSString *const cellID = @"CFAboutViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CFAboutViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CFAboutViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    
    self.titleLabel.text = titles[index];
    self.subtitleLabel.text = subtitles[index];
    
    if (index == 4) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
