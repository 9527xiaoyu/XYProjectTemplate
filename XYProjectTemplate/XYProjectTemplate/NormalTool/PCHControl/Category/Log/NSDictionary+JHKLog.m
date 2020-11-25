//
//  NSDictionary+JHKLog.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "NSDictionary+JHKLog.h"

@implementation NSDictionary (JHKLog)

#ifdef DEBUG
- (NSString *)descriptionWithLocale:(id)locale
{
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

- (NSString *)descriptionWithLocale_printUnicode:(id)locale
{
    // 遍历数组中的所有内容，将内容拼接成一个新的字符串返回
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
    [string deleteCharactersInRange:range];
    
    return string;
}
#endif
@end
