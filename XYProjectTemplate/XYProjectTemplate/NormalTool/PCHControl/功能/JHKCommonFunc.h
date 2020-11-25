//
//  JHKCommonFunc.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define __jhkIMGBASE64( img )        [JHKCommonFunc encodeToBase64String:img]
#define __jhkIMG( base64 )        [JHKCommonFunc decodeBase64ToImage:base64]

#define __jhkBASE64( text )        [JHKCommonFunc base64StringFromText:text]
#define __jhkTEXT( base64 )        [JHKCommonFunc textFromBase64String:base64]

@interface JHKCommonFunc : NSObject

/******************************************************************************
 函数名称 : + (NSString *)encodeToGTMBase64String:(NSData *)data
 函数描述 : 二进制数据进行 google base64加密
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSString *)encodeToGTMBase64String:(NSData *)data;

/******************************************************************************
 函数名称 : decodeGTMBase64ToData:(NSString *)strEncodeData
 函数描述 : base64数据进行 google 二进制解密
 输入参数 : (NSString *)strEncodeData
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)decodeGTMBase64ToData:(NSString *)strEncodeData;

/******************************************************************************
 函数名称 : + (NSString *)encodeToBase64String:(UIImage *)image
 函数描述 : 图片数据进行 encode base64加密
 输入参数 : (UIImage *)image
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)encodeToBase64String:(UIImage *)image;

/******************************************************************************
 函数名称 : + (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData
 函数描述 : base64图片数据进行 Decoding 图片
 输入参数 : (NSString *)strEncodeData
 输出参数 : N/A
 返回参数 : (UIImage *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;

+ (NSString *)md5:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
