//
//  UIViewController+GXTransitionDelegate.m
//  GXTransitionSample
//
//  Created by Gin on 2020/4/4.
//  Copyright © 2020 gin. All rights reserved.
//

#import "UIViewController+GXTransitionDelegate.h"
#import <objc/runtime.h>
#import "GXAnimationPushALDelegate.h"
#import "GXAnimationPushELDelegate.h"
#import "JHKNavigationController.h"

@implementation UIViewController (GXTransitionDelegate)

- (void)setGx_animatedDelegate:(GXAnimationBaseDelegate *)gx_animatedDelegate {
    objc_setAssociatedObject(self, @selector(gx_animatedDelegate), gx_animatedDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (GXAnimationBaseDelegate *)gx_animatedDelegate {
    return objc_getAssociatedObject(self, @selector(gx_animatedDelegate));
}

#pragma mark - Utility

- (void)pushViewController:(UIViewController *)viewController style:(GXAnimationStyle)style interacting:(BOOL)interacting {
    [self gotoViewController:viewController isPush:YES style:style interacting:interacting completion:nil];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent style:(GXAnimationStyle)style interacting:(BOOL)interacting completion:(void (^ __nullable)(void))completion {
    [self gotoViewController:viewControllerToPresent isPush:NO style:style interacting:interacting completion:completion];
}

#pragma mark - Private

- (void)gotoViewController:(UIViewController*)vc isPush:(BOOL)isPush style:(GXAnimationStyle)style interacting:(BOOL)interacting completion:(void (^ __nullable)(void))completion {
    switch (style) {
        case GXAnimationStylePushEdgeLeft:
            self.gx_animatedDelegate = [[GXAnimationPushELDelegate alloc] init];
            break;
        case GXAnimationStylePushAllLeft:
            self.gx_animatedDelegate = [[GXAnimationPushALDelegate alloc] init];
            break;
        default:break;
    }
    [self.gx_animatedDelegate configureTransition:vc isPush:isPush interacting:interacting];
    if (isPush) {
        self.navigationController.delegate = self.gx_animatedDelegate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        vc.transitioningDelegate = self.gx_animatedDelegate;
        vc.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:vc animated:YES completion:completion];
    }
}

@end
