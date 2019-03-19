//
//  CFAboutBottomView.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/14.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFAboutBottomView.h"
#import "TFWebViewController.h"
#import "CFAboutViewController.h"

@implementation CFAboutBottomView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, CFMainScreen_Width, 120);
}

- (IBAction)protocolsAndPrivacyButtonClick:(UIButton *)sender
{
    CFAboutViewController *about = (CFAboutViewController *)[sender currentViewController];
    TFWebViewController *webView = [[TFWebViewController alloc] init];
    if (sender.tag == 1106) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"protocol" ofType:@"html"];
        NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [webView loadWebHTMLSring:html];
        [about.navigationController pushViewController:webView animated:YES];
    } else if (sender.tag == 1107) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"intimacy" ofType:@"html"];
        NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [webView loadWebHTMLSring:html];
        [about.navigationController pushViewController:webView animated:YES];
    }
}

@end
