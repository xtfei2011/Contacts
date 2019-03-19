//
//  CFConnectionThirdController.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFConnectionThirdController.h"

@interface CFConnectionThirdController ()

@end

@implementation CFConnectionThirdController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.user_id = self.userID;
}

- (CFDimensionType)type
{
    return CFDimensionTypeThird;
}

@end
