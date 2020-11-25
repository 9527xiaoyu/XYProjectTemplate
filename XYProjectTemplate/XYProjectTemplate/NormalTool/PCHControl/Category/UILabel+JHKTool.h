//
//  UILabel+JHKTool.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (JHKTool)

@property (nonatomic,strong) IBInspectable NSString *fontAttr;
@property (nonatomic) NSString *verticalText;

- (CGFloat)fitLabelWidth;
- (CGFloat)fitLabelHeight;

- (void)jhk_addTapGestureWithTarget:(id)target action:(SEL)action;
+ (instancetype)jhk_labelWithText:(NSString*)text textColor:(UIColor*)color font:(UIFont*)font textAlignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberLine backgroundColor:(UIColor*)backColor;
@end

NS_ASSUME_NONNULL_END
