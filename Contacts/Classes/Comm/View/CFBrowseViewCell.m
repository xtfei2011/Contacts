//
//  CFBrowseViewCell.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/13.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFBrowseViewCell.h"
#import "CFBrowseItemViewCell.h"
#import "CFCommDetailController.h"
#import "CFMenuTypeController.h"

@interface CFBrowseViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@end

@implementation CFBrowseViewCell
static NSString *const BrowseID = @"CFBrowseViewCell";
static NSString *const itemID = @"CFBrowseItemViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CFBrowseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BrowseID];
    if (!cell) {
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"CFBrowseViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CGFloat itemWidth = (CFMainScreen_Width - 90 - (CellCountInRow + 1) * 5) / CellCountInRow;
    CGFloat itemHeight = itemWidth;
    
    self.layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.layout.minimumInteritemSpacing = 5 - 0.1;
    self.layout.minimumLineSpacing = 5;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(5, 5, 0, 5);
    
    UINib *nib = [UINib nibWithNibName:@"CFBrowseItemViewCell" bundle:[NSBundle bundleForClass:[self class]]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:itemID];
}

- (void)setComm:(NSMutableArray<CFComm *> *)comm
{
    _comm = comm;
    
    [self.collectionView reloadData];
}

#pragma mark - collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (self.comm.count > 5) ? 5 : self.comm.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CFBrowseItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    cell.comm = self.comm[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CFBrowseItemViewCell *cell = (CFBrowseItemViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CFCommDetailController *mineVC = (CFCommDetailController *)[cell currentViewController];

    CFCommDetailController *viewClass = [[CFCommDetailController alloc] init];
    viewClass.other_people_id = cell.comm.USER_ID;
    viewClass.other_people_name = cell.comm.USER_NAME;
    [mineVC.navigationController pushViewController:viewClass animated:YES];
}

- (IBAction)browseButtonClick:(UIButton *)sender
{
    CFCommDetailController *mineVC = (CFCommDetailController *)[sender currentViewController];
    CFMenuTypeController *segment = [[CFMenuTypeController alloc] init];
    segment.browse_id = self.other_people_id;
    segment.navigationItem.title = @"最新访客";
    [mineVC.navigationController pushViewController:segment animated:YES];
}

@end
