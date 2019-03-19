//
//  CFCommDetailCell.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFCommDetailCell.h"
#import "CFBusinessCardInformationCell.h"

@interface CFCommDetailCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic ,strong) UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UIView *detailBaseView;
@end

@implementation CFCommDetailCell
static NSString *const cellID = @"CFCommDetailCell";
static NSString *const itemID = @"CFBusinessCardInformationCell";

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        
        CGFloat pageControlY = self.detailBaseView.xtfei_height - 10;
        CGFloat pageControlW = self.detailBaseView.xtfei_width;
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageControlY, pageControlW, 6)];
        _pageControl.pageIndicatorTintColor = CFRGBColor(23, 181, 104, 0.3);
        _pageControl.currentPageIndicatorTintColor = CFColor(23, 181, 104);
    }
    return _pageControl;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CFCommDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"CFCommDetailCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CGFloat itemWidth = CFMainScreen_Width - 20;
    CGFloat itemHeight = 250;
    
    self.flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UINib *nib = [UINib nibWithNibName:@"CFBusinessCardInformationCell" bundle:[NSBundle bundleForClass:[self class]]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:itemID];
    
    [TFExtension chageControllerCircular:self.detailBaseView cornerRadius:6 borderWidth:1 borderColor:[UIColor whiteColor] masksToBounds:YES];
    
    [self.detailBaseView addSubview:self.pageControl];
}

- (void)setCommDetail:(NSMutableArray<CFCommDetail *> *)commDetail
{
    _commDetail = commDetail;
    
    [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:commDetail[0].USER_PHOTO] placeholderImage:[UIImage imageNamed:@"background_position"]];
    
    if (commDetail.count < 2) {
        self.collectionView.scrollEnabled = false;
        [self.pageControl setHidden:true];
    } else {
        self.collectionView.scrollEnabled = true;
        [self.pageControl setHidden:false];
    }
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = commDetail.count;
}

#pragma mark - collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.commDetail.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CFBusinessCardInformationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    cell.commDetail = self.commDetail[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width) % 10;
    
    self.pageControl.currentPage = page;
}
@end
