//
//  CFEarningsCell.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFEarnings.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFEarningsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,strong) CFEarnDetail *earnDetail;
@end

NS_ASSUME_NONNULL_END
