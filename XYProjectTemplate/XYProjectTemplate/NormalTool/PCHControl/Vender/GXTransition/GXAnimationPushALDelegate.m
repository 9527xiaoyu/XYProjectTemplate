//
//  GXAnimatedPPushDelegate.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/7.
//  Copyright © 2020 gin. All rights reserved.
//

#import "GXAnimationPushALDelegate.h"

@implementation GXAnimationPushALDelegate

#pragma mark - Overwrite

- (void)presentViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [transitionContext.containerView addSubview:toVC.view];

    CGRect frame = toVC.view.frame;
    frame.origin.x = toVC.view.bounds.size.width;
    toVC.view.frame = frame;
    frame.origin.x = 0.0f;
    CGRect fromFrame = fromVC.view.frame;
    fromFrame.origin.x = -fromVC.view.frame.size.width;

    [self addBackgroundViewToView:fromVC.view];
    [self animateWithContext:transitionContext isPresent:YES animations:^{
        toVC.view.frame = frame;
        fromVC.view.frame = fromFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (self.isPush) {
        [transitionContext.containerView addSubview:toVC.view];
        [transitionContext.containerView bringSubviewToFront:fromVC.view];
    }
    //
    CGRect frame = fromVC.view.frame;
    frame.origin.x = 0.0f;
    fromVC.view.frame = frame;
    frame.origin.x = fromVC.view.bounds.size.width;
    //
    CGRect toFrame = fromVC.view.frame;
    toFrame.origin.x = -toVC.view.frame.size.width;
    toVC.view.frame = toFrame;
    toFrame.origin.x = 0.0f;
    //
    
    //当toVC为根目录时，使用rootVC
    UITabBarController *rootVC = (UITabBarController*)[jhkAppDelegate.window rootViewController];
    CGRect rootFrame = rootVC.tabBar.frame;
    rootFrame.origin.x = 0.0f;
    //
    [self addBackgroundViewToView:toVC.view];
    [self animateWithContext:transitionContext isPresent:NO animations:^{
        fromVC.view.frame = frame;
        toVC.view.frame = toFrame;
        if (toVC.navigationController.childViewControllers.count == 1) {
            rootVC.tabBar.frame = rootFrame;
        }
    } completion:^(BOOL finished) {

    }];
}

@end
