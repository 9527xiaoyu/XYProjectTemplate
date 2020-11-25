//
//  UIView+JHKLayout.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "UIView+JHKLayout.h"

@implementation UIView (JHKLayout)
- (CGFloat)jhk_top
{
    return self.frame.origin.y;
}

- (void)setJhk_top:(CGFloat)jhk_top
{
    CGRect frame = self.frame;
    frame.origin.y = jhk_top;
    self.frame = frame;
}

- (CGFloat)jhk_left
{
    return self.frame.origin.x;
}

- (void)setJhk_left:(CGFloat)jhk_left
{
    CGRect frame = self.frame;
    frame.origin.x = jhk_left;
    self.frame = frame;
}

- (CGFloat)jhk_bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setJhk_bottom:(CGFloat)jhk_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = jhk_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)jhk_right
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setJhk_right:(CGFloat)jhk_right
{
    CGRect frame = self.frame;
    frame.origin.x = jhk_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)jhk_x
{
    return self.frame.origin.x;
}

- (void)setJhk_x:(CGFloat)jhk_x
{
    CGRect frame = self.frame;
    frame.origin.x = jhk_x;
    self.frame = frame;
}

- (CGFloat)jhk_y
{
    return self.frame.origin.y;
}

- (void)setJhk_y:(CGFloat)jhk_y
{
    CGRect frame = self.frame;
    frame.origin.y = jhk_y;
    self.frame = frame;
}

- (CGPoint)jhk_origin
{
    return self.frame.origin;
}

- (void)setJhk_origin:(CGPoint)jhk_origin
{
    CGRect frame = self.frame;
    frame.origin = jhk_origin;
    self.frame = frame;
}

- (CGFloat)jhk_centerX
{
    return self.center.x;
}

- (void)setJhk_centerX:(CGFloat)jhk_centerX
{
    CGPoint center = self.center;
    center.x = jhk_centerX;
    self.center = center;
}

- (CGFloat)jhk_centerY
{
    return self.center.y;
}

- (void)setJhk_centerY:(CGFloat)jhk_centerY
{
    CGPoint center = self.center;
    center.y = jhk_centerY;
    self.center = center;
}

- (CGFloat)jhk_width
{
    return self.frame.size.width;
}

- (void)setJhk_width:(CGFloat)jhk_width
{
    CGRect frame = self.frame;
    frame.size.width = jhk_width;
    self.frame = frame;
}

- (CGFloat)jhk_height
{
    return self.frame.size.height;
}

- (void)setJhk_height:(CGFloat)jhk_height
{
    CGRect frame = self.frame;
    frame.size.height = jhk_height;
    self.frame = frame;
}

- (CGSize)jhk_size
{
    return self.frame.size;
}

- (void)setJhk_size:(CGSize)jhk_size
{
    CGRect frame = self.frame;
    frame.size = jhk_size;
    self.frame = frame;
}
@end
