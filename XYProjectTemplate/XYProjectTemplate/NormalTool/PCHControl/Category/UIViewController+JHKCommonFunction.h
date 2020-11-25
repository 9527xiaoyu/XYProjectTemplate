//
//  UIViewController+JHKCommonFunction.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JHKCommonFunction)

- (UIImageView *)getLineViewInNavigationBar:(UIView *)view;

/**强制横屏*/
- (void)forceOrientationLandscape;
/**强制竖屏*/
- (void)forceOrientationPortrait;
/**可选屏*/
- (void)forceOrientationAllButDown;
@end

NS_ASSUME_NONNULL_END
