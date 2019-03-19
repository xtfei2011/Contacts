//
//  CFPlaceholderTextView.h
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/10.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFPlaceholderTextView : UITextView
/*** 占位文字 ***/
@property (nonatomic ,copy) NSString *placeholder;
/*** 占位文字的颜色 ***/
@property (nonatomic ,strong) UIColor *placeholderColor;
@end

NS_ASSUME_NONNULL_END
