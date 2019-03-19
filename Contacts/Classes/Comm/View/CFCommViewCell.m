//
//  CFCommViewCell.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFCommViewCell.h"

@interface CFCommViewCell ()
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet UILabel *workLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;
@property (weak, nonatomic) IBOutlet UILabel *favourLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;

@end

@implementation CFCommViewCell

static NSString *const cellID = @"CFCommViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CFCommViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"CFCommViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [TFExtension chageControllerCircular:self.baseView cornerRadius:6 borderWidth:0.5 borderColor:[UIColor whiteColor] masksToBounds:YES];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}

- (void)setComm:(CFComm *)comm
{
    _comm = comm;
    
    [self.headerView setImageWithURL:[NSURL URLWithString:comm.USER_PHOTO] placeHoldImage:[UIImage imageNamed:@"cun_station_default_avatar"] isCircle:YES];
    
    self.nameLabel.text = comm.USER_NAME;
    self.postLabel.text = comm.STATION_NAME;
    self.workLabel.text = comm.UNIT_NAME;
    
    if ([[CFUSER_DEFAULTS objectForKey:@"USER_STATU"] isEqualToString:@"3"]) {
        self.phoneLabel.text = [NSString stringWithFormat:@"联系电话: %@",comm.USER_PHONE];
    } else {
        NSString *phoneStr = [TFExtension encryptionDisplayMessageWith:comm.USER_PHONE withFirstIndex:3];
        self.phoneLabel.text = [NSString stringWithFormat:@"联系电话: %@",phoneStr];
    }
    
    self.checkLabel.text = comm.USER_BROWSE_NUMBER;
    self.favourLabel.text = comm.USER_COLLECTION_NUMBER;
    self.praiseLabel.text = comm.USER_LIKE_NUMBER;
}
@end
