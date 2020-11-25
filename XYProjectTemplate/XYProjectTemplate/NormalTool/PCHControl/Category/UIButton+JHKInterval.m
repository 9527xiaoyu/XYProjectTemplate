//
//  UIButton+JHKInterval.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "UIButton+JHKInterval.h"
#import <objc/runtime.h>

@interface UIButton()

@property (nonatomic, strong) NSNumber *uxy_ignoreEvent;   // 用这个给重复点击加间隔

@end

@implementation UIButton (JHKInterval)

- (NSTimeInterval)uxy_acceptEventInterval
{
    NSTimeInterval interval = [objc_getAssociatedObject(self, @selector(uxy_acceptEventInterval)) doubleValue];
    return interval;
}

- (void)setUxy_acceptEventInterval:(NSTimeInterval)uxy_ignoreEvent
{
    objc_setAssociatedObject(self, @selector(uxy_acceptEventInterval), @(uxy_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)uxy_ignoreEvent
{
    return objc_getAssociatedObject(self, @selector(uxy_ignoreEvent));
}

- (void)setUxy_ignoreEvent:(NSNumber *)uxy_ignoreEvent
{
    objc_setAssociatedObject(self, @selector(uxy_ignoreEvent), uxy_ignoreEvent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
//    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//    Method b = class_getInstanceMethod(self, @selector(__uxy_sendAction:to:forEvent:));
//    method_exchangeImplementations(a, b);
}

- (void)__uxy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (![self respondsToSelector:@selector(uxy_ignoreEvent)]) {
        [self __uxy_sendAction:action to:target forEvent:event];
        return;
    }
    if ([self.uxy_ignoreEvent boolValue]) return;
    if (self.uxy_acceptEventInterval > 0)
    {
        self.uxy_ignoreEvent = @(YES);
        [self performSelector:@selector(setUxy_ignoreEvent:) withObject:@(NO) afterDelay:self.uxy_acceptEventInterval];
    }
    [self __uxy_sendAction:action to:target forEvent:event];
}

@end
