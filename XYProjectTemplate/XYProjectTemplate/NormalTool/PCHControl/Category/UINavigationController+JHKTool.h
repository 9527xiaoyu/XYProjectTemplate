//
//  UINavigationController+JHKTool.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (JHKTool)

@property (nonatomic,strong,readonly) UIView *maskView;
- (void)showAlertInMaskView:(UIView *)view;
- (void)showAlertInMaskViewWithNoCancel:(UIView *)view;
- (void)hideAlertInMaskView;
- (void)hideAlertInMaskViewFor:(UIView*)view;

- (void)refitViewControllerViewFrame;


@end

NS_ASSUME_NONNULL_END
