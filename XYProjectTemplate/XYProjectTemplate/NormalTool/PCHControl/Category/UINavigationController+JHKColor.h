//
//  UINavigationController+JHKColor.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (JHKColor)
-(void)changeBackgroundColor:(UIColor *)color;
-(void)changeTitleColor:(UIColor *)color;
-(void)changeFontSize:(CGFloat)size;
@end

NS_ASSUME_NONNULL_END
