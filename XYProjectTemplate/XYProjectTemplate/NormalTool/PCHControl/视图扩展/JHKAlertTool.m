//
//  JHKAlertTool.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/11/9.
//

#import "JHKAlertTool.h"

@implementation JHKAlertTool

/**普通的弹窗，不需要处理点击事件*/
+ (void)normalLeeAlertWithTitle:(NSString*)title content:(NSString*)content cancelBtn:(NSString*)cancelName
{
    [LEEAlert alert].config
    .LeeTitle(title)
    .LeeContent(content)
    .LeeCancelAction(cancelName, ^{
        
    }).LeeShow();
}

+ (void)normalLeeAlertWithTitle:(NSString*)title content:(NSString*)content cancelBtn:(NSString*)cancelName sureBtn:(NSString*)sureName sureHandler:(void (^)(void))sureBlock
{
    [LEEAlert alert].config.LeeTitle(title)
    .LeeContent(content)
    .LeeCancelAction(cancelName, ^{
        
    })
    .LeeAction(sureName, ^{
        executeBlock(sureBlock);
    }).LeeShow();
}
@end
