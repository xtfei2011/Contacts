//
//  CFChooseLocationView.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/17.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFChooseLocationView.h"
#import "CFAddressView.h"
#import "CFChooseLocationCell.h"
#import "CFCitiesDataTool.h"

static CGFloat const TopView_H = 40;

@interface CFChooseLocationView ()<UITableViewDataSource ,UITableViewDelegate ,UIScrollViewDelegate>

@property (nonatomic ,weak) CFAddressView *topTabbar;
@property (nonatomic ,weak) UIScrollView *contentView;
@property (nonatomic ,weak) UIView *underLine;
@property (nonatomic ,strong) NSArray *dataSouce;
@property (nonatomic ,strong) NSArray *cityDataSouce;
@property (nonatomic ,strong) NSArray *districtDataSouce;
@property (nonatomic ,strong) NSMutableArray *tableViews;
@property (nonatomic ,strong) NSMutableArray *topTabbarItems;
@property (nonatomic ,weak) UIButton *selectedBtn;

@end

float lastContentOffset; /*** 记录 ScrollView 的 Y 轴位置 ***/

@implementation CFChooseLocationView
#pragma mark ===== 懒加载
- (UIView *)separateLine
{
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.xtfei_width, 1 / [UIScreen mainScreen].scale)];
    separateLine.backgroundColor = CFGrayColor(222);
    return separateLine;
}

- (NSMutableArray *)tableViews
{
    if (_tableViews == nil) {
        _tableViews = [NSMutableArray array];
    }
    return _tableViews;
}

- (NSMutableArray *)topTabbarItems
{
    if (_topTabbarItems == nil) {
        _topTabbarItems = [NSMutableArray array];
    }
    return _topTabbarItems;
}

//省级别数据源
- (NSArray *)dataSouce
{
    if (_dataSouce == nil) {
        _dataSouce = [[CFCitiesDataTool sharedManager] queryAllProvincialLevel];
    }
    return _dataSouce;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeChooseLocationView];
    }
    return self;
}

- (void)initializeChooseLocationView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.xtfei_width, TopView_H)];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"您的位置";
    [titleLabel sizeToFit];
    titleLabel.xtfei_centerY = topView.xtfei_height * 0.5;
    titleLabel.xtfei_centerX = topView.xtfei_width * 0.5;
    [topView addSubview:titleLabel];
    
    UIView *separateLine = [self separateLine];
    separateLine.xtfei_y = topView.xtfei_height - separateLine.xtfei_height;
    [topView addSubview:separateLine];
    
    CFAddressView *topTabbar = [[CFAddressView alloc] initWithFrame:CGRectMake(0, topView.xtfei_height, self.xtfei_width, TopView_H)];
    topTabbar.backgroundColor = [UIColor whiteColor];
    _topTabbar = topTabbar;
    [self addTopBarItem];
    [self addSubview:topTabbar];
    
    UIView *separateLine1 = [self separateLine];
    separateLine1.xtfei_y = topTabbar.xtfei_height - separateLine.xtfei_height;
    [_topTabbar layoutIfNeeded];
    [topTabbar addSubview:separateLine1];
    
    UIView *underLine = [[UIView alloc] initWithFrame:CGRectZero];
    underLine.backgroundColor = CFColor(23, 181, 104);
    underLine.xtfei_height = 2.0f;
    _underLine = underLine;
    
    UIButton *btn = self.topTabbarItems.lastObject;
    [self changeUnderLineFrame:btn];
    underLine.xtfei_y = separateLine1.xtfei_y - underLine.xtfei_height;
    [topTabbar addSubview:underLine];
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = CGRectMake(0, CGRectGetMaxY(topTabbar.frame), self.xtfei_width, self.xtfei_height - TopView_H * 2);
    contentView.contentSize = CGSizeMake(CFMainScreen_Width, 0);
    contentView.bounces = NO;
    contentView.pagingEnabled = YES;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.delegate = self;
    _contentView = contentView;
    
    [self addSubview:contentView];
    
    [self setTableView];
}

#pragma mark - TableViewDatasouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.tableViews indexOfObject:tableView] == 0) {
        return self.dataSouce.count;
    } else if ([self.tableViews indexOfObject:tableView] == 1) {
        return self.cityDataSouce.count;
    } else if ([self.tableViews indexOfObject:tableView] == 2) {
        return self.districtDataSouce.count;
    }
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFChooseLocationCell *cell = [CFChooseLocationCell cellWithTableView:tableView];
    CFAddressItem *addressItem;

    if ([self.tableViews indexOfObject:tableView] == 0) {
        addressItem = self.dataSouce[indexPath.row];

    } else if ([self.tableViews indexOfObject:tableView] == 1) {
        addressItem = self.cityDataSouce[indexPath.row];

    } else if ([self.tableViews indexOfObject:tableView] == 2) {
        addressItem = self.districtDataSouce[indexPath.row];
    }
    cell.addressItem = addressItem;
    return cell;
}

