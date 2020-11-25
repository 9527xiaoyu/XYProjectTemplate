//
//  AppDelegate+JHKExtension.h
//  XYProjectTemplate
//
//  Created by 杨晓宇 on 2020/11/25.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (JHKExtension)
+ (AppDelegate*)delegate;
- (BOOL)isFirstLaunch;
/**
 *  横屏
 */
@property (assign , nonatomic) BOOL isForceLandscape;

/**
 *  竖屏
 */
@property (assign , nonatomic) BOOL isForcePortrait;

@end

NS_ASSUME_NONNULL_END
