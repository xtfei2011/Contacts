//
//  CFTabBarController.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFTabBarController.h"
#import "CFNavigationController.h"
#import "CFContactsController.h"
#import "CFFindController.h"
#import "CFMineController.h"

@interface CFTabBarController ()

@end

@implementation CFTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**** 设置所有UITabBarItem的文字属性 ****/
    [self setupItemTitleTextAttributes];
    
    /**** 添加子控制器 ****/
    [self setupChildViewControllers];
}

/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupItemTitleTextAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = CFColor(23, 181, 104);
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

/**
 *  添加子控制器
 */
- (void)setupChildViewControllers
{
    [self setupChildViewController:[[CFContactsController alloc] init] title:@"人脉" image:@"tab_bar_home" selectedImage:@"tab_bar_home_selected"];
    
    [self setupChildViewController:[[CFFindController alloc] init] title:@"找人" image:@"tab_bar_sort" selectedImage:@"tab_bar_sort_selected"];
    
    [self setupChildViewController:[[CFMineController alloc] init] title:@"我的" image:@"tab_bar_car" selectedImage:@"tab_bar_car_selected"];
}

/**
 *  初始化一个子控制器
 *
 *  @param viewController            子控制器
 *  @param title                     标题
 *  @param image                     图标
 *  @param selectedImage             选中的图标
 */
- (void)setupChildViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    viewController.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.view.backgroundColor = CFCommonBgColor;
    
    /*** 给外面传进来的控制器包装导航控制器 ***/
    CFNavigationController *nav = [[CFNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
}

#pragma mark ===== Tabbar 的图标和文字错位更正
/**
 *  用 Block 重写某个 class 的指定方法
 */
CG_INLINE BOOL
OverrideImplementation(Class targetClass, SEL targetSelector, id (^implementationBlock)(Class originClass, SEL originCMD, IMP originIMP)) {
    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
    if (!originMethod) {
        return NO;
    }
    IMP originIMP = method_getImplementation(originMethod);
    method_setImplementation(originMethod, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originIMP)));
    return YES;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 12.1, *)) {
            OverrideImplementation(NSClassFromString(@"UITabBarButton"), @selector(setFrame:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP originIMP) {
                return ^(UIView *selfObject, CGRect firstArgv) {
                    
                    if ([selfObject isKindOfClass:originClass]) {
                        // 如果发现即将要设置一个 size 为空的 frame，则屏蔽掉本次设置
                        if (!CGRectIsEmpty(selfObject.frame) && CGRectIsEmpty(firstArgv)) {
                            return;
                        }
                    }
                    // call super
                    void (*originSelectorIMP)(id, SEL, CGRect);
                    originSelectorIMP = (void (*)(id, SEL, CGRect))originIMP;
                    originSelectorIMP(selfObject, originCMD, firstArgv);
                };
            });
        }
    });
}

@end
