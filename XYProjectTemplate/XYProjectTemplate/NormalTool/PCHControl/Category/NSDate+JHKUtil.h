//
//  NSDate+JHKUtil.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (JHKUtil)
/**年月日：字符转换成数据*/
+ (NSDate *)dateFromString:(NSString *)ymd;
/**年月日：数据转换成字符*/
+ (NSString *)stringFromDate:(NSDate *)date;
/**年月日时分秒：数据转换成字符*/
+ (NSString *)stringFromCompleteDate:(NSDate *)date;

/**服务器时间 字符串转数据，0时区*/
+ (NSDate *)dateFromStandISO8601String:(NSString *)string;
/**服务器时间 字符串转数据，东8时区*/
+ (NSDate *)dateFromISO8601String:(NSString *)string;

+ (NSString *)stringZoneTimeFromSeverTime:(NSString *)timeStr dateFormat:(NSString*)format;
+(NSString *)stringFromSeverTime:(NSString *)timeStr dateFormat:(NSString*)format;

/**判断服务器时间所指时间：今天，昨天，前天*/
+(NSString *)JudgmentDateIntervalWithISOTime:(NSString *)timeStr;
/**判断服务器时间所指时间：刚刚，分钟前，小时前，昨天*/
+(NSString *)JudgmentTimeIntervalWithISOTime:(NSString *)timeStr dateFormatter:(NSString *)formatter;
/**判断服务器时间所指时间：刚刚，分钟前，小时前，昨天*/
+(NSString *)JudgmentTimeIntervalWithISOTime:(NSString *)timeStr;

/**时间间隔 X小时XX分XX秒*/
+ (NSString *)intervalStr:(NSInteger)interval;
/**时间间隔 X小时XX分*/
+ (NSString *)intervalStrWithHM:(NSInteger)interval;
/**时间间隔 XX:XX:XX*/
+ (NSString *)interValueHasFillStrWithPoint:(NSInteger)interval;
/**时间间隔 XX小时XX分XX秒*/
+ (NSString *)intervalHasFillStr:(NSInteger)interval;

/**时间戳*/
- (long long)timestamp;
/**本地时间戳*/
+ (long long)timestampLocalTimeZone;
+ (long long)timestampFromISOTime:(NSString *)timeStr;

+ (NSString *)dateStringFromTimestamp:(long long)timeStamp;
+ (NSDate *)dateFromTimestamp:(long long)timeStamp;

+ (NSString*)localTime2UTC:(NSString*)endTime;
/**判断输入时间大于当前时间
 @param timeString  输入的时间
 @param ignoreTime 忽略时间范围
 */
+ (BOOL)checkCurrentTimeWithString:(NSString *)timeString ignoreRange:(NSInteger)ignoreTime;


@end

NS_ASSUME_NONNULL_END
