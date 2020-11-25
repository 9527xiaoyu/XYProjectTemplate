//
//  NSString+JHKFormat.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "NSString+JHKFormat.h"

@implementation NSString (JHKFormat)

//目前用来千分号（显示钱的数字样式）
+ (instancetype)stringWithInteger:(NSInteger)value numberStyle:(NSNumberFormatterStyle)nstyle
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = nstyle;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInteger:value]];
    return string;
}

+ (instancetype)stringWithFloat:(CGFloat)value numberStyle:(NSNumberFormatterStyle)nstyle{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = nstyle;
    formatter.roundingMode = NSNumberFormatterRoundCeiling;
    int digits = [self showFractionDigits:value];
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = digits;
    CGFloat doubleValue = floor(value*1000)*1.0/1000;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithDouble:doubleValue]];
    return string;
}

//+ (NSString *)stringWithFloat:(CGFloat)value
//{
//    NSString *doubleString = [NSString stringWithFormat:@"%.2f", value];
//    if (![self showFractionDigits:value]) {
//        doubleString = [NSString stringWithFormat:@"%.0f", value];
//    }
//    return doubleString;
//}

+ (NSString *)formatPrice:(CGFloat)price
{
    return [NSString stringWithFloat:price numberStyle:NSNumberFormatterDecimalStyle];
}

+ (NSString *)formatRMBPrice:(CGFloat)price
{
    NSString *priceStr = [NSString stringWithFloat:price numberStyle:NSNumberFormatterDecimalStyle];
    return [NSString stringWithFormat:@"¥%@",priceStr];
}

+ (NSString *)formatRMBPriceWithSpace:(CGFloat)price
{
    NSString *priceStr = [NSString stringWithFloat:price numberStyle:NSNumberFormatterDecimalStyle];
    return [NSString stringWithFormat:@"¥ %@",priceStr];
}

+ (NSMutableAttributedString *)formatRMBPriceToAttr:(CGFloat)price
{
    NSString *priceStr = nsstrformatcat(@"¥%.2f",price);//[NSString stringWithFloat:price numberStyle:NSNumberFormatterDecimalStyle];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [attri addAttributes:@{NSFontAttributeName:kFont(nF5_12)} range:NSMakeRange(0, 1)];
    return attri;
}

// 补全价格的小数位,整数显示为整数，小数显示为2位小数
+ (int)showFractionDigits:(CGFloat)n
{
    int i = (int)(n*1000)%1000;
    
    if(i==0){
        return 0;
    }else {
        return 2;
    }
}

+ (NSString *)getFractionDigits:(CGFloat)n
{
    CGFloat num1,num2;
    int i,j;
    
    num1=(int)(n*100+0.5);
    num2=num1/100;
    
    i=(int)num1%100;
    j=(int)num2%100;
    
    if(i==0 && j==0){
        return [NSString stringWithFormat:@"%d",(int)num2];
    }else {
        return [NSString stringWithFormat:@"%.2f",num2];
    }
}

- (NSString *)stringWithHexNumber:(NSUInteger)hexNumber{
    char hexChar[6];
    sprintf(hexChar, "%x", (int)hexNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    return hexString;
}

- (NSInteger)numberWithHexString:(NSString *)hexString{
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    sscanf(hexChar, "%x", &hexNumber);
    return (NSInteger)hexNumber;
}

- (NSMutableAttributedString *)deleteLineFromLabel
{
    NSUInteger length = [self length];
    //从这里开始就是设置富文本的属性
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self];
    [attri addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:nC6_999999} range:NSMakeRange(0, length)];
    return attri;
}

- (NSRange)getTextRange:(NSString*)text
{
    return [self rangeOfString:text];
}

+ (NSString*)subTextString:(NSString*)str len:(NSInteger)len
{
    if(str.length<=len)return str;
    int count=0;
    NSMutableString *sb = [NSMutableString string];
    for (int i=0; i<str.length; i++) {
        NSRange range = NSMakeRange(i, 1) ;
        NSString *aStr = [str substringWithRange:range];
        count += [aStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding]>1?2:1;
        [sb appendString:aStr];
        if(count >= len*2) {
            return (i==str.length-1)?[sb copy]:[NSString stringWithFormat:@"%@",[sb copy]];
        }
    }
    return str;
}

+ (CGFloat)stringHeightWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGFloat height = [text boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height+3;
    return height;
}

+ (CGFloat)stringHeightWithText:(NSString *)text font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing maxSize:(CGSize)maxSize {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *attrs = @{NSFontAttributeName : font,NSParagraphStyleAttributeName:paragraphStyle};
    CGFloat height = [text boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height+3;
    return height;
}

+ (CGFloat)stringWidthWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGFloat height = [text boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width+3;
    return height;
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (NSAttributedString *)attrStringWithString:(NSString*)string textAlignment:(NSTextAlignment)alignment font:(UIFont*)font textColor:(UIColor*)color lineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.alignment = alignment;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string attributes: @{NSFontAttributeName: font,NSForegroundColorAttributeName: color,NSParagraphStyleAttributeName:paragraphStyle}];
    return attrString;
}

@end
