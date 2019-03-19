//
//  TFSetCommonCell.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/10.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TFSetCommonItem;
@interface TFSetCommonCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;

/** cell对应的item数据 */
@property (nonatomic ,strong) TFSetCommonItem *item;
@end

NS_ASSUME_NONNULL_END
