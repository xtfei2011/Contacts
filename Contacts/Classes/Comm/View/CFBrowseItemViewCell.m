//
//  CFBrowseItemViewCell.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/13.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFBrowseItemViewCell.h"

@interface CFBrowseItemViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@end

@implementation CFBrowseItemViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setComm:(CFComm *)comm
{
    _comm = comm;
    
    [self.headerView setImageWithURL:[NSURL URLWithString:comm.USER_PHOTO] placeHoldImage:[UIImage imageNamed:@"cun_station_default_avatar"] isCircle:YES];
}
@end
