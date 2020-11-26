//
//  UIViewController+GXTransitionDelegate.h
//  GXTransitionSample
//
//  Created by Gin on 2020/4/4.
//  Copyright © 2020 gin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXAnimationBaseDelegate.h"
#import "JHKNavigationController.h"

/**
 * 自定义转场风格(present/push)
 */
typedef NS_ENUM(NSUInteger, GXAnimationStyle) {
    /**如push一致的平移转场*/
    GXAnimationStylePush = 0,
    /**当前视图scale，目标视图平移（横向向左）*/
    GXAnimationStylePushEdgeLeft,
    /**当前视图与目标视图同时平移（横向向左）*/
    GXAnimationStylePushAllLeft,
    /**当前视图与目标视图同时平移（纵向向上）*/
//    GXAnimationStylePushAllTop,
    /**当前视图与目标视图同时平移（纵向向下）*/
//    GXAnimationStylePushAllBottom,
    /**目标视图扇形旋转*/
//    GXAnimationStyleSector,
    /**目标视图扇侧立遮盖*/
//    GXAnimationStyleErect,
    /**当前视图与目标视图呈立方体旋转（横向左）*/
//    GXAnimationStyleCubeLeft,
    /**当前视图与目标视图呈立方体旋转（横向右）*/
//    GXAnimationStyleCubeRight,
    /**当前视图与目标视图呈正反面旋转（横向）*/
//    GXAnimationStyleOglFlip,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GXTransitionDelegate)

@property (nonatomic, strong) GXAnimationBaseDelegate *gx_animatedDelegate;

- (void)pushViewController:(UIViewController *)viewController style:(GXAnimationStyle)style interacting:(BOOL)interacting;

- (void)presentViewController:(UIViewController *)viewControllerToPresent style:(GXAnimationStyle)style interacting:(BOOL)interacting completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