#pragma mark - TableViewDelegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableViews indexOfObject:tableView] == 0) {
        
        CFAddressItem *provinceItem = self.dataSouce[indexPath.row];
        self.cityDataSouce = [[CFCitiesDataTool sharedManager] queryRecordWithProvincial:[provinceItem.code substringWithRange:(NSRange){0 ,2}]];
        if (self.cityDataSouce.count == 0) {
            for (int i = 0; i < self.tableViews.count && self.tableViews.count != 1; i++) {
                [self removeLastItem];
            }
            [self setUpAddress:provinceItem.name];
            return indexPath;
        }
        NSIndexPath *indexPath0 = [tableView indexPathForSelectedRow];
        if ([indexPath0 compare:indexPath] != NSOrderedSame && indexPath0) {
            
            for (int i = 0; i < self.tableViews.count && self.tableViews.count != 1; i++) {
                [self removeLastItem];
            }
            [self addTopBarItem];
            [self setTableView];
            [self scrollToNextItem:provinceItem.name];
            return indexPath;
            
        } else if ([indexPath0 compare:indexPath] == NSOrderedSame && indexPath0) {
            
            for (int i = 0; i < self.tableViews.count && self.tableViews.count != 1; i++) {
                [self removeLastItem];
            }
            [self addTopBarItem];
            [self setTableView];
            [self scrollToNextItem:provinceItem.name];
            return indexPath;
        }
        
        [self addTopBarItem];
        [self setTableView];
        CFAddressItem *item = self.dataSouce[indexPath.row];
        [self scrollToNextItem:item.name];
        self.province_id = item.code;
        CFLog(@"%@ %@",item.name,item.code);
        
    } else if ([self.tableViews indexOfObject:tableView] == 1) {
        
        CFAddressItem *cityItem = self.cityDataSouce[indexPath.row];
        self.districtDataSouce = [[CFCitiesDataTool sharedManager] queryRecordWithProvincial:cityItem.province city:cityItem.city];
        NSIndexPath *indexPath0 = [tableView indexPathForSelectedRow];
        
        if ([indexPath0 compare:indexPath] != NSOrderedSame && indexPath0) {
            
            for (int i = 0; i < self.tableViews.count - 1; i ++) {
                [self removeLastItem];
            }
            [self addTopBarItem];
            [self setTableView];
            [self scrollToNextItem:cityItem.name];
            return indexPath;
            
        } else if ([indexPath0 compare:indexPath] == NSOrderedSame && indexPath0) {
            
            [self scrollToNextItem:cityItem.name];
            return indexPath;
        }
        
        [self addTopBarItem];
        [self setTableView];
        CFAddressItem *item = self.cityDataSouce[indexPath.row];
        [self scrollToNextItem:item.name];
        self.city_id = item.code;
        CFLog(@"%@ %@",item.name,item.code);
        
    } else if ([self.tableViews indexOfObject:tableView] == 2) {
        
        CFAddressItem *item = self.districtDataSouce[indexPath.row];
        self.district_id = item.code;
        CFLog(@"%@ %@",item.name,item.code);
        
        [self setUpAddress:item.name];
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFAddressItem *item;
    if ([self.tableViews indexOfObject:tableView] == 0) {
        item = self.dataSouce[indexPath.row];
    } else if ([self.tableViews indexOfObject:tableView] == 1) {
        item = self.cityDataSouce[indexPath.row];
    } else if ([self.tableViews indexOfObject:tableView] == 2) {
        item = self.districtDataSouce[indexPath.row];
    }
    item.isSelected = YES;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFAddressItem * item;
    if ([self.tableViews indexOfObject:tableView] == 0) {
        item = self.dataSouce[indexPath.row];
    } else if ([self.tableViews indexOfObject:tableView] == 1) {
        item = self.cityDataSouce[indexPath.row];
    } else if ([self.tableViews indexOfObject:tableView] == 2) {
        item = self.districtDataSouce[indexPath.row];
    }
    item.isSelected = NO;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)addTopBarItem
{
    UIButton *topBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [topBarItem setTitle:@"请选择" forState:UIControlStateNormal];
    [topBarItem setTitleColor:CFColorFromRGB(43) forState:UIControlStateNormal];
    topBarItem.titleLabel.font = CFCommentTitleFont;
    [topBarItem setTitleColor:CFColor(23, 181, 104) forState:UIControlStateSelected];
    [topBarItem sizeToFit];
    topBarItem.xtfei_centerY = _topTabbar.xtfei_height * 0.5;
    [topBarItem addTarget:self action:@selector(topBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topTabbar addSubview:topBarItem];
    
    [self.topTabbarItems addObject:topBarItem];
}

- (void)setTableView
{
    UITableView *tabbleView = [[UITableView alloc] init];
    tabbleView.frame = CGRectMake(self.tableViews.count *CFMainScreen_Width, 0, CFMainScreen_Width, _contentView.xtfei_height);
    tabbleView.backgroundColor = [UIColor whiteColor];
    tabbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabbleView.delegate = self;
    tabbleView.dataSource = self;
    tabbleView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tabbleView.rowHeight = 44;
    
    [self.tableViews addObject:tabbleView];
    [_contentView addSubview:tabbleView];
}

/*** 点击按钮,滚动到对应位置 ***/
- (void)topBarItemClick:(UIButton *)sender
{
    NSInteger index = [self.topTabbarItems indexOfObject:sender];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.contentOffset = CGPointMake(index *CFMainScreen_Width, 0);
        [self changeUnderLineFrame:sender];
    }];
}

