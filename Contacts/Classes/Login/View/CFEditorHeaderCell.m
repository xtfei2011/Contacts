//
//  CFEditorHeaderCell.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/8.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFEditorHeaderCell.h"
#import "CFImageManager.h"
#import "CFOSSImageUploader.h"

@interface CFEditorHeaderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@end

@implementation CFEditorHeaderCell
static NSString *const CellID = @"CFEditorHeaderCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CFEditorHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"CFEditorHeaderCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CFAccount *account = [CFAccountTool account];
    if (account.USER_PHOTO) {
        [self.headerView setImageWithURL:[NSURL URLWithString:account.USER_PHOTO] placeHoldImage:[UIImage imageNamed:@"cun_station_default_avatar"] isCircle:YES];
    } else {
        [self.headerView setImageWithURL:[NSURL URLWithString:[CFUSER_DEFAULTS objectForKey:@"header_image"]] placeHoldImage:[UIImage imageNamed:@"cun_station_default_avatar"] isCircle:YES];
    }
}

- (IBAction)headerGesture:(UITapGestureRecognizer *)sender 
{
    CFAccount *account = [CFAccountTool account];
    
    __weak typeof(self) weakSelf = self;
    [[CFImageManager sharedManager] returnChooseImageBlock:^(UIImage * _Nonnull image) {
        weakSelf.headerView.image = [image circleImage];
        
        [TFProgressHUD showLoading:nil];
        [CFOSSImageUploader asyncUploadImage:image isAsync:NO folder:@"userPhoto" complete:^(NSArray<NSString *> * _Nonnull names, CFUploadImageState state) {
            CFLog(@"names---%@", names);
            
            if (!account.USER_ID) {
                NSUserDefaults *user = CFUSER_DEFAULTS;
                [user setObject:names[0] forKey:@"header_image"];
                [CFUSER_DEFAULTS synchronize];
            } else {
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                params[@"userId"] = account.USER_ID;
                params[@"userPhoto"] = names[0];
                
                [CFNetworkTools postResultWithUrl:Replace_Header_Interface params:params success:^(id _Nonnull responseObject) {
                    CFLog(@"--->%@",responseObject);
                    if ([responseObject[@"code"] isEqualToString:@"200"]) {
                        [TFProgressHUD showSuccess:responseObject[@"message"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    [TFProgressHUD dismiss];
                }];
            }
        }];
    }];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= CellMargin;
    [super setFrame:frame];
}
@end
