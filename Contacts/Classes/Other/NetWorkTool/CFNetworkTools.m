//
//  CFNetworkTools.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFNetworkTools.h"
#import <AFNetworking.h>

@implementation CFNetworkTools

#pragma mark -------  GET 请求数据
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getResultWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    [manger GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -------  POST 请求数据
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postResultWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manger.requestSerializer.timeoutInterval = 5;
    
    [manger POST:Common_Interface_Montage(url) parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)loadPersonalInformation
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = [CFUSER_DEFAULTS objectForKey:@"userID"];
    
    [CFNetworkTools postResultWithUrl:Information_Interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            CFAccount *account = [CFAccount mj_objectWithKeyValues:responseObject[@"data"]];
            [CFAccountTool saveAccount:account];
        }
    } failure:^(NSError * _Nonnull error) {}];
}
@end
