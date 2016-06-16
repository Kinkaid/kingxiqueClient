//
//  TDDataUtil.h
//  infoPromotion
//
//  Created by chenkaiwei  on 15/4/30.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDDataUtil : NSObject
+(NSString*)parseRemoteMoneyString:(id)remoteData;
+(NSDate *)parseRemoteDataToDate:(id)remoteData;
+(NSString *)parseRemoteDataToDateString:(id)remoteData withFormatterString: (NSString*)formatter;


+(NSNumber *)parseStrPriceToParamPrice:(NSString *)strPrice;
+(NSNumber *)parseIntPriceToParamPrice:(int)intPrice;
+(NSNumber *)parseLocalDataToParamInt:(id)localData;
+(NSNumber *)parseLocalDataToParamDouble:(id)localData;
+(NSNumber *)parseLocalDataToParamLongDate:(id)localData withFormatterString: (NSString*)formatter;

+(NSString *) parseIntPriceToStrPrice:(int)intPrice;
+(NSString *) parseLongPriceToStrPrice:(long)longPrice;
+(int) parseStrPriceToIntPrice:(NSString *)strPrice;

//商品数量Int转NSString
+(NSString *)parseIntProductCountToStrProductCount:(int)productCountInt;


//商品数量NSString转Int
+(int)parseStrProductCountToIntProductCount:(NSString *)strProductCount;
//根据price和productcount计算总额
+(int)calIntTotalFeeWithPrice:(int)intPrice productCount:(int)intProductCount;

//昵称中间加省略
+(NSString *)parseAliasToEllipsis:(NSString *)alias;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


+(BOOL) isValidateEmail:(NSString *)email;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSMutableDictionary *)generateDictionaryFromOriginDic:(NSMutableDictionary *)originDic AndNewDic:(NSDictionary *)newDic;

//字符串相加，得到NSDecimalNumber格式结果
+ (NSDecimalNumber *)decimalNumberAddWithString:(NSString *)addendValue addValue:(NSString *)addValue;

//字符串相减，得到NSDecimalNumber格式结果
+ (NSDecimalNumber *)decimalNumberSubtractWithString:(NSString *)subendValue subValue:(NSString *)subValue;

//字符串相乘，得到NSDecimalNumber格式结果
+ (NSDecimalNumber *)decimalNumberMutiplyWithString:(NSString *)multiplierValue multiplicandValue:(NSString *)multiplicandValue;

//字符串相除，得到NSDecimalNumber格式结果
+ (NSDecimalNumber *)decimalNumberDivideWithString:(NSString *)dividendValue divideValue:(NSString *)divideValue;

+(NSString *)decimalNumberRounding:(NSString *)strNumber afterPoint:(int)position;

//根据顾客生命周期Id得到顾客生命周期名称
+(NSString *)parseRemoteLifeTypeToStrLifeType:(id)lifeType;
+(NSString *)parseIntLifeTypeToStrLifeType:(int)lifeType;

@end
