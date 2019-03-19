//
//  CFCommViewCell.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFComm.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFCommViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,strong) CFComm *comm;
@end

NS_ASSUME_NONNULL_END
