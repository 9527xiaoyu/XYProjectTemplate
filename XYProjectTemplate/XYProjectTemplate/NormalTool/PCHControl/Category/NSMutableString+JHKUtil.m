//
//  NSMutableString+JHKUtil.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "NSMutableString+JHKUtil.h"

@implementation NSMutableString (JHKUtil)

- (NSString *)appendNotNullString:(NSString *)string
{
    if ([NSString isNotEmptyAndNull:string]) {
        [self appendString:string];
    }
    return self;
}

- (NSString *)appendNotNullString:(NSString *)string withSeparate:(NSString *)separate
{
    if ([NSString isNotEmptyAndNull:string]) {
        [self appendString:separate];
        [self appendString:string];
    }
    return self;
}
@end
