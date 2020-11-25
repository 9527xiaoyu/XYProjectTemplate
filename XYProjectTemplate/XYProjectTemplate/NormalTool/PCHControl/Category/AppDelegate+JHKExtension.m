//
//  AppDelegate+JHKExtension.m
//  XYProjectTemplate
//
//  Created by 杨晓宇 on 2020/11/25.
//

#import "AppDelegate+JHKExtension.h"
#import <objc/runtime.h>

@implementation AppDelegate (JHKExtension)
+ (AppDelegate *)delegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (BOOL)isFirstLaunch
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"jhk_firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jhk_firstLaunch"];
        return YES;
    }
    return NO;
}

#pragma mark - ==================== setter & getter ============================
- (BOOL)isForceLandscape
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsForceLandscape:(BOOL)isForceLandscape
{
    objc_setAssociatedObject(self, _cmd, @(isForceLandscape), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isForcePortrait
{
    return [objc_getAssociatedObject(self, _cmd)boolValue];
}

- (void)setIsForcePortrait:(BOOL)isForcePortrait
{
    objc_setAssociatedObject(self, _cmd, @(isForcePortrait), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
