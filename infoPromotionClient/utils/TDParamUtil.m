//
//  TDParamUtil.m
//  TDParamUtil
//
//  Created by zhujingci on 15/9/14.
//  Copyright (c) 2015年 tuda. All rights reserved.
//

#import "TDParamUtil.h"
#import "CocoaSecurity.h"

@implementation TDParamUtil

+(NSDictionary *) formatServiceParam:(NSDictionary *)params{
//    //NSDictionary转换为Data
//    NSData *paramJson = nil;
//    if (params) {
//        paramJson = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
//    }
//    
//    //Data转换为JSONSTRING
//    NSString *paramStr = [[NSString alloc] initWithData:paramJson encoding:NSUTF8StringEncoding];
//    
//    //aes加密获得签名
//    CocoaSecurityResult *resultAES = [CocoaSecurity aesEncrypt:paramStr hexKey:APPSECRET hexIv:IV];
//    NSString *resultStr = resultAES.hexLower;
//    return @{@"params":resultStr};
    return params;
}
+(NSString *) formatAuthorization:(NSDictionary *)params{
    
    //NSDictionary转换为Data
    NSData *paramJson = nil;
    if (params) {
        paramJson = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    //Data转换为JSONSTRING
    NSString *paramStr = [[NSString alloc] initWithData:paramJson encoding:NSUTF8StringEncoding];
    
    NSString *token = [TDUserDefaultsUtil getToken];
    NSString *key = [TDUserDefaultsUtil getKey];
    
    NSDate *date = [NSDate date];
    long timeStamp = [TDDateUtil longLongFromDate:date];
    
    NSString *signOriginStr = @"";
    
    if (params) {//参数不为空
        signOriginStr = [NSString stringWithFormat:@"%@%li%@",key,timeStamp,paramStr];
    }else{//参数为空
        signOriginStr = [NSString stringWithFormat:@"%@%li%@",key,timeStamp,@""];
    }
    
    
    //md5加密获得签名
    CocoaSecurityResult *signMd5 = [CocoaSecurity md5:signOriginStr];
    NSString *sign = signMd5.hex;
    NSString *authorization = [NSString stringWithFormat:@"%@&%li&%@",token,timeStamp,sign];
    return authorization;
}

@end
