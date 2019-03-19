//
//  UIImageView+TFExtension.m
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "UIImageView+TFExtension.h"
#import "UIImage+TFExtension.h"

@implementation UIImageView (TFExtension)

- (void)setImageWithURL:(NSURL *)url progress:(void(^)(CGFloat progress))progress complete:(void(^)(void))complete
{
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loadingview_empty"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progress != nil) {
            progress(1.0 * receivedSize /expectedSize);
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image;
        if (complete != nil) {
            complete();
        }
    }];
}

- (void)setImageWithURL:(NSURL *)url placeHoldImage:(UIImage *)placeHoldImage isCircle:(BOOL)isCircle
{
    if (isCircle) {
        [self sd_setImageWithURL:url placeholderImage:[placeHoldImage circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            UIImage *resultImage = [image circleImage];
            
            if (resultImage == nil) return;
            self.image = resultImage;
        }];
    } else {
        
        [self sd_setImageWithURL:url placeholderImage:placeHoldImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image == nil) return;
            self.image = image;
        }];
    }
}
@end
