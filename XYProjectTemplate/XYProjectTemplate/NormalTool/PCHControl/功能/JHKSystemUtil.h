//
//  JHKSystemUtil.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 日间 或 夜间
typedef NS_ENUM(NSInteger, KTAnswerDayOrNight) {
    KTAnswerDay = 0,
    KTAnswerNight
};

@interface JHKSystemUtil : NSObject
+ (void)alertOpenAPNs:(NSString *)msg withAction:(void (^)(void))callback;
+ (void)isOpenAPNs:(NSString *)msg withAction:(void (^)(void))callback;
+ (void)isOpenAPNsWithAction:(void (^)(void))action;
+ (BOOL)isOpenAPNs:(NSString *)msg;

+ (BOOL)canOpenSystemCamera;
+ (BOOL)canOpenSystemMicroPhone;

+ (BOOL)canOpenSystemSettingView;

+ (void)systemSettingView;
@end

NS_ASSUME_NONNULL_END
