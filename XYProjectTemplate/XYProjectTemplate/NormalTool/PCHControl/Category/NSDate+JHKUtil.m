//
//  NSDate+JHKUtil.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "NSDate+JHKUtil.h"

@implementation NSDate (JHKUtil)
+ (NSDate *)dateFromString:(NSString *)ymd
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:ymd];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [formatter stringFromDate:date];
    return string;
}

+ (NSString *)stringFromCompleteDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *string = [formatter stringFromDate:date];
    return string;
}

+ (NSDate *)dateFromStandISO8601String:(NSString *)string
{
    if (!string) return nil;
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    return [NSDate dateWithTimeIntervalSince1970:t]; // 零时区
}

+ (NSDate *)dateFromISO8601String:(NSString *)string {
    if (!string) return nil;
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    //    return [NSDate dateWithTimeIntervalSince1970:t]; // 零时区
    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];//东八区
}

+ (NSString *)stringZoneTimeFromSeverTime:(NSString *)timeStr dateFormat:(NSString*)format
{
    NSDate *theDate = [self dateFromStandISO8601String:timeStr];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    NSString *dateStr = [formatter stringFromDate:theDate];
    
    return dateStr;
}

+ (NSString *)stringFromSeverTime:(NSString *)timeStr dateFormat:(NSString*)format
{
    NSDate *theDate = [self dateFromISO8601String:timeStr];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    NSString *dateStr = [formatter stringFromDate:theDate];
    
    return dateStr;
}

+(NSString *)JudgmentDateIntervalWithISOTime:(NSString *)timeStr
{
    NSDate *theDate = [self dateFromISO8601String:timeStr];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian ];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:theDate];
    NSDateComponents *nowComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
    if (nowComponents.day == components.day) {
        return @"今天";
    }else if (nowComponents.day == components.day+1) {
        return @"昨天";
    }else if (nowComponents.day == components.day+2) {
        return @"前天";
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *dateStr = [formatter stringFromDate:theDate];
    
    return dateStr;
}

+(NSString *)JudgmentTimeIntervalWithISOTime:(NSString *)timeStr dateFormatter:(NSString *)formatter
{
    NSDate *theDate = [self dateFromStandISO8601String:timeStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    
    NSString * timeString = nil;
    
    // 因为服务器传递过来的是东八区日期时间，所以要转换
    NSInteger interval = [NSDate date].timeIntervalSince1970;
    NSDate *now = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSTimeInterval cha =  0 - [theDate timeIntervalSinceDate:now];
    
    if (cha/3600 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        int num= [timeString intValue];
        
        if (num <= 1) {
            timeString = [NSString stringWithFormat:@"刚刚"];
        }else{
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
        }
    }
    
    if (cha/3600 > 1 && cha/86400 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
    }
    
    if (cha/86400 > 1){
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        int num = [timeString intValue];
        if (num < 2) {
            timeString = [NSString stringWithFormat:@"昨天"];
        }else{
            timeString =[dateFormatter stringFromDate:theDate];
        }
    }
    return timeString;
}

//根据获取到的时间判断时间间隔 如 “刚刚”，“一分钟前”，“一小时前”等；
//获取时间 是用上面的方法获取的
+(NSString *)JudgmentTimeIntervalWithISOTime:(NSString *)timeStr
{
    NSString * timeString = [self JudgmentTimeIntervalWithISOTime:timeStr dateFormatter:@"yyyy-MM-dd HH:mm"];
    return timeString;
}

+ (NSString *)intervalStr:(NSInteger)interval
{
    NSString *result = @"";
    
    NSInteger hour = interval / 60 / 60;
    NSInteger minute = interval % (60 * 60) / 60;
    NSInteger second = interval % 60;
    if (hour > 0) {
        result = [NSString stringWithFormat:@"%ld小时",(long)hour];
    }
    
    result = [NSString stringWithFormat:@"%@%ld分",result,(long)minute];
    result = [NSString stringWithFormat:@"%@%ld秒",result,(long)second];
    
    return result;
}

+ (NSString *)intervalStrWithHM:(NSInteger)interval
{
    NSString *result = @"";
//    NSInteger seconds = interval % 60;
    NSInteger minutes = (interval / 60) % 60;
    NSInteger hours = interval / 3600;
    result = [NSString stringWithFormat:@"%ld小时%02ld分",(long)hours, (long)minutes];
    return result;
}

+ (NSString *)interValueHasFillStrWithPoint:(NSInteger)interval
{
    NSString *result = @"";
    NSInteger seconds = interval % 60;
    NSInteger minutes = (interval / 60) % 60;
    NSInteger hours = interval / 3600;
    result = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours, (long)minutes, (long)seconds];
    return result;
}

