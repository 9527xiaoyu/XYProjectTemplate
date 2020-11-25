//
//  JHKAppSetting.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "JHKAppSetting.h"
#import "JHKHelper.h"
#import "AppDelegate.h"

@implementation JHKAppSetting

+ (void)buildVersion
{
    
    if ([jhkAppDelegate isFirstLaunch]) {
#ifdef DEBUG
        BOOL debugFlag = YES;
        NSString *debug = @"Debug";
#else
        BOOL debugFlag = NO;
        NSString *debug = @"Release";
#endif
        [[NSUserDefaults standardUserDefaults] setObject:@(debugFlag) forKey:@"debug_mode_on"];
        [[NSUserDefaults standardUserDefaults] setObject:debug forKey:@"distribution_mode"];
        
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"version_preference"];
        
        NSString *build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults] setObject:build forKey:@"build_preference"];
        
        NSString *githash = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"GITHash"];
        [[NSUserDefaults standardUserDefaults] setObject:githash forKey:@"githash_preference"];
        
        NSString *uuid = [fn uuid];
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"uuid_preference"];
    }
}

+ (BOOL)couldDebug
{
    BOOL debug_mode_on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"debug_mode_on"] boolValue];
    return debug_mode_on;
}

+ (BOOL)isDebug
{
    // 加上开关启动
    BOOL debug_mode_on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"debug_mode_on"] boolValue];
    BOOL debug_cmd_on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"debug_cmd_on"] boolValue];
    
    return debug_mode_on && debug_cmd_on;
}

+ (BOOL)isNewVersion
{
    //版本号key
    NSString *key = @"CFBundleShortVersionString";
    //当前最新应用的版本号
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
    
    //沙盒中存储的登录过的应用版本号
    NSString *savedVersion=  [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    //判断是否第一次进入当前版本
    if([version isEqualToString:savedVersion])
    {
        return NO;
    }
    
    //保存版本号
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

+ (void)makeFirstUsed:(NSString *)name
{
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:name];
}

+ (BOOL)isFirstUse:(NSString *)name
{
    NSNumber *used = [[NSUserDefaults standardUserDefaults] objectForKey:name];
    return ![used boolValue];
}

+ (BOOL)firstUse:(NSString *)name
{
    if ([self isFirstUse:name]) {
        [self makeFirstUsed:name];
        return YES;
    }
    return NO;
}

@end
