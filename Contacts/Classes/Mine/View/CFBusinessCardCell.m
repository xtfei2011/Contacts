//
//  CFBusinessCardCell.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/8.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFBusinessCardCell.h"
#import "CFAddBusinessCardController.h"
#import "CFBusinessCardController.h"

@interface CFBusinessCardCell ()
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *industryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailedAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *editorBtn;

@end

@implementation CFBusinessCardCell
static NSString *const CellID = @"CFBusinessCardCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CFBusinessCardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"CFBusinessCardCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [TFExtension chageControllerCircular:self.deleteBtn cornerRadius:3 borderWidth:1 borderColor:CFColor(23, 181, 104) masksToBounds:YES];
    
    [TFExtension chageControllerCircular:self.editorBtn cornerRadius:3 borderWidth:1 borderColor:CFColor(23, 181, 104) masksToBounds:YES];
}

- (IBAction)businessCard:(UIButton *)sender
{
    CFLog(@"--->%ld",sender.tag);
    if (sender.tag == 1005) {
        [self deleteBusinessCard];
    } else if (sender.tag == 1006) {
        CFBusinessCardController *business = (CFBusinessCardController *)[sender currentViewController];
        CFAddBusinessCardController *businessCard = [[CFAddBusinessCardController alloc] init];
        businessCard.addBusinessCardType = CFAddBusinessCardCompileType;
        businessCard.businessCard = self.businessCard;
        [business.navigationController pushViewController:businessCard animated:YES];
    }
}

- (void)setBusinessCard:(CFBusinessCard *)businessCard
{
    _businessCard = businessCard;
    
    self.positionLabel.text = businessCard.STATION_NAME;
    self.companyLabel.text = businessCard.UNIT_NAME;
    self.industryLabel.text = businessCard.TRADE_NAME;
    self.addressLabel.text = businessCard.UNIT_CONTACT_ADDRESS;
    self.detailedAddressLabel.text = businessCard.UNIT_DETAILED_ADDRESS;
}

- (void)deleteBusinessCard
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteBusinessCardButtonClick:)]) {
        [self.delegate deleteBusinessCardButtonClick:self];
    }
}
@end
