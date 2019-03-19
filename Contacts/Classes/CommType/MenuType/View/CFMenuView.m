//
//  CFMenuView.m
//  FamousProduct
//
//  Created by 谢腾飞 on 2019/2/21.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFMenuView.h"
#import "UIButton+TFExtension.h"
#import <Masonry.h>
#import <objc/runtime.h>

@implementation CFMenuView
static char * const btnKey = "btnKey";

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    [self addSubview:mainView];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.right.top.equalTo(self);
    }];
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = CFGrayColor(222);
    [self addSubview:topLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(mainView);
        make.top.mas_equalTo(mainView.mas_bottom);
    }];
    
    NSArray *titleArr = @[@"浏览量",@"收藏量",@"点赞量"];
    
    for (int i = 0; i < titleArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainView addSubview:button];
        button.tag = 100 + i;
        button.titleLabel.font = CFCommentTitleFont;
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:CFColor(23, 181, 104) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"icon_search_sort_desc"] forState:UIControlStateNormal];
        [button setButtonImageTitleStyle:TFButtonImageTitleStyleRight padding:48];
        
        objc_setAssociatedObject(button, btnKey, @"1", OBJC_ASSOCIATION_ASSIGN);
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(mainView).offset(self.xtfei_width / titleArr.count * i);
            make.top.bottom.equalTo(mainView);
            make.width.mas_equalTo(self.xtfei_width / titleArr.count);
        }];
        
        if (i == 0) {
            button.selected = YES;
        }
    }
}

- (void)selectClick:(UIButton *)sender
{
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [self viewWithTag:i + 100];
        button.selected = NO;
    }
    sender.selected = YES;
    
    CFButtonClickType type = CFButtonClickTypeNormal;
    
    NSString *flag = objc_getAssociatedObject(sender, btnKey);
    
    if ([flag isEqualToString:@"1"]) {
        [sender setImage:[UIImage imageNamed:@"icon_search_sort_asc"] forState:UIControlStateNormal];
        objc_setAssociatedObject(sender, btnKey, @"2", OBJC_ASSOCIATION_ASSIGN);
        type = CFButtonClickTypeUp;
        
    } else if ([flag isEqualToString:@"2"]) {
        [sender setImage:[UIImage imageNamed:@"icon_search_sort_desc"] forState:UIControlStateNormal];
        objc_setAssociatedObject(sender, btnKey, @"1", OBJC_ASSOCIATION_ASSIGN);
        type = CFButtonClickTypeDown;
    }
    
    if ([self.delegate respondsToSelector:@selector(initWithMenuView:selectedIndex:clickType:)]) {
        [self.delegate initWithMenuView:self selectedIndex:sender.tag clickType:type];
    }
}

@end
