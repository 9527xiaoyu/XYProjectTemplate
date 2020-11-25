//
//  NSString+JHKUtil.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JHKUtil)

+ (NSString *)generateUserAgent;

+ (BOOL)isEmptyOrNull: (NSString *)string;
+ (BOOL)isNotEmptyAndNull:(NSString *)string;
- (int)stringConvertToInt;//得到字节数函数
- (BOOL)hasContainString:(NSString *)string;
- (NSString *)localizableStrings;

- (NSString *)limitTextLength:(NSInteger)length;

- (NSString*)pinyin;
/**修剪字符串--去掉首尾的空格*/
- (NSString *)trimString;
/**修剪字符串--去掉反斜线*/
- (NSString *)deleteBackSlantChar;

/**@somebody*/
- (NSString *)atSomebody:(NSString *)somebody;
/**获取@somebody的名字*/
- (NSString *)getAtSomeBodyName;
/**获取@somebody的范围*/
- (NSRange)getAtSomeBodyRange;
/**移除@somebody*/
- (NSString *)removeAtSomeBody;

+ (BOOL)isURL:(NSString *)string;
- (BOOL)isMobilePhone;
-(BOOL)isEmail;

//生成随机数算法 ,随机字符串，不长于32位
//微信支付API接口协议中包含字段nonce_str，主要保证签名不可预测。
//我们推荐生成随机数算法如下：调用随机数函数生成，将得到的值转换为字符串。
+ (NSString *)generateTradeNO;

/** 获取设备ip地址 / 貌似该方法获取ip地址只能在wifi状态下进行*/
+ (NSString *)fetchIPAddress;

+ (NSString*)convertToJSONData:(id)infoDict;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//URL转字典
+ (NSDictionary *)convertUrl2Dict:(NSString*)url;

//字典转URL
+ (NSString*)convertDict2Url:(NSDictionary *)dict htmlHead:(NSString*)htmlHeader;

//解析URL
+ (NSDictionary *)getUrlParameterWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
