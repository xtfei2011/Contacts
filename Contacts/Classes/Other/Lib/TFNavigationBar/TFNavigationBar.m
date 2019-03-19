//
//  TFNavigationBar.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFNavigationBar.h"
#import <objc/runtime.h>

@implementation TFNavigationBar

+ (BOOL)isIphoneX
{
    if (CGRectEqualToRect([UIScreen mainScreen].bounds,CGRectMake(0, 0, 375, 812))) {
        return YES;
    } else {
        return NO;
    }
}

+ (int)navBarBottom
{
    return [self isIphoneX] ? 88 : 64;
}

+ (int)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (int)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}
@end

@implementation TFNavigationBar (TFDefault)

static char kTFDefaultNavBarBarTintColorKey;
static char kTFDefaultNavBarBackgroundImageKey;
static char kTFDefaultNavBarTintColorKey;
static char kTFDefaultNavBarTitleColorKey;
static char kTFDefaultStatusBarStyleKey;
static char kTFDefaultNavBarShadowImageHiddenKey;

+ (UIColor *)defaultNavBarBarTintColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kTFDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}

+ (void)xtfei_setDefaultNavBarBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kTFDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultNavBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kTFDefaultNavBarBackgroundImageKey);
    return image;
}

+ (void)xtfei_setDefaultNavBarBackgroundImage:(UIImage *)image
{
    objc_setAssociatedObject(self, &kTFDefaultNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTintColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kTFDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}

+ (void)xtfei_setDefaultNavBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kTFDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTitleColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kTFDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}

+ (void)xtfei_setDefaultNavBarTitleColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kTFDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle
{
    id style = objc_getAssociatedObject(self, &kTFDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}

+ (void)xtfei_setDefaultStatusBarStyle:(UIStatusBarStyle)style
{
    objc_setAssociatedObject(self, &kTFDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)defaultNavBarShadowImageHidden
{
    id hidden = objc_getAssociatedObject(self, &kTFDefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}

+ (void)xtfei_setDefaultNavBarShadowImageHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, &kTFDefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)defaultNavBarBackgroundAlpha
{
    return 1.0;
}

+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat neTFed = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:neTFed green:newGreen blue:newBlue alpha:newAlpha];
}

+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent
{
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}
@end


#pragma mark - UINavigationBar
@implementation UINavigationBar (TFAddition)

static char kTFBackgroundViewKey;
static char kTFBackgroundImageViewKey;
static char kTFBackgroundImageKey;

- (UIView *)backgroundView
{
    return (UIView *)objc_getAssociatedObject(self, &kTFBackgroundViewKey);
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    objc_setAssociatedObject(self, &kTFBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)backgroundImageView
{
    return (UIImageView *)objc_getAssociatedObject(self, &kTFBackgroundImageViewKey);
}

- (void)setBackgroundImageView:(UIImageView *)bgImageView
{
    objc_setAssociatedObject(self, &kTFBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)backgroundImage
{
    return (UIImage *)objc_getAssociatedObject(self, &kTFBackgroundImageKey);
}

- (void)setBackgroundImage:(UIImage *)image
{
    objc_setAssociatedObject(self, &kTFBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xtfei_setBackgroundImage:(UIImage *)image
{
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    if (self.backgroundImageView == nil) {
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        if (self.subviews.count > 0) {
            self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), [TFNavigationBar navBarBottom])];
            self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
        }
    }
    self.backgroundImage = image;
    self.backgroundImageView.image = image;
}

- (void)xtfei_setBackgroundColor:(UIColor *)color
{
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    self.backgroundImage = nil;
    if (self.backgroundView == nil) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), [TFNavigationBar navBarBottom])];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    }
    self.backgroundView.backgroundColor = color;
}

