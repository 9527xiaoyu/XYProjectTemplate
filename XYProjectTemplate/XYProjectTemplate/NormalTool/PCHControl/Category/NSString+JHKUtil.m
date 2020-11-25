//
//  NSString+JHKUtil.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "NSString+JHKUtil.h"
// 用户获取设备ip地址
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation NSString (JHKUtil)

+ (NSString *)generateUserAgent
{
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    NSString *IDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    return [NSString stringWithFormat:@"JinHuKao.com/%@ %@/%@ %@/%@", appVersion,
            @"iOS"/*[UIDevice currentDevice].systemName*/,      // ios9为iPhone OS,ios10为iOS
            [UIDevice currentDevice].systemVersion,
            [UIDevice currentDevice].model,
            IDFV];
}

+ (BOOL)isEmptyOrNull: (NSString *)string
{
    if ([string isKindOfClass:[NSNull class]] || string == nil || [string isEqualToString:@""] || [string isEqualToString:@"undefined"] || [string isEqualToString:@"null"])
        return true;
    return false;
}

+ (BOOL)isNotEmptyAndNull: (NSString *)string
{
    if (![string isKindOfClass:[NSNull class]] && string != nil && ![string isEqualToString:@""] && ![string isEqualToString:@"undefined"] && ![string isEqualToString:@"null"])
        return  true;
    return false;
}

- (int)stringConvertToInt
{
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength; //return (strlength+1)/2;
}

- (BOOL)hasContainString:(NSString *)string
{
    if([self rangeOfString:string].location != NSNotFound)
    {
        return YES;
    }
    return NO;
}

- (NSString *)localizableStrings
{
    return NSLocalizedString(self, nil);
}

- (NSString *)limitTextLength:(NSInteger)length
{
    NSString *text = self;
    
    if (text.length > length) {
        text = [text substringToIndex:length];
        text = [NSString stringWithFormat:@"%@…",text];
    }
    return text;
}

- (NSString*)pinyin
{
    if (self == nil || self.length == 0) {
        return @"";
    }
    NSMutableString *result = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformStripDiacritics,NO);
    return [result uppercaseString];
}

