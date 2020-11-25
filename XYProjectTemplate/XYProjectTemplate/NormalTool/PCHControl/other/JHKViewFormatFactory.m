//
//  JHKViewFormatFactory.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "JHKViewFormatFactory.h"

@implementation JHKViewFormatFactory

+ (CGSize)formatLabelSize:(CGSize)size text:(NSString *)text fontSize:(CGFloat)fontSize lineHeight:(CGFloat)lineHeight
{
    NSTextAlignment alignment = NSTextAlignmentLeft;
    NSLineBreakMode lineBreakMode = NSLineBreakByTruncatingTail;
    return [self formatLabelSize:size text:text font:kFont(fontSize) lineHeight:lineHeight alignment:alignment lineBreakMode:lineBreakMode];
}

+ (CGSize)formatLabelSize:(CGSize)size text:(NSString *)text font:(UIFont *)font lineHeight:(CGFloat)lineHeight alignment:(NSTextAlignment)alignment lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if ([NSString isEmptyOrNull:text]) {
        return CGSizeZero;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineHeight - font.pointSize];
    [paragraphStyle setAlignment:alignment];
//    [paragraphStyle setLineBreakMode:lineBreakMode];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [text length])];
    
    CGSize realSize = [attributedString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:NULL].size;
    
    return realSize;
}

+ (NSMutableAttributedString *)formatLabel:(UILabel *)label withText:(NSString *)text fontSize:(CGFloat)fontSize lineHeight:(CGFloat)lineHeight
{
    if ([NSString isEmptyOrNull:text]) {
        text = @"";
    }
    NSMutableAttributedString *attributedString = [self getFormatLabelString:label withText:text fontSize:fontSize lineHeight:lineHeight];
    label.attributedText = attributedString;
    return (NSMutableAttributedString *)label.attributedText;
}

+ (NSMutableAttributedString *)getFormatLabelString:(UILabel *)label withText:(NSString *)text fontSize:(CGFloat)fontSize lineHeight:(CGFloat)lineHeight
{
    if ([NSString isEmptyOrNull:text]) {
        text = @"";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineHeight - fontSize];
    [paragraphStyle setAlignment:label.textAlignment];
    [paragraphStyle setLineBreakMode:label.lineBreakMode];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSFontAttributeName value:label.font range:NSMakeRange(0, [text length])];
    return attributedString;
}

+ (CGSize)getSize:(CGSize)size withString:(NSMutableAttributedString *)attributedString
{
    CGSize realSize = [attributedString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:NULL].size;
    
    return realSize;
}

+ (void)formatImportanceButton:(UIButton *)btn
{
    [btn setTitleColor:nC10_FFFFFF_white forState:UIControlStateNormal];
    [btn setButtonColor:nC2_000000_black forState:UIControlStateNormal];
    
    [btn setTitleColor:nC10_FFFFFF_white forState:UIControlStateSelected];
    [btn setButtonColor:nC2_000000_black forState:UIControlStateSelected];
    
    [btn setTitleColor:nC10_FFFFFF_white forState:UIControlStateHighlighted];
    [btn setButtonColor:[nC2_000000_black colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
    
    [btn setTitleColor:nC6_999999 forState:UIControlStateDisabled];
    [btn setButtonColor:[nC2_000000_black colorWithAlphaComponent:0.2] forState:UIControlStateDisabled];
}

+ (void)formatButton:(UIButton *)btn
{
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = nC2_000000_black.CGColor;
    
    [btn setTitleColor:nC2_000000_black forState:UIControlStateNormal];
    [btn setButtonColor:nC10_FFFFFF_white forState:UIControlStateNormal];
    
    [btn setTitleColor:nC2_000000_black forState:UIControlStateSelected];
    [btn setButtonColor:nC10_FFFFFF_white forState:UIControlStateSelected];
    
    [btn setTitleColor:nC2_000000_black forState:UIControlStateHighlighted];
    [btn setButtonColor:[nC2_000000_black colorWithAlphaComponent:0.1] forState:UIControlStateHighlighted];
    
    [btn setTitleColor:[nC2_000000_black colorWithAlphaComponent:0.2] forState:UIControlStateDisabled];
    [btn setButtonColor:nC10_FFFFFF_white forState:UIControlStateDisabled];
}

+ (void)changeButtonBorder:(UIButton *)btn
{
    if (btn.state == UIControlStateDisabled) {
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [nC2_000000_black colorWithAlphaComponent:0.2].CGColor;
    }else{
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = nC2_000000_black.CGColor;
    }
}

+ (void)changeImportanceButtonBorder:(UIButton *)btn
{
    if (btn.state == UIControlStateDisabled) {
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [nC10_FFFFFF_white colorWithAlphaComponent:0.2].CGColor;
    }else{
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = nC10_FFFFFF_white.CGColor;
    }
}

+ (UIButton *)underLineButton:(NSString *)text WithTextSize:(CGFloat)size
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSUnderlineColorAttributeName value:nC2_000000_black range:strRange];
    [str addAttribute:NSFontAttributeName value:kFont(size) range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:nC2_000000_black range:strRange];
    
    [btn setAttributedTitle:str forState:UIControlStateNormal];
    return btn;
}

+ (void)printAllSystemFontName
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
//        if ([[familyNames objectAtIndex:indFamily] isEqualToString:@"PingFang SC"]) {
//            NSLog(@"%@",fontNames);
//        }
    }
}
@end