/*** 调整指示条位置 ***/
- (void)changeUnderLineFrame:(UIButton *)sender
{
    _selectedBtn.selected = NO;
    
    sender.selected = YES;
    _selectedBtn = sender;
    _underLine.xtfei_x = sender.xtfei_x;
    _underLine.xtfei_width = sender.xtfei_width;
}

/*** 完成地址选择,执行chooseFinish代码块 ***/
- (void)setUpAddress:(NSString *)address
{
    NSInteger index = self.contentView.contentOffset.x / CFMainScreen_Width;
    UIButton *btn = self.topTabbarItems[index];
    [btn setTitle:address forState:UIControlStateNormal];
    [btn sizeToFit];
    [_topTabbar layoutIfNeeded];
    [self changeUnderLineFrame:btn];
    
    NSMutableString *addressStr = [[NSMutableString alloc] init];
    for (UIButton *btn in self.topTabbarItems) {
        if ([btn.currentTitle isEqualToString:@"县"] || [btn.currentTitle isEqualToString:@"市辖区"] ) {
            continue;
        }
        [addressStr appendString:btn.currentTitle];
        [addressStr appendString:@" "];
    }
    self.address = addressStr;
    self.city = address;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.chooseFinish) {
            self.chooseFinish();
        }
    });
}

/*** 当重新选择省或者市的时候，需要将下级视图移除。 ***/
- (void)removeLastItem
{
    [self.tableViews.lastObject performSelector:@selector(removeFromSuperview) withObject:nil withObject:nil];
    [self.tableViews removeLastObject];
    
    [self.topTabbarItems.lastObject performSelector:@selector(removeFromSuperview) withObject:nil withObject:nil];
    [self.topTabbarItems removeLastObject];
}

/*** 滚动到下级界面,并重新设置顶部按钮条上对应按钮的title ***/
- (void)scrollToNextItem:(NSString *)preTitle
{
    NSInteger index = self.contentView.contentOffset.x / CFMainScreen_Width;
    UIButton *btn = self.topTabbarItems[index];
    [btn setTitle:preTitle forState:UIControlStateNormal];
    [btn sizeToFit];
    [_topTabbar layoutIfNeeded];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.contentView.contentSize = (CGSize){self.tableViews.count *CFMainScreen_Width,0};
        CGPoint offset = self.contentView.contentOffset;
        self.contentView.contentOffset = CGPointMake(offset.x + CFMainScreen_Width, offset.y);
        [self changeUnderLineFrame:[self.topTabbar.subviews lastObject]];
    }];
}

/*** 记录 ScrollView 的 Y 轴位置 ***/
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    lastContentOffset = scrollView.contentOffset.y;
}

/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 人为拖拽scrollView产生的滚动动画
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (lastContentOffset != scrollView.contentOffset.y) return;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        NSInteger index = scrollView.contentOffset.x / CFMainScreen_Width;
        CFLog(@"---->%ld",index);
        UIButton *btn = weakSelf.topTabbarItems[index];
        [weakSelf changeUnderLineFrame:btn];
    }];
}
@end
