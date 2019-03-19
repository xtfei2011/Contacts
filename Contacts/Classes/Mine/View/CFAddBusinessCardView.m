//
//  CFAddBusinessCardView.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/8.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFAddBusinessCardView.h"
#import "CFAddBusinessCardController.h"
#import "CFFindController.h"
#import "CFPositionViewController.h"

@implementation CFAddBusinessCardView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

/*** 选择地址 ***/
- (IBAction)addressButtonClick:(UIButton *)sender
{
    CFAddBusinessCardController *addBusiness = (CFAddBusinessCardController *)[sender currentViewController];
    if (sender.tag == 1007) {
        CFPositionViewController *position = [[CFPositionViewController alloc] init];
        position.changePositionBlock = ^(NSString *position_id, NSString *position) {
            
            CFLog(@"--->%@",position);
            self.jobsField.text = position;
            self.position_id = position_id;
        };
        [addBusiness.navigationController pushViewController:position animated:YES];
    } else if (sender.tag == 1008) {
        
        CFFindController *find = [[CFFindController alloc] init];
        find.navigationItem.title = @"行业范围选择";
        find.changeIndustryBlock = ^(NSString *industry_id, NSString *industry) {
            self.industryField.text = industry;
            self.industry_id = industry_id;
        };
        find.from = sender.tag;
        [addBusiness.navigationController pushViewController:find animated:YES];
    } else {
        !_selectAddressBlock ? : _selectAddressBlock();
    }
}
@end
