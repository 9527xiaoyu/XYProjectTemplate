//
//  UIViewController+JHKCommonFunction.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "UIViewController+JHKCommonFunction.h"
#import "JHKPointInsideButton.h"

#import <objc/runtime.h>

@implementation UIViewController (JHKCommonFunction)
#pragma mark - common function

- (void)enableReturnButton
{
    self.navigationItem.leftBarButtonItem.enabled = YES;
}

- (void)disableReturnButton
{
    self.navigationItem.leftBarButtonItem.enabled = NO;
}

- (void)hideNavBarAndBackButon
{
    self.navigationController.navigationBar.hidden = YES;
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIButton alloc] init]];
}

- (void)noBackButon
{
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIButton alloc] init]];
}

- (void)noNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIButton alloc] init]];
}

- (void)addReturnButton
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 26, 26)];
    JHKPointInsideButton *button = [[JHKPointInsideButton alloc]initWithFrame:CGRectMake(0, 0, 26, 26)];
    button.sizeType = ButtonSizeTypeCenter;
    [button setImage:ThemeImage(@"back_arrow") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnKeyBack) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];
    UIBarButtonItem *itemButton = [[UIBarButtonItem alloc]initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = itemButton;
}

- (void)addSmallReturnButton
{
    
}

- (void)addWhiteReturnButton
{
    
}

- (void)addWhiteNormalReturnButton
{
    
}

- (void)addNoNavBarButton
{
    UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.iphoneStatusBarHeight+16, 26, 26)];
    [returnBtn setImage:ThemeImage(@"ywart_wallpicture_back") forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
}

#pragma mark - ==================== 返回事件 ============================
- (void)returnKeyBack
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)returnClick
{
    
}

+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}

- (BOOL)isVisible
{
    return (self.isViewLoaded && self.view.window);
}

- (UIImageView *)getLineViewInNavigationBar:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self getLineViewInNavigationBar:subview];
        if (imageView) {
            return imageView;
        }
    }
    
    return nil;
}

//强制横屏
- (void)forceOrientationLandscape {
    jhkAppDelegate.isForceLandscape=YES;
    jhkAppDelegate.isForcePortrait=NO;
    [jhkAppDelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
    //强制翻转屏幕，Home键在右边。
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}

//强制竖屏
- (void)forceOrientationPortrait {
    jhkAppDelegate.isForcePortrait=YES;
    jhkAppDelegate.isForceLandscape=NO;
     [jhkAppDelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
    //设置屏幕的转向为竖屏
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}

@end
