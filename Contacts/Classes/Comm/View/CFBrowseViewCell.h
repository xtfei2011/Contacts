//
//  CFBrowseViewCell.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/13.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFComm.h"
NS_ASSUME_NONNULL_BEGIN

@interface CFBrowseViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,strong) NSMutableArray<CFComm *> *comm;
@property (nonatomic ,strong) NSString *other_people_id;
@end

NS_ASSUME_NONNULL_END