- (NSString *)trimString
{
    return  [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)deleteBackSlantChar
{
    NSString *string = self;
    NSMutableString *responseString = [NSMutableString stringWithString:string];
    NSString *character = nil;
    for (int i = 0; i < responseString.length; i ++) {
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
    }
    return responseString;
}

- (NSString *)atSomebody:(NSString *)somebody
{
    NSString *content = self;
    
    NSString *atSb = [NSString stringWithFormat:@"@%@: ",somebody];
    
    //[\u0391-\uFFE5] 匹配中文  \w 匹配所有字符
    NSRange range = [self rangeOfString:@"^@.*:\\s" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        content = [self stringByReplacingCharactersInRange:range withString:atSb];
    }else{
        content = nsstrcat(atSb, self);
    }
    
    return content;
}

- (NSString *)getAtSomeBodyName
{
    NSString *nick = @"";
    if ([self hasPrefix:@"@"]) {
        //[\u0391-\uFFE5] 匹配中文  \w 匹配所有字符
        NSRange range = [self rangeOfString:@"^@[\\w]*:\\s" options:NSRegularExpressionSearch];
        
        if (range.location != NSNotFound) {
            range.location++;       //去掉字符@
            range.length -= 3;      //去掉末尾空格和冒号
            nick = [self substringWithRange:range];
        }
        
    }
    return nick;
}

- (NSRange)getAtSomeBodyRange
{
    if ([self hasPrefix:@"@"]) {
        //[\u0391-\uFFE5] 匹配中文  \w 匹配所有字符
        NSRange range = [self rangeOfString:@"^@[\\w]*:\\s" options:NSRegularExpressionSearch];
        
        if (range.location != NSNotFound) {
            range.length -= 2;      //去掉末尾空格和冒号
            return range;
        }
    }
    return NSMakeRange(0, 0);
}

- (NSString *)removeAtSomeBody
{
    NSString *string = self;
    NSRange range = [string getAtSomeBodyRange];
    if (range.location != NSNotFound && range.length != 0) {
        string = [string substringFromIndex:range.location + range.length + 1];
    }
    return string;
}

+ (BOOL)isURL:(NSString *)string
{
    NSString *pattern = @"^(http|https)://.*?$(net|com|.com.cn|org|me|)";
    
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    return [urlPredicate evaluateWithObject:string];
}

- (BOOL)isMobilePhone
{
    if ([self hasPrefix:@"1"] && self.length == 11) {
        return true;
    }
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1\\d{10}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    if (([regextestmobile evaluateWithObject:self])) {
        return YES;
    }
    
    return NO;
}

//利用正则表达式验证
-(BOOL)isEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark - hardware
//生成随机数算法 ,随机字符串，不长于32位
//微信支付API接口协议中包含字段nonce_str，主要保证签名不可预测。
//我们推荐生成随机数算法如下：调用随机数函数生成，将得到的值转换为字符串。
+ (NSString *)generateTradeNO {
    
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    
    //  srand函数是初始化随机数的种子，为接下来的rand函数调用做准备。
    //  time(0)函数返回某一特定时间的小数值。
    //  这条语句的意思就是初始化随机数种子，time函数是为了提高随机的质量（也就是减少重复）而使用的。
    
    //　srand(time(0)) 就是给这个算法一个启动种子，也就是算法的随机种子数，有这个数以后才可以产生随机数,用1970.1.1至今的秒数，初始化随机数种子。
    //　Srand是种下随机种子数，你每回种下的种子不一样，用Rand得到的随机数就不一样。为了每回种下一个不一样的种子，所以就选用Time(0)，Time(0)是得到当前时时间值（因为每时每刻时间是不一样的了）。
    
    srand((unsigned)time(0)); // 此行代码有警告:
    
    for (int i = 0; i < kNumber; i++) {
        
        unsigned index = rand() % [sourceStr length];
        
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

// 获取设备ip地址 / 貌似该方法获取ip地址只能在wifi状态下进行
+ (NSString *)fetchIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+ (NSString*)convertToJSONData:(id)infoDict
{
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

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// URL --->>> Dictionary
+ (NSDictionary *)convertUrl2Dict:(NSString*)url
{
    NSRange pramaRange = [url rangeOfString:@"?"];
    NSString *pramaString = [url substringFromIndex:pramaRange.location+1];
    if ([pramaString isEqualToString:@""]) {
        NSDictionary *dict = [@{} mutableCopy];
        return dict;
    }
    NSMutableArray * pramaArray = [@[] mutableCopy];
    NSString *temp = nil;
    NSInteger index = 0,len = 0;
    //取&
    for (NSInteger i = 1; i < [pramaString length]; i++) {
        temp = [pramaString substringWithRange:NSMakeRange(i, 1)];
        
        if ([temp isEqualToString:@"&"]) {
            len = i-index;
            [pramaArray addObject:[pramaString substringWithRange:NSMakeRange(index, len)]];
            index = i+1;
        }
    }
    [pramaArray addObject:[pramaString substringWithRange:NSMakeRange(index, [pramaString length]-index)]];
    //重置index len temp(临时字符串)
    index = 0,len = 0;
    temp = nil;
    NSInteger minusCount = 0;
    //创建两数组 用于存key value
    NSMutableArray *keyArray = [@[] mutableCopy];
    NSMutableArray *valueArray = [@[] mutableCopy];
    for (NSInteger idxArr = 0; idxArr < pramaArray.count; idxArr++) {
        for (NSInteger idxStr = 1; idxStr < [pramaArray[idxArr] length]; idxStr++) {
            temp = [pramaArray[idxArr] substringWithRange:NSMakeRange(idxStr, 1)];
            //取 -
            if ([temp isEqualToString:@"-"]) {
                minusCount++;
                len = idxStr-index;
                if (minusCount%2 == 0) {
                    [valueArray addObject:[pramaArray[idxArr] substringWithRange:NSMakeRange(index, len)]];
                }else{
                    [keyArray addObject:[pramaArray[idxArr] substringWithRange:NSMakeRange(index, len)]];
                }
                index = idxStr+1;
            }else{
                //取 =
                if ([temp isEqualToString:@"="]) {
                    len = idxStr-index;
                    [keyArray addObject:[pramaArray[idxArr] substringWithRange:NSMakeRange(index, len)]];
                    index = idxStr+1;
                }
            }
        }
        [valueArray addObject:[pramaArray[idxArr] substringWithRange:NSMakeRange(index, [pramaArray[idxArr] length]-index)]];
        index = len = 0;
    }
    
    NSMutableDictionary * dict = [@{} mutableCopy];
    for (NSInteger idxDict = 0; idxDict < keyArray.count; idxDict++) {
        [dict setObject:valueArray[idxDict] forKey:keyArray[idxDict]];
    }
    
    return dict;
}

//    Dictionary --->>> URL
+ (NSString*)convertDict2Url:(NSDictionary *)dict htmlHead:(NSString*)htmlHeader
{
    if ([dict isEqualToDictionary:@{}]) {
        return nil;
    }
    NSString *newHeader = [htmlHeader stringByAppendingString:@"?"];
    
    NSMutableArray * keyArray = [@[] mutableCopy];
    NSMutableArray * valueArray = [@[] mutableCopy];
    keyArray = (NSMutableArray *)[dict allKeys];
    valueArray = (NSMutableArray *)[dict allValues];
    
    NSInteger count = 0;
    NSMutableString *tempKeyString = [[NSMutableString alloc]initWithString:@"-"];
    NSMutableString *tempValueString = [[NSMutableString alloc]initWithString:@"-"];
    NSMutableString *groupKeyString = [[NSMutableString alloc]initWithString:@"-"];
    NSMutableString *groupValueString = [[NSMutableString alloc]initWithString:@"-"];
    
    NSString *resultTempKeyString = nil;
    NSString *resultTempValueString = nil;
    NSString *resultKeyString = nil;
    NSString *resultValueString = nil;
    
    NSMutableArray *newKeyArray = [@[] mutableCopy];
    NSMutableArray *newValueArray = [@[] mutableCopy];
    for (NSInteger idxCount = 0; idxCount < keyArray.count; idxCount++) {
        if ([keyArray[idxCount] hasPrefix:@"min"]) {
            count++;
            if (count%2 == 0) {
                [tempKeyString insertString:keyArray[idxCount] atIndex:0];
                [tempValueString insertString:valueArray[idxCount] atIndex:0];
            }else{
                [groupKeyString insertString:keyArray[idxCount] atIndex:0];
                [groupValueString insertString:valueArray[idxCount] atIndex:0];
            }
        }else if ([keyArray[idxCount] hasPrefix:@"max"]){
            count++;
            if (count%2 == 0) {
                resultTempKeyString = [tempKeyString stringByAppendingString:keyArray[idxCount]];
                resultTempValueString = [tempValueString stringByAppendingString:valueArray[idxCount]];
            }else{
                resultKeyString = [groupKeyString stringByAppendingString:keyArray[idxCount]];
                resultValueString = [groupValueString stringByAppendingString:valueArray[idxCount]];
            }
        }else{
            [newKeyArray addObject:keyArray[idxCount]];
            [newValueArray addObject:valueArray[idxCount]];
        }
    }
    [newKeyArray addObject:resultKeyString];
    [newKeyArray addObject:resultTempKeyString];
    [newValueArray addObject:resultValueString];
    [newValueArray addObject:resultTempValueString];
    
    NSString *composeString = nil;
    for (NSInteger idxUrl = 0; idxUrl < newKeyArray.count; idxUrl++) {
        composeString = nil;
        composeString = [NSString stringWithFormat:@"%@=%@",newKeyArray[idxUrl],newValueArray[idxUrl]];
        if (idxUrl+1 >= newKeyArray.count) {
            newHeader = [newHeader stringByAppendingString:composeString];
        }else{
            newHeader = [newHeader stringByAppendingString:composeString];
            newHeader = [newHeader stringByAppendingString:@"&"];
        }
    }
    return newHeader;
}

+ (NSDictionary *)getUrlParameterWithUrl:(NSString *)url {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url];
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parm setObject:obj.value forKey:obj.name];
    }];
    return parm;
}

@end
