//
//  TDDateUtil.m
//  infoPromotion
//
//  Created by 朱靓慈 on 15/3/2.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "TDDateUtil.h"

@implementation TDDateUtil

+ (NSString*)stringFromDate:(NSDate*)date withFormatterString:(NSString*)formatter {
    if (!date || !formatter) {
        return nil;
    }
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:formatter];
    return [f stringFromDate:date];
}

+ (NSDate*)dateFromString:(NSString*)string withFormatterString:(NSString*)formatter {
    if (!string || !formatter) {
        return nil;
    }
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:formatter];
    return [f dateFromString:string];
}

+ (NSString *)stringFromDateString:(NSString *)dateStr withFormatterString:(NSString *)formatter{
    for (int i=dateStr.length; i<14; i++) {
        dateStr = [dateStr stringByAppendingString:@"1"];
    }
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* inputDate = [inputFormatter dateFromString:dateStr];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:formatter];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}
+(long long)longLongFromDate:(NSDate*)date{
    return [date timeIntervalSince1970] * 1000;
}

+(NSDate*)dateFromRemoteInterval:(id)remoteDate{
    if (remoteDate!=[NSNull null]) {
        return [[NSDate alloc]initWithTimeIntervalSince1970:([remoteDate longValue]/1000)];
    }else{
        return nil;
    }
}
+(NSString *)getYear{
    NSDate *now = [NSDate date];
    NSString *year = [self stringFromDate:now withFormatterString:@"YYYY"];
    return year;
}
+(NSString *)getMonth{
    NSDate *now = [NSDate date];
    NSString *month = [self stringFromDate:now withFormatterString:@"YYYYMM"];
    return month;
}
+(NSString *)getDay{
    NSDate *now = [NSDate date];
    NSString *day = [self stringFromDate:now withFormatterString:@"YYYYMMdd"];
    return day;
}
+(NSDate *)getDateAfter:(NSDate *)startDate hourDis:(int)hourDis{
    NSTimeInterval oneHour = 60*60*1;//1小时的长度
    NSDate *theDate = [startDate initWithTimeInterval:+oneHour*hourDis sinceDate:startDate];
    return theDate;
}
+(NSArray *)getDaysAfter:(NSDate *)startDate dis:(int)dayDis{
    NSMutableArray *dateArray = [[NSMutableArray alloc]init];
    
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    for (int i=0; i<dayDis; i++) {
        NSDate *theDate = [startDate initWithTimeInterval:+oneDay*i sinceDate:startDate];
        NSString *theDay = [self stringFromDate:theDate withFormatterString:@"YYYYMMdd"];
        [dateArray addObject:theDay];
    }
    return dateArray;
}
+(NSArray *)getDaysBefore:(NSDate *)startDate dis:(int)dayDis{
    NSMutableArray *dateArray = [[NSMutableArray alloc]init];
    
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    for (int i=0; i<dayDis; i++) {
        NSDate *theDate = [startDate initWithTimeInterval:-oneDay*i sinceDate:startDate];
        NSString *theDay = [self stringFromDate:theDate withFormatterString:@"YYYYMMdd"];
        [dateArray addObject:theDay];
    }
    return dateArray;
}
+(NSArray *)getMonthsAfter:(NSDate *)startDate dis:(int)monthDis{
    NSMutableArray *monthArray = [[NSMutableArray alloc]init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    for (int i=0; i<monthDis; i++) {
        NSDateComponents *comps = nil;
        comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:startDate];
        NSDateComponents *adcomps = [[NSDateComponents alloc] init];
        
        [adcomps setYear:0];
        
        [adcomps setMonth:+i];
        
        [adcomps setDay:0];
        
         NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:startDate options:0];
        [monthArray addObject:[TDDateUtil stringFromDate:newdate withFormatterString:@"YYYYMM"]];
    }
    return monthArray;
    
}
+(NSArray *)getMonthsBefore:(NSDate *)startDate dis:(int)monthDis{
    NSMutableArray *monthArray = [[NSMutableArray alloc]init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    for (int i=0; i<monthDis; i++) {
        NSDateComponents *comps = nil;
        comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:startDate];
        NSDateComponents *adcomps = [[NSDateComponents alloc] init];
        
        [adcomps setYear:0];
        
        [adcomps setMonth:-i];
        
        [adcomps setDay:0];
        
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:startDate options:0];
        [monthArray addObject:[TDDateUtil stringFromDate:newdate withFormatterString:@"YYYYMM"]];
    }
    return monthArray;
}

//获取最近的指定星期几所在的日期,weekDay 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
+(NSDate *)getNearWeekDay:(NSInteger)weekDay{
    NSDate *nearWeekDayDate = [NSDate date];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit fromDate:now];
    NSInteger nowWeekDay = [comp weekday];
    if (nowWeekDay <weekDay) {//当前周几小于指定z
        nearWeekDayDate = [self getDateAfter:now hourDis:(int)(weekDay-nowWeekDay)*24];
    }else{
        nearWeekDayDate = [self getDateAfter:now hourDis:(int)(7-nowWeekDay+weekDay)*24];
    }
    return nearWeekDayDate;
}

//计算startDate 和endDate 间的间隔天数
+(int)getIntervalDaysFrom:(NSDate *)startDate ToEndDate:(NSDate *)endDate{
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:startDate];
    int intervalDays = timeInterval/(24*3600);
    return intervalDays;
}
@end
