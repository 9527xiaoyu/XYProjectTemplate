//
//  JHKAlertTool.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHKAlertTool : NSObject
/**普通的弹窗，不需要处理点击事件*/
+ (void)normalLeeAlertWithTitle:(NSString*)title content:(NSString*)content cancelBtn:(NSString*)cancelName;
/**普通的弹窗，处理点击确认键的事件*/
+ (void)normalLeeAlertWithTitle:(NSString*)title content:(NSString*)content cancelBtn:(NSString*)cancelName sureBtn:(NSString*)sureName sureHandler:(void (^)(void))sureBlock;
@end

NS_ASSUME_NONNULL_END
