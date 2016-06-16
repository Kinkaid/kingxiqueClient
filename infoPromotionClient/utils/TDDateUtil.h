//
//  TDDateUtil.h
//  infoPromotion
//
//  Created by 朱靓慈 on 15/3/2.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDDateUtil : NSObject

+ (NSString*)stringFromDate:(NSDate*)date withFormatterString:(NSString*)formatter;
+ (NSDate*)dateFromString:(NSString*)string withFormatterString:(NSString*)formatter;

//201205201123 转为需要的格式
+ (NSString *)stringFromDateString:(NSString *)dateStr withFormatterString:(NSString *)formatter;
+(long long)longLongFromDate:(NSDate*)date;
+ (NSDate*)dateFromRemoteInterval:(id)remoteDate;
+(NSString *)getYear;
+(NSString *)getMonth;
+(NSString *)getDay;
+(NSDate *)getDateAfter:(NSDate *)startDate hourDis:(int)hourDis;
+(NSArray *)getDaysAfter:(NSDate *)startDate dis:(int)dayDis;
+(NSArray *)getDaysBefore:(NSDate *)startDate dis:(int)dayDis;
+(NSArray *)getMonthsAfter:(NSDate *)startDate dis:(int)monthDis;
+(NSArray *)getMonthsBefore:(NSDate *)startDate dis:(int)monthDis;

//获取最近的指定星期几所在的日期,weekDay 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
+(NSDate *)getNearWeekDay:(NSInteger)weekDay;

//计算startDate 和endDate 间的间隔天数
+(int)getIntervalDaysFrom:(NSDate *)startDate ToEndDate:(NSDate *)endDate;



@end
