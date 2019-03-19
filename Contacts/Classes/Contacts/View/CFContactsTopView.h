//
//  CFContactsTopView.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/9.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFContactsTopView : UIView
/*** 选择地址回调 ***/
@property (nonatomic ,copy) dispatch_block_t clickAddressBlock;

@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@end

NS_ASSUME_NONNULL_END
