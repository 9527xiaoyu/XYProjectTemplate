//
//  NSString+URL.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "NSString+JHKURL.h"

@implementation NSString (JHKURL)

- (BOOL)isHttpUrl
{
    NSString *url = [self lowercaseString];
    if ([url hasPrefix:@"http"] || [url hasPrefix:@"https"] || [url hasPrefix:@"http%3A%2F%2F"] || [url hasPrefix:@"https%3A%2F%2F"]) {
        return YES;
    }
    return NO;
}

- (NSString *)stringByDecodingURLFormat
{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (NSString *)URLEncodedString
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    if ([unencodedString isEqualToString:encodedString]) {
        if (@available(iOS 9.0,*)) {
            encodedString =
            [unencodedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"].invertedSet];
        }else{
            encodedString = [unencodedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    
    return encodedString;
}

+ (NSString *)URLEncoded:(NSString *)url
{
    NSString *encodedString = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                     (CFStringRef)url,
                                                                                                     (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                     NULL,
                                                                                                     kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString*)URLDecodedString{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}

+ (void)clearCookie:(NSString *)url
{
    NSURL *URL = [NSURL URLWithString:url];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:URL];
    for (int i = 0; i < [cookies count]; i++) {
        NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

// 对url中@[xxx]内xxx给予编码
- (NSString *)paramUrlEncoded
{
    NSString *url = [self copy];
    NSString *resultUrl = url;
    
    // @\\[[\\s\\S].*?\\] 懒惰模式   |    贪婪模式  @\\[[\\s\\S].*?\\]
    NSString *pattern = [NSString stringWithFormat:@"@\\[[\\s\\S].*?\\]"]; // /?[(%@)/|(%@)$]
    
    
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive  error:nil];
    if (regular != nil) {
        NSArray *matchs = [regular matchesInString:url options:0 range:NSMakeRange(0, [url length])];
        NSEnumerator *enume = [matchs reverseObjectEnumerator];
        
        NSTextCheckingResult *match;
        while (match = [enume nextObject]) {
            NSRange resultRange = [match rangeAtIndex:0];
            if (resultRange.location != NSNotFound) {
                
                NSRange contentRange = resultRange;
                contentRange.location += 2;
                contentRange.length -= 3;
                NSString *content = [url substringWithRange:contentRange];
                
                NSString *encodeContent = [content URLEncodedString];
                
                resultUrl = [resultUrl stringByReplacingCharactersInRange:resultRange withString:encodeContent];
            }
        }
    }
    return resultUrl;
}

- (NSDictionary *)paramsToDict
{
    //获取问号到锚点的位置，问号后是参数列表
    NSString *regular = @"\\?[^#]+";
    NSRange range = [self rangeOfString:regular options:NSRegularExpressionSearch];
//    jhkLog(@"参数列表开始的位置：%d", (int)range.location);
    if (range.location == NSNotFound) {
        return @{};
    }
    
    //获取参数列表
    range.location++;
    range.length--;
    NSString *propertys = [self substringWithRange:range];
//    jhkLog(@"截取的参数列表：%@", propertys);
    
    //进行字符串的拆分，通过&来拆分，把每个参数分开
    NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
//    jhkLog(@"把每个参数列表进行拆分，返回为数组：n%@", subArray);
    
    //把subArray转换为字典
    //tempDic中存放一个URL中转换的键值对
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity:4];
    
    for (int j = 0 ; j < subArray.count; j++){
        //在通过=拆分键和值
        NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
//        jhkLog(@"再把每个参数通过=号进行拆分：n%@", dicArray);
        //给字典加入元素
        if(dicArray.count>=2){
            NSString *key = dicArray[0];
            NSString *value = [dicArray[1] stringByDecodingURLFormat];
            
            id dictValue = paramDict[key];
            if ([dictValue isKindOfClass:[NSString class]]) {
                NSMutableArray *list = [@[] mutableCopy];
                [list addObject:dictValue];
                [list addObject:value];
                paramDict[key] = list;
            }else if ([dictValue isKindOfClass:[NSMutableArray class]]) {
                NSMutableArray *list = (NSMutableArray *)dictValue;
                [list addObject:value];
                paramDict[key] = list;
            }else{
                paramDict[key] = value;
            }
        }
    }
//    jhkLog(@"打印参数列表生成的字典：n%@", tempDic);
    
    return paramDict;
}

+ (NSString *)urlDictToStringWithUrlStr:(NSString *)urlStr WithDict:(NSDictionary *)parameters
{
    if (!parameters) {
        return urlStr;
    }
    
    NSMutableArray *parts = [NSMutableArray array];
    //enumerateKeysAndObjectsUsingBlock会遍历dictionary并把里面所有的key和value一组一组的展示给你，每组都会执行这个block 这其实就是传递一个block到另一个方法，在这个例子里它会带着特定参数被反复调用，直到找到一个ENOUGH的key，然后就会通过重新赋值那个BOOL *stop来停止运行，停止遍历同时停止调用block
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //接收key
        NSString *finalKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //接收值
        if ([obj isKindOfClass:[NSNumber class]]) {
            obj = nsstrfloat([obj floatValue]);
        }
        NSString *finalValue = [obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSString *part =[NSString stringWithFormat:@"%@=%@",finalKey,finalValue];
        
        [parts addObject:part];
    }];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *descriptors = [NSMutableArray arrayWithObject:descriptor];
    NSArray *finalParts = [parts sortedArrayUsingDescriptors:descriptors];
    
    NSString *queryString = [finalParts componentsJoinedByString:@"&"];
    
    queryString = queryString ? [NSString stringWithFormat:@"?%@",queryString] : @"";
    
    NSString *pathStr = [NSString stringWithFormat:@"%@%@",urlStr,queryString];
    
    return pathStr;
}

- (NSString *)parseURLPlacehold:(NSDictionary *)dict
{
    NSMutableString *resultUrl = [self mutableCopy];
    
    for (NSString *key in dict.allKeys) {
        NSString *value = dict[key];
        BOOL replaceResult = [self replaceEL:resultUrl key:key withValue:value];
        
        if (replaceResult && [dict isKindOfClass:[NSMutableDictionary class]]) {
            [((NSMutableDictionary *)dict) removeObjectForKey:key];
        }
    }
    
    return resultUrl;
}

/**
 *  单次替换url中占位符为实际参数
 *
 *  @param resultUrl 被替换的url地址可变字符串
 *  @param key       被替换占位名
 *  @param value     被替换占位值
 *
 *  @return          替换是否成功
 */
- (BOOL)replaceColon:(NSMutableString *)resultUrl key:(NSString *)key withValue:(NSString *)value
{
    BOOL result = NO;
    
    NSString *searchKey = [NSString stringWithFormat:@":%@/",key];
    
    NSRange patternRange = [resultUrl rangeOfString:searchKey];
    
    if(patternRange.location != NSNotFound && patternRange.length > 2){
        patternRange.length = patternRange.length - 1;
        [resultUrl replaceCharactersInRange:patternRange withString:value];
        result = YES;
    }
    
    return result;
}

/**
 *  单次替换url中占位符为实际参数
 *
 *  @param resultUrl 被替换的url地址可变字符串
 *  @param key       被替换占位名
 *  @param value     被替换占位值
 *
 *  @return          替换是否成功
 */
- (BOOL)replaceEL:(NSMutableString *)resultUrl key:(NSString *)key withValue:(id)value
{
    BOOL result = NO;
    
    NSString *searchKey = [NSString stringWithFormat:@"{%@}",key];
    
    NSRange patternRange = [resultUrl rangeOfString:searchKey];
    
    if(patternRange.location != NSNotFound && patternRange.length > 2){
        result = YES;
        if ([value isKindOfClass:[NSString class]]) {
            [resultUrl replaceCharactersInRange:patternRange withString:[value URLEncodedString]];
        }else if ([value isKindOfClass:[NSNumber class]]) {
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            NSString *numberStr = [formatter stringFromNumber:value];
            [resultUrl replaceCharactersInRange:patternRange withString:numberStr];
        }else{
            result = NO;
        }
    }
    
    return result;
}

- (NSString *)replaceUrlComponent:(NSString *)componenyKey value:(NSString *)componentValue
{
    NSString *resultUrl = [self copy];
    NSString *pattern = [NSString stringWithFormat:@"(^|/?)(%@)($|/|#|\\?)",componenyKey]; // /?[(%@)/|(%@)$]
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:0  error:nil];
    if (regular != nil) {
        NSArray *matchs = [regular matchesInString:resultUrl options:0 range:NSMakeRange(0, [resultUrl length])];
        NSEnumerator *enume = [matchs reverseObjectEnumerator];
        
        NSTextCheckingResult *match;
        while (match = [enume nextObject]) {
            NSRange resultRange = [match rangeAtIndex:2];
            if (resultRange.location != NSNotFound) {
                resultUrl = [resultUrl stringByReplacingCharactersInRange:resultRange withString:componentValue];
                NSLog(@"%@",resultUrl);
            }
        }
    }
    
    return resultUrl;
}

// 获取URL中的某个参数(不能获取到数组参数)
- (NSString *)getParameter:(NSString *)parameter
{
    NSError *error;
    
    NSString *regTags = [[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",parameter];
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *matches =
    [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    for (NSTextCheckingResult *match in matches){
        NSString *tagValue = [self substringWithRange:[match rangeAtIndex:2]]; //分组2所对应的串
        return tagValue;
    }
    return @"";
}

- (NSDictionary *)getAllParameterDict
{
    NSString *url = [self copy];
    NSArray *paramStrs = [url getAllParameter];
    
    NSMutableDictionary *paramDict = [@{} mutableCopy];
    for (NSString *paramStr in paramStrs) {
        NSArray *paramKV = [paramStr componentsSeparatedByString:@"="];
        if (paramKV.count == 2) {
            NSString *key = [paramKV firstObject];
            NSString *value = [[paramKV lastObject] stringByDecodingURLFormat];
            if ([NSString isNotEmptyAndNull:key] && [NSString isNotEmptyAndNull:value]) {
                id dictValue = paramDict[key];
                if ([dictValue isKindOfClass:[NSString class]]) {
                    NSMutableArray *list = [@[] mutableCopy];
                    [list addObject:dictValue];
                    [list addObject:value];
                    paramDict[key] = list;
                }else if ([dictValue isKindOfClass:[NSMutableArray class]]) {
                    NSMutableArray *list = (NSMutableArray *)dictValue;
                    [list addObject:value];
                    paramDict[key] = list;
                }else{
                    paramDict[key] = value;
                }
            }
        }
    }
    
    return paramDict;
}

- (NSArray<NSString *> *)getAllParameter
{
    NSString *url = [self copy];
    url = [url removeUrlArg];
    if ([url containsString:@"?"]) {
//        NSRange range = [url rangeOfString:@"?"];
//        url = [url substringFromIndex:range.location + range.length];
        url = [[url componentsSeparatedByString:@"?"] lastObject];
        NSArray *paramStrs = [url componentsSeparatedByString:@"&"];
        return paramStrs;
    }
    return @[];
}

- (NSString *)deleteScheme
{
    NSString *url = [self copy];
    NSArray *uls = [url componentsSeparatedByString:@"://"];
    if (uls.count <= 1) {
        return url;
    }
    return uls[1];
}

//删除URL中的某个参数：
- (NSString *)deleteParameter:(NSString *)parameter
{
    NSString *url = [self copy];
    
    NSArray *allParam = [url getAllParameter];
    NSMutableArray *params = [allParam mutableCopy];
    for (NSString *param in allParam) {
        if ([param hasPrefix:[NSString stringWithFormat:@"%@=",parameter]]) {
            [params removeObject:param];
            break;
        }
    }
    
    NSString *finalStr = [url deleteAllParameter];
    for (NSString *param in params) {
        finalStr = [finalStr addParameter:param];
    }
    return finalStr;
}

- (NSString *)deleteEnsureParameter:(NSString *)parameter
{
    NSString *url = [self copy];
    
    NSArray *allParam = [url getAllParameter];
    NSMutableArray *params = [allParam mutableCopy];
    for (NSString *param in allParam) {
        if ([param isEqualToString:parameter]) {
            [params removeObject:param];
            break;
        }
    }
    
    NSString *finalStr = [url deleteAllParameter];
    for (NSString *param in params) {
        finalStr = [finalStr addParameter:param];
    }
    return finalStr;
}

- (NSString *)deleteAllParameter
{
    NSString *result = self;
    
    NSRange range = [result rangeOfString:@"\\?[a-zA-Z=_&0-9%\\-.\u4e00-\u9fa5]+#?" options:NSRegularExpressionSearch];
    
    if (range.location != NSNotFound) {
        NSString *subStr = [result substringWithRange:range];
        if ([subStr hasSuffix:@"#"]) {
            range.length--;
        }
        result = [result stringByReplacingCharactersInRange:range withString:@""];
    }
    return result;
}

- (NSString *)addParameter:(NSString *)parameter
{
    NSString *url = [self copy];
    NSString *arg = [url getUrlArg];
    url = [url removeUrlArg];
    if ([url hasContainString:@"?"]) {
        url = nsstrcat(url, nsstrcat(@"&", parameter));
    }else{
        url = nsstrcat(url, nsstrcat(@"?", parameter));
    }
    url = [url addUrlArg:arg];
    return url;
}

- (NSString *)addParameter:(NSString *)parameter withValue:(NSString *)value
{
    NSString *param = [NSString stringWithFormat:@"%@=%@",parameter,value];
    return [self addParameter:param];
}

- (NSString *)getUrlArg
{
    NSString *url = [self copy];
    NSRange range = [url rangeOfString:@"#[a-zA-Z,:0-9]+\\/?" options:NSRegularExpressionSearch];
    
    NSString *result = nil;
    if (range.location != NSNotFound) {
        result = [url substringWithRange:range];
    }
    
    return result;
}

- (NSString *)addUrlArg:(NSString *)urlArg
{
    NSString *url = [self copy];
    if ([NSString isEmptyOrNull:urlArg]) {
        return url;
    }
    return [NSString stringWithFormat:@"%@%@",url,urlArg];
}

- (NSString *)removeUrlArg
{
    NSString *result = self;
    
    NSRange range = [result rangeOfString:@"#[a-zA-Z,:0-9]+\\/?" options:NSRegularExpressionSearch];
    
    if (range.location != NSNotFound) {
        NSString *subStr = [result substringWithRange:range];
        if ([subStr hasSuffix:@"/"]) {
            range.length--;
        }
        result = [result stringByReplacingCharactersInRange:range withString:@""];
    }
    
    return result;
}

- (NSString *)getUrlBody
{
    NSString *url = [self copy];
    url = [url removeUrlArg];
    url = [url deleteAllParameter];
    return url;
}

#pragma mark - json
- (NSString *)deleteSpecialCodeWithStr:(NSString *)str
{
    NSString *string = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}

#pragma mark - html
- (NSString *)escapeHTML
{
    NSMutableString *result = [self mutableCopy];
    [result replaceOccurrencesOfString:@"&"  withString:@"&amp;"  options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"<"  withString:@"&lt;"   options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@">"  withString:@"&gt;"   options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"'"  withString:@"&#39;"  options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@" "  withString:@"&nbsp;"  options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    
    return result;
}

- (NSString *)unEscapeHTML
{
    NSMutableString *result = [self mutableCopy];
    [result replaceOccurrencesOfString:@"&amp;"  withString:@"&"  options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"&lt;"  withString:@"<"   options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"&gt;"  withString:@">"   options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"&#39;"  withString:@"'"  options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"&nbsp;"  withString:@" "  options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    
    return result;
}

- (NSString *)deleteHTMLTag
{
    NSMutableString *trimmedHTML = [self mutableCopy];
    
    NSString *styleTagPattern = @"<style[^>]*?>[\\s\\S]*?<\\/style>";
    NSRegularExpression *styleTagRe = [NSRegularExpression regularExpressionWithPattern:styleTagPattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *resultsArray = [styleTagRe matchesInString:trimmedHTML options:0 range:NSMakeRange(0, trimmedHTML.length)];
    for (NSTextCheckingResult *match in [resultsArray reverseObjectEnumerator]) {
        [trimmedHTML replaceCharactersInRange:match.range withString:@""];
    }
    
    NSString *htmlTagPattern = @"<[^>]+>";
    NSRegularExpression *normalHTMLTagRe = [NSRegularExpression regularExpressionWithPattern:htmlTagPattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    resultsArray = [normalHTMLTagRe matchesInString:trimmedHTML options:0 range:NSMakeRange(0, trimmedHTML.length)];
    for (NSTextCheckingResult *match in [resultsArray reverseObjectEnumerator]) {
        [trimmedHTML replaceCharactersInRange:match.range withString:@""];
    }
    
    return trimmedHTML;
}

- (id)convertToJSONData
{
    NSString *jsonString = self;
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id data = [NSJSONSerialization JSONObjectWithData:jsonData  options:NSJSONReadingMutableContainers error:&err];
    if(err)
    {
        return nil;
    }
    return data;
}

+ (NSString*)convertToJSONString:(id)infoDict
{
    if (!infoDict) {
        return @"";
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}
@end
