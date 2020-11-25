//
//  JHKFont.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "JHKFont.h"

@implementation JHKFont

+ (UIFont *)fontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
    CGFloat size = kWidth(fontSize);
    if (SYSTEM_VERSION_LESS_THAN(@"9.0")) {
        return [UIFont systemFontOfSize:size];
    }
    return [super fontWithName:fontName size:size];
}

@end
