//
//  UINavigationController+JHKTool.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "UINavigationController+JHKTool.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

@implementation UINavigationController (JHKTool)

- (void)showAlertInMaskView:(UIView *)view
{
    [self.maskView addSubview:view];
    [self.maskView bringToFront];
    view.center = self.maskView.center;
    view.tag = 10086;
    
    CGFloat x = view.jhk_centerX - 19;
    CGFloat y = view.jhk_y + view.jhk_height + 40;
    CGRect frame = CGRectMake(x ,y , 38, 38);
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:frame];
    [cancelBtn setImage:ThemeImage(@"icon_close") forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelMaskView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.maskView addSubview:cancelBtn];
    
    //[self forceOrientationPortrait];
}

- (void)showAlertInMaskViewWithNoCancel:(UIView *)view
{
    [self.maskView addSubview:view];
    [self.maskView bringToFront];
    view.center = self.maskView.center;
    view.tag = 19936;
    
    //[self forceOrientationPortrait];
}

- (void)hideAlertInMaskView
{
    [self.maskView removeFromSuperview];
    self.maskView = nil;
}

- (void)hideAlertInMaskViewFor:(UIView*)view
{
    if ([self.maskView.subviews containsObject:view]) {
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }
}

- (void)setMaskView:(UIView *)maskView
{
    objc_setAssociatedObject(self, @selector(maskView), maskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)maskView
{
    UIView *maskView =  objc_getAssociatedObject(self, @selector(maskView));
    if (!maskView) {
        maskView = [[UIView alloc] init];
        maskView.frame = self.view.bounds;
        
        maskView.backgroundColor = jhkRGBA(0, 0, 0, 0.6);
        objc_setAssociatedObject(self, @selector(maskView), maskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    }
    return maskView;
}

- (void)cancelMaskView
{
    UIView *view = [self.maskView viewWithTag:10086];
    if ([view respondsToSelector:@selector(cancelMaskView)]) {
        [view performSelector:@selector(cancelMaskView)];
    }
    [self hideAlertInMaskView];
}

- (void)refitViewControllerViewFrame
{
    UINavigationController *nav = self;
    BOOL hidden = nav.navigationBar.hidden;
    [nav setNavigationBarHidden:!hidden animated:NO];
    [nav setNavigationBarHidden:hidden animated:NO];
}

@end
