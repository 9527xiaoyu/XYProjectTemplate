//
//  JHKViewFormatFactory.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHKViewFormatFactory : NSObject

+ (CGSize)formatLabelSize:(CGSize)size text:(NSString *)text fontSize:(CGFloat)fontSize lineHeight:(CGFloat)lineHeight;
+ (CGSize)formatLabelSize:(CGSize)size text:(NSString *)text font:(UIFont *)font lineHeight:(CGFloat)lineHeight alignment:(NSTextAlignment)alignment lineBreakMode:(NSLineBreakMode)lineBreakMode;
+ (NSMutableAttributedString *)formatLabel:(UILabel *)label withText:(NSString *)text fontSize:(CGFloat)fontSize lineHeight:(CGFloat)lineHeight;
+ (NSMutableAttributedString *)getFormatLabelString:(UILabel *)label withText:(NSString *)text fontSize:(CGFloat)fontSize lineHeight:(CGFloat)lineHeight;

+ (CGSize)getSize:(CGSize)size withString:(NSMutableAttributedString *)attributedString;

/**
 *  @author jhk, 16-07-27 22:07:24
 *
 *  @brief 黑底白字
 *
 */
+ (void)formatImportanceButton:(UIButton *)btn;
+ (void)formatButton:(UIButton *)btn;

/**
 *  @author jhk, 16-09-13 10:09:58
 *
 *  @brief 主要是为了根据规范更改border透明度色，需要主动调用。
 *
 *  @param btn 需要主动更改border颜色的按钮
 *
 *  @since 0.8.3
 */
+ (void)changeButtonBorder:(UIButton *)btn;
+ (void)changeImportanceButtonBorder:(UIButton *)btn;

+ (UIButton *)underLineButton:(NSString *)text WithTextSize:(CGFloat)size;

+ (void)printAllSystemFontName;
@end

NS_ASSUME_NONNULL_END
