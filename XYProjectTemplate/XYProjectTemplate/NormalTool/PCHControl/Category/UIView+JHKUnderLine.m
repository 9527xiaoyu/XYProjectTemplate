//
//  UIView+JHKUnderLine.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "UIView+JHKUnderLine.h"
#import <objc/runtime.h>

@implementation UIView (JHKUnderLine)

-(void)drawUnderLine:(CGContextRef)ctx rect:(CGRect)rect
{
    CGContextSetStrokeColorWithColor(ctx, self.underLineColor.CGColor);
    CGContextSetLineWidth(ctx, 1.0);
    
    if (self.underLineType & UnderLineTypeUp) {
        [self drawUp:ctx withRect:rect];
    }
    
    if (self.underLineType & UnderLineTypeDown) {
        [self drawDown:ctx withRect:rect];
    }
    
    if (self.underLineType & UnderLineTypeLeft) {
        [self drawLeft:ctx withRect:rect];
    }
    
    if (self.underLineType & UnderLineTypeRight) {
        [self drawRight:ctx withRect:rect];
    }
}

- (void)drawLeft:(CGContextRef)con withRect:(CGRect)rect
{
    CGFloat xOff = 1;
    
    CGPoint from = CGPointMake(rect.origin.x + xOff, rect.origin.y);
    CGPoint to = CGPointMake(rect.origin.x + xOff, rect.origin.y + rect.size.height);
    
    [self drawLine:con from:from to:to];
}

- (void)drawRight:(CGContextRef)con withRect:(CGRect)rect
{
    CGFloat xOff = rect.origin.x + rect.size.width - 1;
    
    CGPoint from = CGPointMake(rect.origin.x + xOff, rect.origin.y);
    CGPoint to = CGPointMake(rect.origin.x + xOff, rect.origin.y + rect.size.height);
    
    [self drawLine:con from:from to:to];
}

- (void)drawUp:(CGContextRef)con withRect:(CGRect)rect
{
    CGFloat yOff = 0.5;
    
    CGPoint from = CGPointMake(rect.origin.x, yOff);
    CGPoint to = CGPointMake(rect.origin.x + rect.size.width, yOff);
    
    [self drawLine:con from:from to:to];
}

- (void)drawDown:(CGContextRef)con withRect:(CGRect)rect
{
    CGFloat yOff = rect.origin.y + rect.size.height - 0.5;
    
    CGPoint from = CGPointMake(rect.origin.x, yOff);
    CGPoint to = CGPointMake(rect.origin.x + rect.size.width, yOff);
    
    [self drawLine:con from:from to:to];
}

- (void)drawLine:(CGContextRef)con from:(CGPoint)from to:(CGPoint)to
{
    CGContextMoveToPoint(con, from.x, from.y);
    CGContextAddLineToPoint(con, to.x, to.y);
    CGContextStrokePath(con);
}

- (UnderLineType)underLineType
{
    NSNumber *type = objc_getAssociatedObject(self, @selector(underLineType));
    return [type unsignedIntegerValue];
}

- (void)setUnderLineType:(UnderLineType)underLineType
{
    NSNumber *type = [NSNumber numberWithUnsignedInteger:underLineType];
    objc_setAssociatedObject(self, @selector(underLineType), type, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)underLineColor
{
    return objc_getAssociatedObject(self, @selector(underLineColor));;
}

- (void)setUnderLineColor:(UIColor *)underLineColor
{
    objc_setAssociatedObject(self, @selector(underLineColor), underLineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
