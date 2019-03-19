//
//  TFNavigationBar.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFCustomNavigationBar;
@interface TFNavigationBar : UIView
+ (BOOL)isIphoneX;
+ (int)navBarBottom;
+ (int)screenWidth;
+ (int)screenHeight;
@end

#pragma mark - Default
@interface TFNavigationBar (TFDefault)

/*** 设置 UINavigationBar barTintColor ***/
+ (void)xtfei_setDefaultNavBarBarTintColor:(UIColor *)color;
/*** 设置 UINavigationBar tintColor ***/
+ (void)xtfei_setDefaultNavBarTintColor:(UIColor *)color;
/*** 设置 UINavigationBar titleColor ***/
+ (void)xtfei_setDefaultNavBarTitleColor:(UIColor *)color;
/*** 设置 UIStatusBar 的类型 ***/
+ (void)xtfei_setDefaultStatusBarStyle:(UIStatusBarStyle)style;
/*** 设置 UINavigationBar 的图片是否隐藏 ***/
+ (void)xtfei_setDefaultNavBarShadowImageHidden:(BOOL)hidden;
@end


#pragma mark - UINavigationBar
@interface UINavigationBar (TFAddition) <UINavigationBarDelegate>

/*** 设置导航栏所有BarButtonItem的透明度 ***/
- (void)xtfei_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;
/*** 设置导航栏在垂直方向上平移多少距离 ***/
- (void)xtfei_setTranslationY:(CGFloat)translationY;
/*** 获取当前导航栏在垂直方向上偏移了多少 ***/
- (CGFloat)xtfei_getTranslationY;
@end


#pragma mark - UIViewController
@interface UIViewController (TFAddition)

/*** 记录当前的视图控制器导航条背景 ***/
- (UIImage *)xtfei_navBarBackgroundImage;
/*** 记录当前的 ViewController 导航栏 barTintColor ***/
- (void)xtfei_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)xtfei_navBarBarTintColor;
/*** 记录当前的 ViewController 导航栏透明度 ***/
- (void)xtfei_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)xtfei_navBarBackgroundAlpha;
/*** 记录当前的 ViewController navigationBar tintColor ***/
- (void)xtfei_setNavBarTintColor:(UIColor *)color;
- (UIColor *)xtfei_navBarTintColor;
/*** 记录当前的 ViewController titleColor ***/
- (void)xtfei_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)xtfei_navBarTitleColor;
/*** 记录当前的 ViewController statusBarStyle ***/
- (void)xtfei_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)xtfei_statusBarStyle;
/*** 记录当前的 ViewController navigationBar shadowImage hidden ***/
- (void)xtfei_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)xtfei_navBarShadowImageHidden;
@end
