//
//  CFAddBusinessCardController.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/8.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFBusinessCard.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger ,CFAddBusinessCardType) {
    
    CFAddBusinessCardSaveType = 0,          //保存
    CFAddBusinessCardCompileType = 1,       //编辑
};

@interface CFAddBusinessCardController : UIViewController

/*** 控制器类型 ***/
@property (nonatomic ,assign) CFAddBusinessCardType addBusinessCardType;

@property (nonatomic ,strong) CFBusinessCard *businessCard;

@property (nonatomic ,assign) BOOL isFirst;
@end

NS_ASSUME_NONNULL_END
