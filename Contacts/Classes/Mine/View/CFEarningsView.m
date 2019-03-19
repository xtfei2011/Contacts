//
//  CFEarningsView.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFEarningsView.h"
#import "CFDrawingController.h"
#import "CFEarningsController.h"
#import "CFAddBankCardController.h"

@interface CFEarningsView ()

@property (weak, nonatomic) IBOutlet UILabel *totalRevenueLabel;
@property (weak, nonatomic) IBOutlet UILabel *revenueLabel;
@property (weak, nonatomic) IBOutlet UIButton *withdrawalsBtn;

@end

@implementation CFEarningsView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.totalRevenueLabel.layer.masksToBounds = YES;
    self.totalRevenueLabel.layer.cornerRadius = 12.5f;
    
    [TFExtension chageControllerCircular:self.withdrawalsBtn cornerRadius:6 borderWidth:1 borderColor:[UIColor whiteColor] masksToBounds:YES];
}

- (void)setEarnings:(CFEarnings *)earnings
{
    _earnings = earnings;
    
    self.revenueLabel.text = [NSString stringWithFormat:@"¥ %@",earnings.YeMoney];
    self.totalRevenueLabel.text = [NSString stringWithFormat:@"     总收益: %@",earnings.SumSyMoney];
}

- (void)setBankCard:(NSMutableArray<CFBankCard *> *)bankCard
{
    _bankCard = bankCard;
}

- (IBAction)withdrawalsButtonClick:(UIButton *)sender
{
    CFEarningsController *earning = (CFEarningsController *)[sender currentViewController];
    if ([self.earnings.YeMoney isEqualToString:@"0.00"]) {
        [TFProgressHUD showFailure:@"余额不足，无法提现"];
        return;
    } else {
        if (self.bankCard.count > 0) {
            CFDrawingController *drawing = [[CFDrawingController alloc] init];
            drawing.bankCard = self.bankCard;
            drawing.earnings = self.earnings;
            [earning.navigationController pushViewController:drawing animated:YES];
        } else {
            CFAddBankCardController *addBank = [[CFAddBankCardController alloc] init];
            [earning.navigationController pushViewController:addBank animated:YES];
        }
    }
}
@end
