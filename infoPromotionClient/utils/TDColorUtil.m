//
//  TDColorUtil.m
//  infoPromotion
//
//  Created by chenkaiwei  on 15-2-12.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "TDColorUtil.h"

@implementation TDColorUtil
+(UIColor *) parse:(NSString *)color
{
    unsigned int r, g, b;
    UIColor *result;
    float color_const = 255.0f;
    //如果是#ffffff格式
    if(color.length == 7 && [color hasPrefix:@"#"]) {
        color = [color substringFromIndex:1];
        NSRange range;
        
        range.location = 0;
        range.length = 2;
        NSString * rStr = [color substringWithRange:range];
        range.location = 2;
        NSString * gStr = [color substringWithRange:range];
        range.location = 4;
        NSString * bStr = [color substringWithRange:range];
        
        [[NSScanner scannerWithString:rStr] scanHexInt:&r];
        [[NSScanner scannerWithString:gStr] scanHexInt:&g];
        [[NSScanner scannerWithString:bStr] scanHexInt:&b];
        
        result = [UIColor colorWithRed:r/color_const green:g/color_const blue:b/color_const alpha:1.0f];
    } else if([color hasPrefix:@"rgba"]) {//如果是rgba格式
        color = [color substringFromIndex:5];
        color = [color stringByReplacingOccurrencesOfString:@")" withString:@""];
        NSArray * temp = [color componentsSeparatedByString:@","];
        
        NSString *rStr = [temp objectAtIndex:0];
        NSString *gStr = [temp objectAtIndex:1];
        NSString *bStr = [temp objectAtIndex:2];
        NSString *aStr = [temp objectAtIndex:3];
        
        double a;
        [[NSScanner scannerWithString:rStr] scanHexInt:&r];
        [[NSScanner scannerWithString:gStr] scanHexInt:&g];
        [[NSScanner scannerWithString:bStr] scanHexInt:&b];
        [[NSScanner scannerWithString:aStr] scanDouble:&a];
        
        result = [UIColor colorWithRed:r/color_const green:g/color_const blue:b/color_const alpha:a];
    } else if([color hasPrefix:@"rgb("]) {//如果是rgb格式
        color = [color substringFromIndex:4];
        color = [color stringByReplacingOccurrencesOfString:@")" withString:@""];
        NSArray * temp = [color componentsSeparatedByString:@","];
        
        NSString *rStr = [temp objectAtIndex:0];
        NSString *gStr = [temp objectAtIndex:1];
        NSString *bStr = [temp objectAtIndex:2];
        
        [[NSScanner scannerWithString:rStr] scanHexInt:&r];
        [[NSScanner scannerWithString:gStr] scanHexInt:&g];
        [[NSScanner scannerWithString:bStr] scanHexInt:&b];
        
        result = [UIColor colorWithRed:r/color_const green:g/color_const blue:b/color_const alpha:1.0f];
    }
    
    return result;
}

+(UIColor*)themeColor{
//    return [TDColorUtil parse:@"#4CBDCD"];
    return [TDColorUtil parse:@"#B13621"];
//    return [TDColorUtil parse:@"#F7F7F7"];
    
}

+(UIColor*)tabbarColor{
    //    return [TDColorUtil parse:@"#4CBDCD"];
    return [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.8];
}
+(UIColor*)tabbarSelectColor{
    return [TDColorUtil parse:@"#B13621"];
}
+(UIColor *)navigationBarTintColor{
    return [UIColor whiteColor];
}
+(UIColor *)navigationBarTitleColor{
    return [UIColor whiteColor];
}
@end
