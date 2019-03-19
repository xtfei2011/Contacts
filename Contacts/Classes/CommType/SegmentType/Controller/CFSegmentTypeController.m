//
//  CFSegmentTypeController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFSegmentTypeController.h"
#import "CFConnectionFirstController.h"
#import "CFConnectionSecondController.h"
#import "CFConnectionThirdController.h"
#import "CFTitleButton.h"

@interface CFSegmentTypeController ()<UIScrollViewDelegate>
/** 当前选中的标题按钮 */
@property (nonatomic ,weak) CFTitleButton *selectedTitleButton;
/** 标题按钮底部的指示器 */
@property (nonatomic ,weak) UIView *indicatorView;
/** UIScrollView */
@property (nonatomic ,weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic ,weak) UIView *titlesView;

@end

@implementation CFSegmentTypeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = CFCommonBgColor;
    
    [self setupChildViewControllers];
    
    [self setupScrollView];
    
    [self setupTitlesView];
    
    [self addChildVcView];
}

- (void)setupChildViewControllers
{
    CFConnectionFirstController *first = [[CFConnectionFirstController alloc] init];
    first.userID = self.user_id;
    [self addChildViewController:first];
    
    CFConnectionSecondController *second = [[CFConnectionSecondController alloc] init];
    second.userID = self.user_id;
    [self addChildViewController:second];
    
    CFConnectionThirdController *third = [[CFConnectionThirdController alloc] init];
    third.userID = self.user_id;
    [self addChildViewController:third];
}

- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = CFCommonBgColor;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;

    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.xtfei_width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupTitlesView
{
    // 标题栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.frame = CGRectMake(0, 64, self.view.xtfei_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 添加标题
    NSArray *titles = @[@"一维人脉", @"二维人脉", @"三维人脉"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titlesView.xtfei_width / count;
    CGFloat titleButtonH = titlesView.xtfei_height;
    for (NSUInteger i = 0; i < count; i++) {
        // 创建
        CFTitleButton *titleButton = [CFTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        
        // 设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        // 设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
    }
    
    // 按钮的选中颜色
    CFTitleButton *firstTitleButton = titlesView.subviews.firstObject;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.xtfei_height = 1;
    indicatorView.xtfei_y = titlesView.xtfei_height - indicatorView.xtfei_height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 立刻根据文字内容计算label的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.xtfei_width = firstTitleButton.titleLabel.xtfei_width;
    indicatorView.xtfei_centerX = firstTitleButton.xtfei_centerX;
    
    // 默认情况 : 选中最前面的标题按钮
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
}

#pragma mark - 监听点击
- (void)titleClick:(CFTitleButton *)titleButton
{
    // 某个标题按钮被重复点击
    if (titleButton == self.selectedTitleButton) return;
    
    // 控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    // 指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.xtfei_width = titleButton.titleLabel.xtfei_width;
        self.indicatorView.xtfei_centerX = titleButton.xtfei_centerX;
    }];
    
    // 让UIScrollView滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.xtfei_width;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - 添加子控制器的view
- (void)addChildVcView
{
    // 子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.xtfei_width;
    
    // 取出子控制器
    UIViewController *childVc = self.childViewControllers[index];
    if ([childVc isViewLoaded]) return;
    
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
}

#pragma mark - <UIScrollViewDelegate>
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}

/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 人为拖拽scrollView产生的滚动动画
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 选中\点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.xtfei_width;
    CFTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleClick:titleButton];
    
    // 添加子控制器的view
    [self addChildVcView];
}

@end
