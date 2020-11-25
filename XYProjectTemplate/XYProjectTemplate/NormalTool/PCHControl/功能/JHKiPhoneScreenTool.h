//
//  JHKiPhoneScreenTool.h
//  XYProjectTemplate
//
//  Created by 杨晓宇 on 2020/11/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHKiPhoneScreenTool : NSObject

+ (NSString*)JHKDeviceVersion;
+ (BOOL)JHKDeviceVersionIsIphoneX;
/// 导航栏高度,iOS任何设备,导航栏高度都是44
+ (NSInteger )JHKNaviBarHeight;
// 状态栏高度X 11 系列 44 ;其他 20
+ (NSInteger )JHKStatusBarHeight;
+ (NSInteger )JHKiphoneTopHeight;
/// 宽
+ (NSInteger )JHkScreenWidthidth;
/// 高
+ (NSInteger )JHKScreenHeight;
@end

NS_ASSUME_NONNULL_END
