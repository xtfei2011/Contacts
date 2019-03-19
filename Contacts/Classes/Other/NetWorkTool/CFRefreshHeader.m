//
//  CFRefreshHeader.m
//  FamousProduct
//
//  Created by 谢腾飞 on 2019/2/21.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFRefreshHeader.h"

@implementation CFRefreshHeader

/*** 初始化 ***/
- (void)prepare
{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor grayColor];
    self.stateLabel.textColor = [UIColor grayColor];
    self.stateLabel.font = self.lastUpdatedTimeLabel.font = CFCommentTitleFont;
}
@end
