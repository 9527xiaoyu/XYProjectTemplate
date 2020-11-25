//
//  PhoneNormal.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#ifndef PhoneNormal_h
#define PhoneNormal_h

#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//弱引用
#define WEAKSELF __weak typeof(self) __weakSelf = self;
//强引用--配合 WEAKSELF 使用
#define STRONGSELF __strong typeof(__weakSelf) strongSelf = __weakSelf

#define kNavigationHeight 44
#define kTabBarNavigationHeight 49
#define kIPhoneXBottomHeight 39

// 状态栏(statusbar)
#define kStatus13Rect [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame
#define kStatusRect [[UIApplication sharedApplication] statusBarFrame]

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kWScale (kScreenWidth/375.0)
#define kWidth(value) value*kWScale

#define kScreenScale [UIScreen mainScreen].scale

#define IOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] doubleValue]<8.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)


#define SCREEN_MAX_LENGTH (MAX(kScreenWidth, kScreenH))
#define SCREEN_MIN_LENGTH (MIN(kScreenWidth, kScreenH))

//#define IS_IPHONE_4_OR_LESS     (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
//#define IS_IPHONE_5             (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
//#define IS_IPHONE_5_OR_LESS     (IS_IPHONE && SCREEN_MAX_LENGTH < 667.0)
#define IS_IPHONE_6             (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P            (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
//#define IS_IPHONE_6_OR_MORE     (IS_IPHONE && SCREEN_MAX_LENGTH >= 667.0)
//#define IS_IPHONE_6P_OR_MORE    (IS_IPHONE && SCREEN_MAX_LENGTH >= 736.0)
#define IS_IPHONE_X_OR_MORE     (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)
#define IS_IPHONE_X             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_Xr            ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_Xs_Max        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208),[[UIScreen mainScreen] currentMode].size) : NO)

#endif /* PhoneNormal_h */
