//
//  TFPopupEnumHeader.h
//  DirectHire
//
//  Created by 谢腾飞 on 2018/8/23.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#ifndef TFPopupEnumHeader_h
#define TFPopupEnumHeader_h

/*** 屏幕宽高 ***/
#define TFMainScreen_Width          [UIScreen mainScreen].bounds.size.width
#define TFMainScreen_Height         [UIScreen mainScreen].bounds.size.height

/*** 默认动画时间 ***/
#define kAnimDuration 0.25
/*** 默认透明度 ***/
#define kAlpha 0.5


/** 遮罩类型 */
typedef NS_ENUM(NSUInteger, TFPopupViewStyle) {
    /** 半透明 */
    TFPopupViewStyleTranslucent,  // 半透明
    /** 全透明 */
    TFPopupViewStyleTransparent,  // 全透明
    /** 高斯模糊 */
    TFPopupViewStyleBlur          // 高斯模糊
};

/** 视图显示类型 */
typedef NS_ENUM(NSUInteger, TFPopupViewShowStyle) {
    /** 显示在上面 */
    TFPopupViewShowStyleTop,     // 显示在上面
    /** 显示在中间 */
    TFPopupViewShowStyleCenter,  // 显示在中间
    /** 显示在底部 */
    TFPopupViewShowStyleBottom   // 显示在底部
};

/** 动画类型 */
typedef NS_ENUM(NSUInteger, TFPopupViewAnimStyle) {
    TFPopupViewAnimStyleTop,      // 从上弹出 (上，中可用)
    TFPopupViewAnimStyleCenter,   // 中间弹出 (中可用)
    TFPopupViewAnimStyleBottom,   // 底部弹出,底部消失 (中，下可用)
    TFPopupViewAnimStyleNone      // 无动画
};


#pragma mark - v2.4.0新增
/** 弹窗显示时的动画类型 */
typedef NS_ENUM(NSUInteger, TFPopupViewShowAnimStyle) {
    /** 从上弹出 */
    TFPopupViewShowAnimStyleTop,     // 从上弹出
    /** 中间弹出 */
    TFPopupViewShowAnimStyleCenter,  // 中间弹出
    /** 底部弹出 */
    TFPopupViewShowAnimStyleBottom,  // 底部弹出
    /** 无动画 */
    TFPopupViewShowAnimStyleNone     // 无动画
};

/** 弹窗隐藏时的动画类型 */
typedef NS_ENUM(NSUInteger, TFPopupViewHideAnimStyle) {
    /** 从上隐藏 */
    TFPopupViewHideAnimStyleTop,     // 从上隐藏
    /** 中间隐藏（直接消失） */
    TFPopupViewHideAnimStyleCenter,  // 中间隐藏（直接消失）
    /** 底部隐藏 */
    TFPopupViewHideAnimStyleBottom,  // 底部隐藏
    /** 无动画 */
    TFPopupViewHideAnimStyleNone     // 无动画
};

#endif /* TFPopupEnumHeader_h */
