//
//  TDNumberUtil.h
//  infoPromotion
//
//  Created by 朱靓慈 on 15/4/8.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDNumberUtil : NSObject

+(NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV;
+(NSString *) stringFromInt:(int)intValue;
+(NSNumber *) numberFromInt:(int)intValue;
+(NSDate *) dateFromLongObj:(id)dateObj;
+(BOOL)isPureInt:(NSString*)string;
+(BOOL)isPureFloat:(NSString*)string;


@end
