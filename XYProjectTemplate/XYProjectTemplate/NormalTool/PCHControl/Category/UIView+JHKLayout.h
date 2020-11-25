//
//  UIView+JHKLayout.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JHKLayout)
@property (assign, nonatomic) CGFloat    jhk_top;
@property (assign, nonatomic) CGFloat    jhk_bottom;
@property (assign, nonatomic) CGFloat    jhk_left;
@property (assign, nonatomic) CGFloat    jhk_right;

@property (assign, nonatomic) CGFloat    jhk_x;
@property (assign, nonatomic) CGFloat    jhk_y;
@property (assign, nonatomic) CGPoint    jhk_origin;

@property (assign, nonatomic) CGFloat    jhk_centerX;
@property (assign, nonatomic) CGFloat    jhk_centerY;

@property (assign, nonatomic) CGFloat    jhk_width;
@property (assign, nonatomic) CGFloat    jhk_height;
@property (assign, nonatomic) CGSize    jhk_size;
@end

NS_ASSUME_NONNULL_END
