//
//  CFLeftTableViewCell.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFLeftCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFLeftTableViewCell : UITableViewCell

@property (nonatomic ,strong) UIView *baseView;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) CFLeftCategory *leftCategory;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
