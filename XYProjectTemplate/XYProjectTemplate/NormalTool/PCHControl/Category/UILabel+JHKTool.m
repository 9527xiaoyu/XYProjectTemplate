//
//  UILabel+JHKTool.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "UILabel+JHKTool.h"
#import <objc/runtime.h>

@implementation UILabel (JHKTool)
- (void)setFontAttr:(NSString *)fontAttr
{
    if ([NSString isNotEmptyAndNull:fontAttr]) {
        NSArray *fontAttrs = [fontAttr componentsSeparatedByString:@"|"];   // PingFang-SC-Medium|20
        if (fontAttrs.count >= 2) {
            NSString *fontName = fontAttrs[0];
            CGFloat fontSize = [fontAttrs[1] floatValue];
            self.font = kFontNormal(fontName, fontSize);
        }
    }
}

- (NSString *)fontAttr
{
    return [self.font fontName];
}

- (NSString *)verticalText
{
    return objc_getAssociatedObject(self, @selector(verticalText));
}

- (void)setVerticalText:(NSString *)verticalText
{
    objc_setAssociatedObject(self, &verticalText, verticalText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableString *str = [[NSMutableString alloc] initWithString:verticalText];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2-1];
    }
    self.text = str;
    self.numberOfLines = 0;
}

- (CGFloat)fitLabelWidth
{
    UILabel *label = self;
    NSDictionary *dict =[NSDictionary dictionaryWithObject:label.font forKey:NSFontAttributeName];
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, label.jhk_size.height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size.width;
}

- (CGFloat)fitLabelHeight
{
    UILabel *label = self;
    CGSize size = CGSizeMake(label.frame.size.width, MAXFLOAT);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    NSDictionary *dic = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:style};
    
    CGFloat height = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
}

- (void)jhk_addTapGestureWithTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

+ (instancetype)jhk_labelWithText:(NSString*)text textColor:(UIColor*)color font:(UIFont*)font textAlignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberLine backgroundColor:(UIColor*)backColor
{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = color;
    label.backgroundColor = backColor;
    label.textAlignment = alignment;
    label.numberOfLines = numberLine;
    label.font = font;
    label.text = text;
    return label;
}

@end
