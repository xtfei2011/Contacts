//
//  CFMineTopView.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFMineTopView.h"
#import "CFMineController.h"
#import "CFMenuTypeController.h"
#import "CFEditPersonalInformationController.h"

@interface CFMineTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *accessBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;

@end

@implementation CFMineTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setUser:(CFUser *)user
{
    _user = user;
    
    [self.headerView setImageWithURL:[NSURL URLWithString:user.USER_PHOTO] placeHoldImage:[UIImage imageNamed:@"cun_station_default_avatar"] isCircle:YES];
    
    self.nameLabel.text = user.USER_NAME;
    
    [self.accessBtn setTitle:user.USER_BROWSE_NUMBER forState:UIControlStateNormal];
    [self.collectionBtn setTitle:user.USER_COLLECTION_NUMBER forState:UIControlStateNormal];
    [self.praiseBtn setTitle:user.USER_LIKE_NUMBER forState:UIControlStateNormal];
}

- (IBAction)mineTopViewButtonClick:(UIButton *)sender
{
    CFMineController *mine = (CFMineController *)[sender currentViewController];
    CFMenuTypeController *menuType = [[CFMenuTypeController alloc] init];
    
    switch (sender.tag) {
        case 1000: {
            menuType.navigationItem.title = @"访问我的";
            menuType.interface = Browse_Interface;
            [mine.navigationController pushViewController:menuType animated:YES];
        }
            break;
        case 1001: {
            menuType.navigationItem.title = @"收藏我的";
            menuType.interface = Attention_Interface;
            [mine.navigationController pushViewController:menuType animated:YES];
        }
            break;
        case 1002: {
            menuType.navigationItem.title = @"点赞我的";
            menuType.interface = Praise_Interface;
            [mine.navigationController pushViewController:menuType animated:YES];
        }
            break;
        case 1003: {
            CFEditPersonalInformationController *editor = [[CFEditPersonalInformationController alloc] init];
            [mine.navigationController pushViewController:editor animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
