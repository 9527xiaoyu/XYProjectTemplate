//
//  UIViewController+JHKCommonFunction.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JHKCommonFunction)
/**启用返回按钮*/
- (void)enableReturnButton;
/**禁用返回按钮*/
- (void)disableReturnButton;
/**隐藏nav和返回按钮*/
- (void)hideNavBarAndBackButon;
/**隐藏nav*/
- (void)noNavBar;
/**隐藏返回按钮*/
- (void)noBackButon;
/**nav返回按钮*/
- (void)addReturnButton;
/**没有nav时，显示的返回按钮*/
- (void)addNoNavBarButton;

/**判断指定控制器的显示*/
+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;
/**判断控制器的显示*/
- (BOOL)isVisible;

/**获取nav的底部分割线*/
- (UIImageView *)getLineViewInNavigationBar:(UIView *)view;

/**强制横屏*/
- (void)forceOrientationLandscape;
/**强制竖屏*/
- (void)forceOrientationPortrait;
@end

NS_ASSUME_NONNULL_END
