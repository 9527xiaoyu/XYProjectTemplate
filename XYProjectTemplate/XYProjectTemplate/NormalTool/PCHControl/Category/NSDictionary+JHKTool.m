//
//  NSDictionary+JHKTool.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "NSDictionary+JHKTool.h"

@implementation NSDictionary (JHKTool)

- (BOOL)judgeDictEqaulValue:(NSDictionary *)dict
{
    if (self.allKeys.count != dict.allKeys.count) {
        return NO;
    }
    
    BOOL equalFlag = YES;
    
    NSArray *allKeys = self.allKeys;
    for (NSString *key in allKeys) {
        NSString *value = self[key];
        if ([value isKindOfClass:[NSString class]]) {
            if (![dict[key] isEqualToString:value]) {
                equalFlag = NO;
                break;
            }
        }else if([value isKindOfClass:[NSNumber class]]){
            if ([dict[key] compare:value] != NSOrderedSame) {
                equalFlag = NO;
                break;
            }
        }else{
            if ( dict[key] != value) {
                equalFlag = NO;
                break;
            }
        }
    }
    
    return equalFlag;
}

- (NSString* )convertToJSONString
{
    id infoDict = self;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (jsonData){
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}
@end
