//
//  CFPositionViewController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/15.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFPositionViewController.h"
#import "CFLeftTableViewCell.h"
#import "CFRightCollectionViewCell.h"

@interface CFPositionViewController ()<UITableViewDataSource ,UITableViewDelegate ,UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource ,UICollectionViewDelegate>
@property (nonatomic ,strong) UITableView *leftTableView;
@property (nonatomic ,strong) UICollectionView *rightCollectionView;
@property (nonatomic ,strong) UICollectionViewFlowLayout *layout;
@property (nonatomic ,strong) NSArray *rightArray;

/** 分类左边数据 */
@property (nonatomic ,strong) NSMutableArray<CFLeftCategory *> *leftCategory;
/** 分类右边数据 */
@property (nonatomic ,strong) NSMutableArray<CFRightCategory *> *rightCategory;
/*** 存储对应下标 ***/
@property (nonatomic ,assign) NSInteger selectIndex;

@end

@implementation CFPositionViewController
static NSString * const RightViewID = @"CFRightCollectionViewCell";
static NSString * const RightReusableViewID = @"CFRightReusableView";

- (NSArray *)rightArray
{
    if (!_rightArray) {
        _rightArray = [[NSArray alloc] init];
    }
    return _rightArray;
}

- (UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CFNavigationBarH, kLeftWidth, CFMainScreen_Height - CFNavigationBarH - iPhoneX_BOTTOM_HEIGHT)];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _leftTableView.showsVerticalScrollIndicator = NO;
    }
    return _leftTableView;
}

- (UICollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 2;
        _layout.minimumLineSpacing = 2;
        _layout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
    }
    return _layout;
}

- (UICollectionView *)rightCollectionView
{
    if (!_rightCollectionView) {
        
        _rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kLeftWidth, CFNavigationBarH, self.view.xtfei_width - kLeftWidth, CFMainScreen_Height - CFNavigationBarH - iPhoneX_BOTTOM_HEIGHT) collectionViewLayout:self.layout];
        _rightCollectionView.dataSource = self;
        _rightCollectionView.delegate = self;
        _rightCollectionView.alwaysBounceVertical = YES;
        _rightCollectionView.backgroundColor = CFCommonBgColor;
        
        /*** 注册cell ***/
        [_rightCollectionView registerClass:[CFRightCollectionViewCell class] forCellWithReuseIdentifier:RightViewID];
    }
    return _rightCollectionView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"选择职业";
    
    self.selectIndex = 0;
    [self loadSortData];
}

- (void)loadSortData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    CFLog(@"%@",params);
    
     [TFProgressHUD showLoading:@"加载中···"];
    __weak typeof(self) homeSelf = self;
    [CFNetworkTools postResultWithUrl:Position_List_Interface params:params success:^(id  _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        [TFProgressHUD dismiss];
        homeSelf.leftCategory = [CFLeftCategory mj_objectArrayWithKeyValuesArray:responseObject[@"station_one"]];
        
        [self setupMenuView];
        
    } failure:^(NSError * _Nonnull error) {
        [TFProgressHUD dismiss];
    }];
}

- (void)setupMenuView
{
    _rightArray = [[self.leftCategory objectAtIndex:0] valueForKey:@"station_two"];
    
    /*** 左边的视图 ***/
    [self.view addSubview:self.leftTableView];
    /*** 右边的视图 ***/
    [self.view addSubview:self.rightCollectionView];
    
    if (self.leftCategory.count > 0) {
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }
}

#pragma mark -- 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFLeftTableViewCell *cell = [CFLeftTableViewCell cellWithTableView:tableView];
    cell.leftCategory = self.leftCategory[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    _rightArray = [[self.leftCategory objectAtIndex:indexPath.row] valueForKey:@"station_two"];
    
    [self.rightCollectionView reloadData];
}

/**
 *  右边菜单
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_rightArray count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = (CFMainScreen_Width - kLeftWidth - 10);
    return CGSizeMake(itemWidth, 44);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.5, 5, 0, 5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CFRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RightViewID forIndexPath:indexPath];
    
    self.rightCategory = [CFRightCategory mj_objectArrayWithKeyValuesArray:_rightArray];
    cell.rightCategory = self.rightCategory[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.rightCategory = [CFRightCategory mj_objectArrayWithKeyValuesArray:_rightArray];
    self.changePositionBlock(self.rightCategory[indexPath.row].STATION_ID, self.rightCategory[indexPath.row].STATION_NAME);
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
