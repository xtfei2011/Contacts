//
//  CFImageManager.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/19.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChooseImageBlock)(UIImage *image);

@interface CFImageManager : NSObject

+ (instancetype)sharedManager;
/*** 选择照片后的回调 ***/
- (void)returnChooseImageBlock:(ChooseImageBlock)imageBlock;
@end

NS_ASSUME_NONNULL_END
