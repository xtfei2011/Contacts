//
//  CFChooseLocationCell.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/17.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFAddressItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFChooseLocationCell : UITableViewCell

@property (nonatomic ,strong) CFAddressItem *addressItem;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
