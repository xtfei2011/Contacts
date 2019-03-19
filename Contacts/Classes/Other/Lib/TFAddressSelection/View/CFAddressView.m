//
//  CFAddressView.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/17.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFAddressView.h"

@interface CFAddressView ()
@property (nonatomic ,strong) NSMutableArray *btnArray;
@end

@implementation CFAddressView

- (NSMutableArray *)btnArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [array addObject:view];
        }
    }
    _btnArray = array;
    
    return _btnArray;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (NSInteger i = 0; i < self.btnArray.count; i++) {
        UIView *view = self.btnArray[i];
        if (i == 0) {
            view.xtfei_x = CellMargin;
        }
        if (i > 0) {
            UIView *preView = self.btnArray[i - 1];
            view.xtfei_x = CellMargin + preView.xtfei_right;
        }
    }
}
@end
