//
//  CFAddBusinessCardView.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/8.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFPlaceholderTextView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CFAddBusinessCardView : UIView
/*** 选择地址回调 ***/
@property (nonatomic ,copy) dispatch_block_t selectAddressBlock;

@property (weak, nonatomic) IBOutlet UITextField *companyField;
@property (weak, nonatomic) IBOutlet UITextField *jobsField;
@property (weak, nonatomic) IBOutlet UITextField *industryField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet CFPlaceholderTextView *detailTextView;

@property (nonatomic ,strong) NSString *industry_id;
@property (nonatomic ,strong) NSString *position_id;
@end

NS_ASSUME_NONNULL_END
