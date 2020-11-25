//
//  NSString+URL.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JHKURL)

- (BOOL)isHttpUrl;

/**清除Cookie*/
+ (void)clearCookie:(NSString *)url;

+ (NSString *)URLEncoded:(NSString *)url;
- (NSString *)URLEncodedString;
- (NSString *)stringByDecodingURLFormat;
- (NSString *)paramUrlEncoded;
- (NSString *)URLDecodedString;
/**
 *  解析一个url，将url中参数转换为字典
 *
 *  @return 以字典形式存放的参数
 */
- (NSDictionary *)paramsToDict;

/**
 *  拼接post请求的网址
 *
 *  @param urlStr     基础网址
 *  @param parameters 拼接参数
 *
 *  @return 拼接完成的网址
 */
+ (NSString *)urlDictToStringWithUrlStr:(NSString *)urlStr WithDict:(NSDictionary *)parameters;

/**
 *  将占位符替换为字典中对应的值。
 *
 *  @param dict 如果是可变字典会移除所有已被替换的键值对。
 *
 *  @return 返回值为替换后的url。
 */
- (NSString *)parseURLPlacehold:(NSDictionary *)dict;
- (NSString *)replaceUrlComponent:(NSString *)componenyKey value:(NSString *)componentValue;

- (NSString *)getParameter:(NSString *)parameter;
- (NSDictionary *)getAllParameterDict;
- (NSArray<NSString *> *)getAllParameter;

- (NSString *)deleteScheme;
- (NSString *)deleteParameter:(NSString *)parameter;
- (NSString *)deleteEnsureParameter:(NSString *)parameter;
- (NSString *)deleteAllParameter;

- (NSString *)addParameter:(NSString *)parameter;
- (NSString *)addParameter:(NSString *)parameter withValue:(NSString *)value;

- (NSString *)getUrlArg;
- (NSString *)addUrlArg:(NSString *)urlArg;
- (NSString *)removeUrlArg;

- (NSString *)getUrlBody;

//处理json格式的字符串中的换行符、回车符
- (NSString *)deleteSpecialCodeWithStr:(NSString *)str;

- (NSString *)escapeHTML;
- (NSString *)unEscapeHTML;
- (NSString *)deleteHTMLTag;

- (id)convertToJSONData;
+ (NSString*)convertToJSONString:(id)infoDict;

@end

NS_ASSUME_NONNULL_END
