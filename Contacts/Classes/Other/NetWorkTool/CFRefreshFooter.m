//
//  CFRefreshFooter.m
//  FamousProduct
//
//  Created by 谢腾飞 on 2019/2/21.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFRefreshFooter.h"

@implementation CFRefreshFooter

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor grayColor];
    self.stateLabel.font = CFCommentTitleFont;
    
    [self setTitle:@"--- 没有更多啦 ---" forState:MJRefreshStateNoMoreData];
}

@end
