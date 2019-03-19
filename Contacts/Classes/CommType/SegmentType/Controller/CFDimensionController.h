//
//  CFDimensionController.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFCommViewController.h"
#import "CFDimension.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFDimensionController : CFCommViewController

- (CFDimensionType)type;
@property (nonatomic ,strong) NSString *user_id;
@end

NS_ASSUME_NONNULL_END
