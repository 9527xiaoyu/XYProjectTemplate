//
//  JHKSystemUtil.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "JHKSystemUtil.h"
#import "JHKAppSetting.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "UIWindow+ZFCurrentViewController.h"

#define IS_VAILABLE_IOS8  ([[[UIDevice currentDevice] systemVersion] intValue] >= 8)

@implementation JHKSystemUtil

+ (void)alertOpenAPNs:(NSString *)msg withAction:(nonnull void (^)(void))callback
{
    BOOL isOpen = [self isOpenAPNs:msg];
    if(!isOpen){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")) {
            [JHKAlertTool normalLeeAlertWithTitle:@"推送权限受限" content:msg cancelBtn:@"好" sureBtn:@"去设置" sureHandler:^{
                if ([JHKSystemUtil canOpenSystemSettingView]) {
                    [JHKSystemUtil systemSettingView];
                }
                executeBlock(callback);
            }];
        } else {
            [JHKAlertTool normalLeeAlertWithTitle:@"推送权限受限" content:msg cancelBtn:@"好的"];
            executeBlock(callback);
        }
    }else{
        executeBlock(callback);
    }
}

+ (void)isOpenAPNs:(NSString *)msg withAction:(nonnull void (^)(void))callback
{
    BOOL isOpen = [self isOpenAPNs:msg];
    if(!isOpen && [JHKAppSetting firstUse:kFirstUseAPNs]){
        [self alertOpenAPNs:msg withAction:callback];
    }else{
        executeBlock(callback);
    }
}

+ (void)isOpenAPNsWithAction:(void (^)(void))action
{
    [self isOpenAPNs:@"请允许我们推送消息，以便您及时获取金护考优惠和艺术资讯." withAction:action];
}

+ (BOOL)isOpenAPNs:(NSString *)msg
{
    BOOL isOpen = NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (setting.types != UIUserNotificationTypeNone) {
        isOpen = YES;
    }
#else
    UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    if (type != UIRemoteNotificationTypeNone) {
        isOpen = YES;
    }if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")) {
        [JHKAlertTool normalLeeAlertWithTitle:@"推送权限受限" content:msg cancelBtn:@"好" sureBtn:@"去设置" sureHandler:^{
            if ([JHKSystemUtil canOpenSystemSettingView]) {
                [JHKSystemUtil systemSettingView];
            }
        }];
    } else {
        [JHKAlertTool normalLeeAlertWithTitle:@"推送权限受限" content:msg cancelBtn:@"好的"];
    }
#endif
    return isOpen;
}

+ (BOOL)canOpenSystemCamera
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [JHKAlertTool normalLeeAlertWithTitle:NSLocalizedString(@"noCamera", nil) content:NSLocalizedString(@"noCameraMsg", nil) cancelBtn:@"好的"];
        return NO;
    }
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusDenied){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")) {
            [JHKAlertTool normalLeeAlertWithTitle:@"相机权限受限" content:@"请在iPhone的\"设置->隐私->相机\"选项中,允许\"金护考\"访问您的相机." cancelBtn:@"好的" sureBtn:@"去设置" sureHandler:^{
                if ([JHKSystemUtil canOpenSystemSettingView]) {
                    [JHKSystemUtil systemSettingView];
                }
            }];
        } else {
            [JHKAlertTool normalLeeAlertWithTitle:@"相机权限受限" content:@"请在iPhone的\"设置->隐私->相机\"选项中,允许\"金护考\"访问您的相机." cancelBtn:@"好的"];
        }
        
        return NO;
    };
    return YES;
}

+ (BOOL)canOpenSystemMicroPhone
{
    AVAuthorizationStatus microPhoneStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    BOOL result = YES;
    switch (microPhoneStatus) {
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
        {
            // 被拒绝
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")) {
                [JHKAlertTool normalLeeAlertWithTitle:@"麦克风权限受限" content:@"请在iPhone的\"设置->隐私->麦克风\"选项中,允许\"金护考\"访问您的麦克风." cancelBtn:@"好的" sureBtn:@"去设置" sureHandler:^{
                        if ([JHKSystemUtil canOpenSystemSettingView]) {
                            [JHKSystemUtil systemSettingView];
                        }
                }];
            } else {
                [JHKAlertTool normalLeeAlertWithTitle:@"麦克风权限受限" content:@"请在iPhone的\"设置->隐私->麦克风\"选项中,允许\"金护考\"访问您的麦克风." cancelBtn:@"好的"];
            }
            result = NO;
        }
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            // 未知状态，申请授权
            result = YES;
        }
            break;
        case AVAuthorizationStatusAuthorized:
        {
            // 有授权
            result = YES;
        }
            break;

        default:
            break;
    }
    
    return result;
}

/**
 *  是否可以打开设置页面
 *
 *  @return openSysSetting
 */
+ (BOOL)canOpenSystemSettingView
{
    if (IS_VAILABLE_IOS8) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

/**
 *  跳到系统设置页面
 */
+ (void)systemSettingView
{
    if (IS_VAILABLE_IOS8) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}
@end
