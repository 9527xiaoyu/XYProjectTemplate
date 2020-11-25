//
//  JHKPointInsideButton.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "JHKPointInsideButton.h"

@implementation JHKPointInsideButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return self;
    }
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat radius = 44.0;
    if (self.sizeType == ButtonSizeTypeCenter) {
        radius = 60.0;
    }else if(self.sizeType == ButtonSizeTypeBig){
        radius = 80.0;
    }
    
    CGFloat widthDelta = MAX(radius - bounds.size.width, 0);
    CGFloat heightDelta = MAX(radius - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