- (void)xtfei_setBackgroundAlpha:(CGFloat)alpha
{
    UIView *barBackgroundView = self.subviews.firstObject;
    if (@available(iOS 11.0, *)) {
        for (UIView *view in barBackgroundView.subviews) {
            view.alpha = alpha;
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
}

- (void)xtfei_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator
{
    for (UIView *view in self.subviews) {
        
        if (hasSystemBackIndicator == YES) {
            
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil) {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil) {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        } else {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil) {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil)
                {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

// 设置导航栏在垂直方向上平移多少距离
- (void)xtfei_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)xtfei_getTranslationY
{
    return self.transform.ty;
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
                      SEL needSwizzleSelectors[1] = {
                          @selector(setTitleTextAttributes:)
                      };
                      
                      for (int i = 0; i < 1;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [NSString stringWithFormat:@"xtfei_%@", NSStringFromSelector(selector)];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (void)xtfei_setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes
{
    NSMutableDictionary<NSString *,id> *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    if (newTitleTextAttributes == nil) {
        return;
    }
    
    NSDictionary<NSString *,id> *originTitleTextAttributes = self.titleTextAttributes;
    if (originTitleTextAttributes == nil) {
        [self xtfei_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    __block UIColor *titleColor;
    [originTitleTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqual:NSForegroundColorAttributeName]) {
            titleColor = (UIColor *)obj;
            *stop = YES;
        }
    }];
    
    if (titleColor == nil) {
        [self xtfei_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    if (newTitleTextAttributes[NSForegroundColorAttributeName] == nil) {
        newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    }
    [self xtfei_setTitleTextAttributes:newTitleTextAttributes];
}

@end

@interface UIViewController (Addition)
- (void)setPushToCurrentVCFinished:(BOOL)isFinished;
@end


#pragma mark - UINavigationController
@implementation UINavigationController (TFAddition)

static CGFloat TFPopDuration = 0.12;
static int TFPopDisplayCount = 0;

- (CGFloat)TFPopProgress
{
    CGFloat all = 60 * TFPopDuration;
    int current = MIN(all, TFPopDisplayCount);
    return current / all;
}

static CGFloat TFPushDuration = 0.10;
static int TFPushDisplayCount = 0;
- (CGFloat)TFPushProgress
{
    CGFloat all = 60 * TFPushDuration;
    int current = MIN(all, TFPushDisplayCount);
    return current / all;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController xtfei_statusBarStyle];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage
{
    [self.navigationBar xtfei_setBackgroundImage:backgroundImage];
}

- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor
{
    [self.navigationBar xtfei_setBackgroundColor:barTintColor];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha
{
    [self.navigationBar xtfei_setBackgroundAlpha:barBackgroundAlpha];
}

- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor
{
    self.navigationBar.tintColor = tintColor;
}

- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden
{
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}

- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor
{
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress
{
    UIColor *fromBarTintColor = [fromVC xtfei_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC xtfei_navBarBarTintColor];
    UIColor *newBarTintColor = [TFNavigationBar middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    
    UIColor *fromTintColor = [fromVC xtfei_navBarTintColor];
    UIColor *toTintColor = [toVC xtfei_navBarTintColor];
    UIColor *newTintColor = [TFNavigationBar middleColor:fromTintColor toColor:toTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    
    UIColor *fromTitleColor = [fromVC xtfei_navBarTitleColor];
    UIColor *toTitleColor = [toVC xtfei_navBarTitleColor];
    UIColor *newTitleColor = [TFNavigationBar middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    CGFloat fromBarBackgroundAlpha = [fromVC xtfei_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC xtfei_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [TFNavigationBar middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
                      SEL needSwizzleSelectors[4] = {
                          NSSelectorFromString(@"_updateInteractiveTransition:"),
                          @selector(popToViewController:animated:),
                          @selector(popToRootViewControllerAnimated:),
                          @selector(pushViewController:animated:)
                      };
                      
                      for (int i = 0; i < 4;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [[NSString stringWithFormat:@"xtfei_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (NSArray<UIViewController *> *)xtfei_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self setNeedsNavigationBarUpdateForTitleColor:[viewController xtfei_navBarTitleColor]];
    [self setNeedsNavigationBarUpdateForTintColor:[viewController xtfei_navBarTintColor]];
    
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        TFPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:TFPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self xtfei_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)xtfei_popToRootViewControllerAnimated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        TFPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:TFPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self xtfei_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    
    return vcs;
}

- (void)popNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        TFPopDisplayCount += 1;
        CGFloat popProgress = [self TFPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

- (void)xtfei_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        TFPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:TFPushDuration];
    [CATransaction begin];
    [self xtfei_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

- (void)pushNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        TFPushDisplayCount += 1;
        CGFloat pushProgress = [self TFPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES) {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10) {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        } else {
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    return YES;
}

- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context
{
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIColor *curColor = [[context viewControllerForKey:key] xtfei_navBarBarTintColor];
        CGFloat curAlpha = [[context viewControllerForKey:key] xtfei_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    if ([context isCancelled] == YES) {
        double cancelDuration = [context transitionDuration] * [context percentComplete];
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    } else {
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)xtfei_updateInteractiveTransition:(CGFloat)percentComplete
{
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    
    [self xtfei_updateInteractiveTransition:percentComplete];
}
@end


#pragma mark - UIViewController
@implementation UIViewController (TFAddition)

static char kTFPushToCurrentVCFinishedKey;
static char kTFPushToNextVCFinishedKey;
static char kTFNavBarBackgroundImageKey;
static char kTFNavBarBarTintColorKey;
static char kTFNavBarBackgroundAlphaKey;
static char kTFNavBarTintColorKey;
static char kTFNavBarTitleColorKey;
static char kTFStatusBarStyleKey;
static char kTFNavBarShadowImageHiddenKey;
static char kTFCustomNavBarKey;

- (BOOL)pushToCurrentVCFinished
{
    id isFinished = objc_getAssociatedObject(self, &kTFPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}

- (void)setPushToCurrentVCFinished:(BOOL)isFinished
{
    objc_setAssociatedObject(self, &kTFPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pushToNextVCFinished
{
    id isFinished = objc_getAssociatedObject(self, &kTFPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}

- (void)setPushToNextVCFinished:(BOOL)isFinished
{
    objc_setAssociatedObject(self, &kTFPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)xtfei_navBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kTFNavBarBackgroundImageKey);
    image = (image == nil) ? [TFNavigationBar defaultNavBarBackgroundImage] : image;
    return image;
}

- (void)xtfei_setNavBarBackgroundImage:(UIImage *)image
{
    if ([[self xtfei_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    } else {
        objc_setAssociatedObject(self, &kTFNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)xtfei_navBarBarTintColor
{
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kTFNavBarBarTintColorKey);
    return (barTintColor != nil) ? barTintColor : [TFNavigationBar defaultNavBarBarTintColor];
}

- (void)xtfei_setNavBarBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kTFNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self xtfei_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

- (CGFloat)xtfei_navBarBackgroundAlpha
{
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kTFNavBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [TFNavigationBar defaultNavBarBackgroundAlpha];
    
}

- (void)xtfei_setNavBarBackgroundAlpha:(CGFloat)alpha
{
    objc_setAssociatedObject(self, &kTFNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self xtfei_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

- (UIColor *)xtfei_navBarTintColor
{
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kTFNavBarTintColorKey);
    return (tintColor != nil) ? tintColor : [TFNavigationBar defaultNavBarTintColor];
}

- (void)xtfei_setNavBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kTFNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self xtfei_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

- (UIColor *)xtfei_navBarTitleColor
{
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kTFNavBarTitleColorKey);
    return (titleColor != nil) ? titleColor : [TFNavigationBar defaultNavBarTitleColor];
}

- (void)xtfei_setNavBarTitleColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kTFNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self xtfei_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

- (UIStatusBarStyle)xtfei_statusBarStyle
{
    id style = objc_getAssociatedObject(self, &kTFStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [TFNavigationBar defaultStatusBarStyle];
}

- (void)xtfei_setStatusBarStyle:(UIStatusBarStyle)style
{
    objc_setAssociatedObject(self, &kTFStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)xtfei_setNavBarShadowImageHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, &kTFNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
}

- (BOOL)xtfei_navBarShadowImageHidden
{
    id hidden = objc_getAssociatedObject(self, &kTFNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [TFNavigationBar defaultNavBarShadowImageHidden];
}

- (UIView *)xtfei_customNavBar
{
    UIView *navBar = objc_getAssociatedObject(self, &kTFCustomNavBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}

- (void)xtfei_setCustomNavBar:(UINavigationBar *)navBar
{
    objc_setAssociatedObject(self, &kTFCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
                      SEL needSwizzleSelectors[3] = {
                          @selector(viewWillAppear:),
                          @selector(viewWillDisappear:),
                          @selector(viewDidAppear:)
                      };
                      
                      for (int i = 0; i < 3;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [NSString stringWithFormat:@"xtfei_%@", NSStringFromSelector(selector)];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (void)xtfei_viewWillAppear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES) {
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self xtfei_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self xtfei_navBarTitleColor]];
    }
    [self xtfei_viewWillAppear:animated];
}

- (void)xtfei_viewWillDisappear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES) {
        [self setPushToNextVCFinished:YES];
    }
    [self xtfei_viewWillDisappear:animated];
}

- (void)xtfei_viewDidAppear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES) {
        UIImage *barBgImage = [self xtfei_navBarBackgroundImage];
        if (barBgImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
        } else {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self xtfei_navBarBarTintColor]];
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self xtfei_navBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self xtfei_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self xtfei_navBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self xtfei_navBarShadowImageHidden]];
    }
    [self xtfei_viewDidAppear:animated];
}

- (BOOL)canUpdateNavigationBar
{
    CGRect viewFrame = self.view.frame;
    CGRect maxFrame = [UIScreen mainScreen].bounds;
    CGRect minFrame = CGRectMake(0, TFNavigationBar.navBarBottom, TFNavigationBar.screenWidth, TFNavigationBar.screenHeight-TFNavigationBar.navBarBottom);
    
    BOOL isBat = CGRectEqualToRect(viewFrame, maxFrame) || CGRectEqualToRect(viewFrame, minFrame);
    if (self.navigationController && isBat) {
        return YES;
    } else {
        return NO;
    }
}
@end