+ (NSString *)intervalHasFillStr:(NSInteger)interval
{
    NSString *result = @"";
    
    NSInteger hour = interval / 60 / 60;
    NSInteger minute = interval % (60 * 60) / 60;
    NSInteger second = interval % 60;
    if (hour > 0) {
        result = [NSString stringWithFormat:@"%02ld小时",(long)hour];
    }
    
    result = [NSString stringWithFormat:@"%@%02ld分",result,(long)minute];
    result = [NSString stringWithFormat:@"%@%02ld秒",result,(long)second];
    
    return result;
}

//  时间转时间戳的方法:
- (long long)timestamp
{
    /*
     时间戳:
     double a = (double)[self timeIntervalSince1970];        //1449819559.71875
     int b = time(NULL);                                  //1449819559
     
     return  [NSString stringWithFormat:@"%ld", time(NULL)];
     return [NSString stringWithFormat:@"%.0f", [self timeIntervalSince1970]*1000];
     */
    return [self timeIntervalSince1970] * 1000;
}

+ (long long)timestampLocalTimeZone
{
    return [[NSDate date] timestamp] + [[NSTimeZone localTimeZone] secondsFromGMT] * 1000;
}

+ (long long)timestampFromISOTime:(NSString *)timeStr
{
    NSDate *adDate = [NSDate dateFromISO8601String:timeStr];
    long long timestamp = [adDate timestamp];
    return timestamp;
}

+ (NSString *)dateStringFromTimestamp:(long long)timestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimeStamp= [self dateFromTimestamp:timestamp];
    
    return  [formatter stringFromDate:confromTimeStamp];
}

+ (NSDate *)dateFromTimestamp:(long long)timestamp
{
    return  [NSDate dateWithTimeIntervalSince1970:timestamp];
}

+ (NSString*)localTime2UTC:(NSString*)endTime
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    format.timeZone = [NSTimeZone systemTimeZone];//timeZoneWithAbbreviation:@"UTC"];
    //将时间字符串当utc处理，打印时根据本地时区自动打印 +8
    
    NSDate *utcDate = [format dateFromString:endTime];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *ymd = [format stringFromDate:utcDate];
    if ([NSString isEmptyOrNull:ymd]) {
        return @"";
    }
    format.dateFormat = @"HH:mm:ssZ";
    NSString *hmsz = [format stringFromDate:utcDate];
    NSString *result = [NSString stringWithFormat:@"%@T%@",ymd,hmsz];
    return result;
}

+ (BOOL)checkCurrentTimeWithString:(NSString *)timeString ignoreRange:(NSInteger)ignoreTime
{
    NSInteger ignoreRange = ignoreTime>0?ignoreTime:0;
    NSInteger stringTimeStamp = [NSDate dateFromStandISO8601String:timeString].timeIntervalSince1970;
    NSInteger nowTimeStamp = [[NSDate date] timeIntervalSince1970];
    
    NSInteger interval = stringTimeStamp - nowTimeStamp;
    BOOL request = NO;
    if (interval > ignoreRange) {
        request = YES;
    }
    return request;
}
@end
