//
//  CFOSSImageUploader.m
//  FamousProduct
//
//  Created by 谢腾飞 on 2019/2/20.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFOSSImageUploader.h"
#import <AliyunOSSiOS/OSSService.h>

static NSString *const AccessKey = @"LTAIVhj2TL2GutKn";
static NSString *const SecretKey = @"SFrjz26mVy7Z8xGAoN7GIwS6JMQLuG";
static NSString *const BucketName = @"malisten";
static NSString *const AliYunHost = @"https://oss-cn-beijing.aliyuncs.com/";

@implementation CFOSSImageUploader

+ (void)asyncUploadImage:(UIImage *)image isAsync:(BOOL)async folder:(NSString *)folder complete:(void(^)(NSArray<NSString *> *names ,CFUploadImageState state))complete
{
    [self uploadImages:@[image] isAsync:async folder:folder complete:complete];
}

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images isAsync:(BOOL)async folder:(NSString *)folder complete:(void(^)(NSArray<NSString *> *names, CFUploadImageState state))complete
{
    [self uploadImages:images isAsync:async folder:folder complete:complete];
}

+ (void)uploadImages:(NSArray<UIImage *> *)images isAsync:(BOOL)isAsync folder:(NSString *)folder complete:(void(^)(NSArray<NSString *> *names, CFUploadImageState state))complete
{
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:AliYunHost credentialProvider:credential];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = images.count;
    
    NSMutableArray *callBackNames = [NSMutableArray array];
    int i = 0;
    for (UIImage *image in images) {
        if (image) {
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                
                OSSPutObjectRequest *request = [OSSPutObjectRequest new];
                request.bucketName = BucketName;
                request.contentType = @"image/jpeg";
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmssSSS";
                NSString *timeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
                NSString *imageName = [folder stringByAppendingPathComponent:[NSString stringWithFormat:@"image_%@.png",timeStr]];
                NSString *imageUrl = [NSString stringWithFormat:@"https://malisten.oss-cn-beijing.aliyuncs.com/%@", imageName];
                
                request.objectKey = imageName;
                [callBackNames addObject:imageUrl];
                NSData *data = UIImageJPEGRepresentation(image, 0.5);
                request.uploadingData = data;
                request.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
                    CFLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
                };
                
                OSSTask *task = [client putObject:request];
                [task waitUntilFinished]; // 阻塞直到上传完成
                if (!task.error) {
                    CFLog(@"上传成功!");
                } else {
                    CFLog(@"上传失败, 错误码: %@" , task.error);
                }
                if (isAsync) {
                    if (image == images.lastObject) {
                        CFLog(@"上传完成了!");
                        if (complete) {
                            complete([NSArray arrayWithArray:callBackNames] ,CFUploadImageSuccess);
                        }
                    }
                }
            }];
            if (queue.operations.count != 0) {
                [operation addDependency:queue.operations.lastObject];
            }
            [queue addOperation:operation];
        }
        i ++;
    }
    if (!isAsync) {
        [queue waitUntilAllOperationsAreFinished];
        if (complete) {
            if (complete) {
                complete([NSArray arrayWithArray:callBackNames], CFUploadImageSuccess);
            }
        }
    }
}
@end
