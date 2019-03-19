//
//  CFMenuView.h
//  FamousProduct
//
//  Created by 谢腾飞 on 2019/2/21.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger ,CFButtonClickType) {
    
    CFButtonClickTypeNormal = 0,
    CFButtonClickTypeUp = 1,
    CFButtonClickTypeDown = 2,
};

@class CFMenuView;
@protocol CFMenuViewDelegate <NSObject>
/*** 按钮的点击事件 ***/
- (void)initWithMenuView:(CFMenuView *)menuView selectedIndex:(NSInteger)index clickType:(CFButtonClickType)clickType;
@end

@interface CFMenuView : UIView

@property (nonatomic ,assign) id<CFMenuViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
