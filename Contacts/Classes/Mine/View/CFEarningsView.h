//
//  CFEarningsView.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFEarnings.h"
#import "CFBankCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFEarningsView : UIView

@property (nonatomic ,strong) CFEarnings *earnings;
@property (nonatomic ,strong) NSMutableArray<CFBankCard *> *bankCard;
@end

NS_ASSUME_NONNULL_END
