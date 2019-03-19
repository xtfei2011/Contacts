//
//  CFOSSImageUploader.h
//  FamousProduct
//
//  Created by 谢腾飞 on 2019/2/20.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, CFUploadImageState) {
    CFUploadImageFailed   = 0,
    CFUploadImageSuccess  = 1
};

@interface CFOSSImageUploader : NSObject

+ (void)asyncUploadImage:(UIImage *)image isAsync:(BOOL)async folder:(NSString *)folder complete:(void(^)(NSArray<NSString *> *names ,CFUploadImageState state))complete;

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images isAsync:(BOOL)async folder:(NSString *)folder complete:(void(^)(NSArray<NSString *> *names, CFUploadImageState state))complete;
@end

NS_ASSUME_NONNULL_END
