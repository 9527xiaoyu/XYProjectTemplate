//
//  UIButton+JHKColor.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "UIButton+JHKColor.h"

@implementation UIButton (JHKColor)

- (void)setButtonColor:(UIColor *)colorNormal
{
    // 设置背景颜色
    UIImage *img = [self imageWithColor:colorNormal];
    [self setBackgroundImage:img forState:UIControlStateNormal];
}

- (void)setButtonColor:(UIColor *)colorNormal forState:(UIControlState)state
{
    // 设置背景颜色
    UIImage *img = [self imageWithColor:colorNormal];
    [self setBackgroundImage:img forState:state];
}

- (void)setButtonColor:(UIColor *)colorNormal highLightColor:(UIColor *)colorHightlighted
{
    // 设置背景颜色
    UIImage *img = [self imageWithColor:colorNormal];
    [self setBackgroundImage:img forState:UIControlStateNormal];
    
    // 设置高亮颜色
    UIImage *pressedColorImg = [self imageWithColor:colorHightlighted];
    [self setBackgroundImage:pressedColorImg forState:UIControlStateHighlighted];
}

- (UIImage*)imageWithColor:(UIColor*)colorNormal
{
    CGSize size = self.frame.size;
    UIGraphicsBeginImageContextWithOptions(size, 0, kScreenScale);
    [colorNormal set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
