//
//  NSString+JHKFormat.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JHKFormat)
+ (instancetype)stringWithInteger:(NSInteger)value numberStyle:(NSNumberFormatterStyle)nstyle;
+ (instancetype)stringWithFloat:(CGFloat)value numberStyle:(NSNumberFormatterStyle)nstyle;
//+ (NSString *)stringWithFloat:(CGFloat)value;

+ (NSString *)formatPrice:(CGFloat)price;
+ (NSString *)formatRMBPrice:(CGFloat)price;
+ (NSString *)formatRMBPriceWithSpace:(CGFloat)price;

/**
 *添加 ¥ 符号并缩小符号的字体
 */
+ (NSMutableAttributedString *)formatRMBPriceToAttr:(CGFloat)price;

// 16进制 <==> 字符串
- (NSString *)stringWithHexNumber:(NSUInteger)hexNumber;
- (NSInteger)numberWithHexString:(NSString *)hexString;

- (NSMutableAttributedString*)deleteLineFromLabel;
- (NSRange)getTextRange:(NSString*)text;

///截取字符串
+ (NSString*)subTextString:(NSString*)str len:(NSInteger)len;
/**计算字符串高度*/
+ (CGFloat)stringHeightWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
+ (CGFloat)stringHeightWithText:(NSString *)text font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing maxSize:(CGSize)maxSize;

+ (CGFloat)stringWidthWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

///行间距富文本
+ (NSAttributedString *)attrStringWithString:(NSString*)string textAlignment:(NSTextAlignment)alignment font:(UIFont*)font textColor:(UIColor*)color lineSpacing:(CGFloat)lineSpacing;

@end

NS_ASSUME_NONNULL_END
