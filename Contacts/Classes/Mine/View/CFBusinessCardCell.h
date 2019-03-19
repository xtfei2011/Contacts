//
//  CFBusinessCardCell.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/8.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFBusinessCard.h"

NS_ASSUME_NONNULL_BEGIN
@class CFBusinessCardCell;
@protocol CFBusinessCardCellDelegate <NSObject>
@optional
/*** 删除按钮被点击 ***/
- (void)deleteBusinessCardButtonClick:(CFBusinessCardCell *)cell;
@end

@interface CFBusinessCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,strong) CFBusinessCard *businessCard;
@property (nonatomic ,assign) id<CFBusinessCardCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
