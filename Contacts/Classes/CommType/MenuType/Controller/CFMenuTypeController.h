//
//  CFMenuTypeController.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFCommViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFMenuTypeController : CFCommViewController

/*** 分类行业ID ***/
@property (nonatomic ,strong) NSString *industry_id;
/*** 查看浏览人列表ID ***/
@property (nonatomic ,strong) NSString *browse_id;
/*** 接口 ***/
@property (nonatomic ,strong) NSString *interface;
@end

NS_ASSUME_NONNULL_END
