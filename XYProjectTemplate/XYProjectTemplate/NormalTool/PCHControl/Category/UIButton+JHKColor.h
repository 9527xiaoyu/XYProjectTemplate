//
//  UIButton+JHKColor.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (JHKColor)

- (void)setButtonColor:(UIColor *)colorNormal;
/**
 *设置背景色
 */
- (void)setButtonColor:(UIColor *)color forState:(UIControlState)state;

- (void)setButtonColor:(UIColor *)colorNormal highLightColor:(UIColor *)colorHightlighted;

@end

NS_ASSUME_NONNULL_END
