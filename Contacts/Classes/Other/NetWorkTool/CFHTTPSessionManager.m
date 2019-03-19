//
//  CFHTTPSessionManager.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/13.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFHTTPSessionManager.h"

@implementation CFHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        //        self.securityPolicy.validatesDomainName = NO;
        //        self.responseSerializer = nil;
        //        self.requestSerializer = nil;
    }
    return self;
}
@end
