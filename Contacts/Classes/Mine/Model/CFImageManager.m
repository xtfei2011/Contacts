//
//  CFImageManager.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/19.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFImageManager.h"
#import "HXPhotoPicker.h"

@interface CFImageManager () <HXCustomCameraViewControllerDelegate ,HXAlbumListViewControllerDelegate ,HXPhotoViewDelegate>

@property (nonatomic ,copy) ChooseImageBlock imageBlock;
@property (nonatomic ,strong) HXPhotoManager *manager;
@property (nonatomic ,strong) HXDatePhotoToolManager *toolManager;
@end

@implementation CFImageManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static CFImageManager *imageManager;
    dispatch_once(&onceToken, ^{
        imageManager = [[CFImageManager alloc] init];
    });
    return imageManager;
}

- (HXDatePhotoToolManager *)toolManager
{
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}

- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.openCamera = NO;
        _manager.configuration.singleSelected = YES;
        _manager.configuration.movableCropBox = YES;
        _manager.configuration.movableCropBoxEditSize = YES;
        _manager.configuration.navigationTitleSynchColor = YES;
        _manager.configuration.themeColor = [UIColor whiteColor];
        _manager.configuration.navigationTitleColor = [UIColor whiteColor];
        _manager.configuration.albumShowMode = HXPhotoAlbumShowModePopup;
        _manager.configuration.movableCropBoxCustomRatio = CGPointMake(1, 1);
    }
    return _manager;
}

- (void)returnChooseImageBlock:(ChooseImageBlock)imageBlock
{
    self.imageBlock = imageBlock;
    
    NSString *str = nil;
    [UIAlertController showAlertWithTitle:str message:str actionTitles:@[@"相机", @"相册"] cancelTitle:@"取消" style:UIAlertControllerStyleActionSheet completion:^(NSInteger index) {
        [self selectRowAtIndex:index];
    }];
}

- (void)selectRowAtIndex:(NSInteger)index
{
    CFLog(@"--->%ld",index);
    switch (index) {
        case 0: {
            // 调取系统相机
            [self chooseSystemCamera];
        }
            break;
        case 1: {
            // 调取系统相册
            [self chooseSystemAlbum];
        }
            break;
    }
}

- (void)chooseSystemCamera
{
    /*** 判断此设备是否支持相机 ***/
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [TFProgressHUD showInfoMsg:@"此设备不支持相机!"];
        return;
    }
    
    /*** 判断用户是否允许当前APP使用用户相机操作 ***/
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        
        [UIAlertController showAlertWithTitle:@"无法使用相机" message:@"请在设置-隐私-相机中允许访问相机" actionTitles:@[@"确定"] cancelTitle:@"取消" style:UIAlertControllerStyleAlert completion:^(NSInteger index) {
            
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            }
        }];
        return;
    }
    
    /*** 相机照相后回调方法 ***/
    __weak typeof(self) weakSelf = self;
    [[self createViewController] hx_presentCustomCameraViewControllerWithManager:self.manager done:^(HXPhotoModel *model, HXCustomCameraViewController *viewController) {
        
        [weakSelf.manager afterListAddCameraTakePicturesModel:model];
        /*** 选取照片后回调给外部 ***/
        self.imageBlock(model.thumbPhoto);
        
    } cancel:^(HXCustomCameraViewController *viewController) { CFLog(@"用户取消了"); }];
}

- (void)chooseSystemAlbum
{
    __weak typeof(self) weakSelf = self;
    if (self.manager.configuration.requestImageAfterFinishingSelection) {
        
        [[self createViewController] hx_presentSelectPhotoControllerWithManager:self.manager didDone:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL isOriginal, UIViewController *viewController, HXPhotoManager *manager) {
            NSSLog(@"block - all - %@",allList);
            if (photoList.count > 0) {
                HXPhotoModel *model = photoList.lastObject;
                weakSelf.imageBlock(model.previewPhoto);
            }
        } imageList:^(NSArray<UIImage *> *imageList, BOOL isOriginal) {
        } cancel:^(UIViewController *viewController, HXPhotoManager *manager) { CFLog(@"取消了"); }];
        
    } else {
        [[self createViewController] hx_presentSelectPhotoControllerWithManager:self.manager didDone:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL isOriginal, UIViewController *viewController, HXPhotoManager *manager) {
            NSSLog(@"block - all - %@",allList);
            if (photoList.count > 0) {
                [TFProgressHUD showInfoMsg:@"获取照片中"];
                [weakSelf.toolManager getSelectedImageList:photoList requestType:HXDatePhotoToolManagerRequestTypeHD success:^(NSArray<UIImage *> *imageList) {
                    [TFProgressHUD showLoading:@""];
                    weakSelf.imageBlock(imageList.lastObject);
                } failed:^{
                    [TFProgressHUD showInfoMsg:@"获取失败"];
                }];
            }
        } imageList:^(NSArray<UIImage *> *imageList, BOOL isOriginal) {
        } cancel:^(UIViewController *viewController, HXPhotoManager *manager) { CFLog(@"取消了"); }];
    }
}

- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original
{
    if (photoList.count > 0) {
        HXPhotoModel *model = photoList.firstObject;
        self.imageBlock(model.previewPhoto);
    }
}

- (void)datePhotoViewController:(HXDatePhotoViewController *)datePhotoViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original
{
    if (photoList.count > 0) {
        HXPhotoModel *model = photoList.firstObject;
        self.imageBlock(model.previewPhoto);
    }
}

- (UIViewController *)createViewController
{
    __block UIWindow *normalWindow = [[UIApplication sharedApplication].delegate window];
    
    if (normalWindow.windowLevel != UIWindowLevelNormal) {
        
        [[UIApplication sharedApplication].windows enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.windowLevel == UIWindowLevelNormal) {
                normalWindow = obj;
                *stop = YES;
            }
        }];
    }
    return [self nextTopForViewController:normalWindow.rootViewController];
}

- (UIViewController *)nextTopForViewController:(UIViewController *)inViewController
{
    while (inViewController.presentedViewController) {
        inViewController = inViewController.presentedViewController;
    }
    
    if ([inViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedVC = [self nextTopForViewController:((UITabBarController *)inViewController).selectedViewController];
        return selectedVC;
        
    } else if ([inViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *selectedVC = [self nextTopForViewController:((UINavigationController *)inViewController).visibleViewController];
        return selectedVC;
        
    } else {
        return inViewController;
    }
}
@end
