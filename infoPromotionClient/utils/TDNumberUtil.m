//
//  TDNumberUtil.m
//  infoPromotion
//
//  Created by 朱靓慈 on 15/4/8.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "TDNumberUtil.h"

@implementation TDNumberUtil

+(NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}
+(NSString *) stringFromInt:(int)intValue{
    return [NSString stringWithFormat:@"%i",intValue];
}
+(NSNumber *) numberFromInt:(int)intValue{
    return [[NSNumber alloc] initWithInt:intValue];
}
+(NSDate *) dateFromLongObj:(id)dateObj{
    return [NSDate dateWithTimeIntervalSince1970:[dateObj longLongValue]/1000];
}
+(BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

+(BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

@end
