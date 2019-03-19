//
//  CFContactsTopView.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/9.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFContactsTopView.h"
#import "CFCLLocation.h"

@interface CFContactsTopView ()

@property (weak, nonatomic) IBOutlet UIButton *positionBtn;
@end

@implementation CFContactsTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self positionButtonClick];
}

- (IBAction)cityButtonClick:(UIButton *)sender
{
    !_clickAddressBlock ? : _clickAddressBlock();
}

- (IBAction)positionButtonClick
{
    [TFProgressHUD showLoading:@"获取您的位置中···"];
    [[CFCLLocation shareLocation] locationStart:^(CLLocation *location, CLPlacemark *placemark) {
        [TFProgressHUD dismiss];
        
        NSString *province = placemark.administrativeArea;
        NSString *city = placemark.locality;
        NSString *area = placemark.subLocality;
        
        [self.cityBtn setTitle:placemark.subLocality forState:UIControlStateNormal];
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            
            NSDictionary *dic = @{
                                  @"province" : province,
                                  @"city" : city,
                                  @"area" : area
                                  };
            NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadHomeList" object:nil userInfo:dict];
        });
    } faile:^(NSError *error) {
        if (error) {
            [TFProgressHUD dismiss];
            if (([error code] == kCLErrorDenied)) {
                [UIAlertController showAlertWithTitle:@"无法获取您的位置信息" message:@"请在设置-隐私-定位服务中开启设置" actionTitles:@[@"确定"] cancelTitle:@"取消" style:UIAlertControllerStyleAlert completion:^(NSInteger index) {
                    
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        [[UIApplication sharedApplication] openURL:url];                    }
                }];
            }
        }
    }];
}
@end
