//
//  UIImageView+TFExtension.h
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/20.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (TFExtension)

- (void)setImageWithURL:(NSURL *)url progress:(void(^)(CGFloat progress))progress complete:(void(^)(void))complete;

- (void)setImageWithURL:(NSURL *)url placeHoldImage:(UIImage *)placeHoldImage isCircle:(BOOL)isCircle;
@end
