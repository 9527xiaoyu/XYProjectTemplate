//
//  JHKAppSetting.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kFirstUseAPNs @"kFirstUseAPNs"

@interface JHKAppSetting : NSObject

+ (void)buildVersion;
+ (BOOL)couldDebug;
+ (BOOL)isDebug;
+ (BOOL)isNewVersion;

+ (void)makeFirstUsed:(NSString *)name;
+ (BOOL)isFirstUse:(NSString *)name;
+ (BOOL)firstUse:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
