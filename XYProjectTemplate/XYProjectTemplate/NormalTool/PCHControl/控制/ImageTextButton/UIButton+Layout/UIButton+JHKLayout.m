//
//  UIButton+JHKLayout.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "UIButton+JHKLayout.h"
#import <objc/runtime.h>

@implementation UIButton (JHKLayout)

+ (void)load
{
    MethodSwizzle(self,@selector(titleRectForContentRect:),@selector(override_titleRectForContentRect:));
    MethodSwizzle(self,@selector(imageRectForContentRect:),@selector(override_imageRectForContentRect:));
}

void MethodSwizzle(Class c,SEL origSEL,SEL overrideSEL)
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod= class_getInstanceMethod(c, overrideSEL);
    
    if(class_addMethod(c, origSEL, method_getImplementation(overrideMethod),method_getTypeEncoding(overrideMethod)))
    {
        class_replaceMethod(c,overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        method_exchangeImplementations(origMethod,overrideMethod);
    }
}
      
- (CGRect)override_titleRectForContentRect:(CGRect)contentRect
{
    CGRect titleRect = self.titleRect;
    
    if (self.layoutStyle & UIButtonLayoutAlignHorizonal) {
        titleRect.origin.x = (contentRect.size.width - titleRect.size.width)/2;
    }else if (self.layoutStyle & UIButtonLayoutAlignVertical){
        titleRect.origin.y = (contentRect.size.height - titleRect.size.height)/2;
    }
    
    if (!CGRectIsEmpty(titleRect) && !CGRectEqualToRect(titleRect, CGRectZero)) {
        return titleRect;
    }
    
    return [self override_titleRectForContentRect:contentRect];
}

- (CGRect)override_imageRectForContentRect:(CGRect)contentRect
{
    CGRect imageRect = self.imageRect;
    
    if (self.layoutStyle & UIButtonLayoutAlignHorizonal) {
        imageRect.origin.x = (contentRect.size.width - imageRect.size.width)/2;
    }else if (self.layoutStyle & UIButtonLayoutAlignVertical){
        imageRect.origin.y = (contentRect.size.height - imageRect.size.height)/2;
    }
    
    if (!CGRectIsEmpty(imageRect) && !CGRectEqualToRect(imageRect, CGRectZero)) {
        return imageRect;
    }
    return [self override_imageRectForContentRect:contentRect];
}

#pragma mark - getter & setter

- (CGRect)titleRect
{
    return [objc_getAssociatedObject(self, @selector(titleRect)) CGRectValue];
}

- (void)setTitleRect:(CGRect)rect
{
    objc_setAssociatedObject(self, @selector(titleRect), [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)imageRect
{
    NSValue * rectValue = objc_getAssociatedObject(self, @selector(imageRect));
    return [rectValue CGRectValue];
}

- (void)setImageRect:(CGRect)rect
{
    objc_setAssociatedObject(self, @selector(imageRect), [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

- (UIButtonLayoutAlign)layoutStyle
{
    return [objc_getAssociatedObject(self, @selector(layoutStyle)) integerValue];
}

- (void)setLayoutStyle:(UIButtonLayoutAlign)layoutStyle
{
    objc_setAssociatedObject(self, @selector(layoutStyle), @(layoutStyle), OBJC_ASSOCIATION_RETAIN);
}

@end
