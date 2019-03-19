//
//  TFWebViewController.h
//  Appointment
//
//  Created by 谢腾飞 on 2018/3/3.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFWebViewController : UIViewController

/*** 加载网页链接 ***/
- (void)loadWebURLString:(NSString *)string;

/*** 加载本地网页 ***/
- (void)loadWebHTMLSring:(NSString *)string;

/*** 加载外部链接POST请求 ***/
- (void)postWebURLSring:(NSString *)string parameter:(NSString *)parameter;
@end
