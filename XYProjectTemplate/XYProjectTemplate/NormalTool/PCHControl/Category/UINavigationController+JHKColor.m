//
//  UINavigationController+JHKColor.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "UINavigationController+JHKColor.h"

@implementation UINavigationController (JHKColor)
-(void)changeBackgroundColor:(UIColor *)color
{
    if (@available(iOS 13.0, *)) {
        self.navigationBar.standardAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:color};
        self.navigationBar.standardAppearance.backgroundColor = color;
    }else{
        self.navigationBar.barTintColor = color;
        self.navigationBar.backgroundColor = color;
    }
    self.navigationBar.translucent = NO;
}

-(void)changeTitleColor:(UIColor *)color
{
    if (@available(iOS 13.0, *)) {
        [self.navigationBar.standardAppearance setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
    }else{
     [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
    }
}

-(void)changeFontSize:(CGFloat)size
{
    if (@available(iOS 13.0, *)) {
        [self.navigationBar.standardAppearance setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]}];
    }else{
     [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]}];
    }
}

@end
