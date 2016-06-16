//
//  TDDataUtil.m
//  infoPromotion
//
//  Created by chenkaiwei  on 15/4/30.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
// 处理远程数据

#import "TDDataUtil.h"

@implementation TDDataUtil
+(NSString*)parseRemoteMoneyString:(id)remoteData{
    if (remoteData) {
        NSString *remoteDataStr = [NSString stringWithFormat:@"%@",remoteData];
        NSString *dividStr = @"100";
        NSString *result = [TDDataUtil decimalNumberStrDivideWithString:remoteDataStr divideValue:dividStr];
        return result;
    } else{
        return @"0";
    }
   
}
+(NSDate *)parseRemoteDataToDate:(id)remoteData{
    long long dateTime =[remoteData longLongValue];
    return [NSDate dateWithTimeIntervalSince1970:dateTime/1000];
}
+(NSString *)parseRemoteDataToDateString:(id)remoteData withFormatterString: (NSString*)formatter{
    long long dateTime =[remoteData longLongValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateTime/1000];
    NSString *dateStr = [TDDateUtil stringFromDate:date withFormatterString:formatter];
    return dateStr;
}
//+(NSString *)parseModelDataToDateString:(long)remoteData withFormatterString: (NSString*)formatter
//{
//    long long dateTime =[remoteData longLongValue];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateTime/1000];
//    NSString *dateStr = [TDDateUtil stringFromDate:date withFormatterString:formatter];
//    return dateStr;
//}

+(NSNumber *)parseStrPriceToParamPrice:(NSString *)strPrice{
    if (!strPrice||strPrice.length==0) {
        strPrice = @"0";
    }
    NSString *multipleStr = @"100";
    NSString *result =[TDDataUtil decimalNumberStrMutiplyWithString:strPrice multiplicandValue:multipleStr];
    return [[NSNumber alloc] initWithInt:[result intValue]];
}
+(NSNumber *)parseIntPriceToParamPrice:(int)intPrice{
    return [[NSNumber alloc] initWithInt:intPrice];
}
+(NSNumber *)parseLocalDataToParamInt:(id)localData{
    return [[NSNumber alloc] initWithInt:[localData intValue]];
}
+(NSNumber *)parseLocalDataToParamDouble:(id)localData{
    return [[NSNumber alloc] initWithDouble:[localData doubleValue]];
}
+(NSNumber *)parseLocalDataToParamLongDate:(id)localData withFormatterString: (NSString*)formatter{
    NSDate *date = [TDDateUtil dateFromString:localData withFormatterString:formatter];
    return [[NSNumber alloc] initWithLongLong:[TDDateUtil longLongFromDate:date]];
}

+(NSString *) parseIntPriceToStrPrice:(int)intPrice{
    if (!intPrice&&intPrice!=0) {
        return nil;
    }
    NSString *priceStr = [NSString stringWithFormat:@"%i",intPrice];
    NSString *result = [self decimalNumberStrDivideWithString:priceStr divideValue:@"100"];
    return  result;
}

+(NSString *) parseLongPriceToStrPrice:(long)longPrice{
    if (!longPrice&&longPrice!=0) {
        return nil;
    }
    NSString *priceStr = [NSString stringWithFormat:@"%li",longPrice];
    NSString *result = [self decimalNumberStrDivideWithString:priceStr divideValue:@"100"];
    return  result;
}
+(int) parseStrPriceToIntPrice:(NSString *)strPrice{
    NSString *result = [self decimalNumberStrMutiplyWithString:strPrice multiplicandValue:@"100"];
    return [result intValue];
}
//商品数量Int转NSString
+(NSString *)parseIntProductCountToStrProductCount:(int)intProductCount{
    NSString *productCountStr = [NSString stringWithFormat:@"%i",intProductCount];
    return productCountStr;
}
//商品数量NSString转Int
+(int)parseStrProductCountToIntProductCount:(NSString *)strProductCount{
    return [strProductCount intValue];
}
//根据price和productcount计算总额
+(int)calIntTotalFeeWithPrice:(int)intPrice productCount:(int)intProductCount{
    NSString *priceStr =[NSString stringWithFormat:@"%i",intPrice];
    NSString *productCountStr = [NSString stringWithFormat:@"%i",intProductCount];
    NSString *totalFeeStr = [self decimalNumberStrMutiplyWithString:priceStr multiplicandValue:productCountStr];
    NSString *result = [self decimalNumberRounding:totalFeeStr afterPoint:0];
    return [result intValue];
}
//字符串相乘，得到NSString格式结果
+ (NSString *)decimalNumberStrMutiplyWithString:(NSString *)multiplierValue multiplicandValue:(NSString *)multiplicandValue
{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *result = [multiplierNumber decimalNumberByMultiplyingBy:multiplicandNumber];
    return [result stringValue];
}
//字符串相除，得到NSString格式结果
+ (NSString *)decimalNumberStrDivideWithString:(NSString *)dividendValue divideValue:(NSString *)divideValue
{
    NSDecimalNumber *divideNumber = [NSDecimalNumber decimalNumberWithString:divideValue];
    NSDecimalNumber *dividendNumber = [NSDecimalNumber decimalNumberWithString:dividendValue];
    NSDecimalNumber *result = [dividendNumber decimalNumberByDividingBy:divideNumber];
    return [result stringValue];
}
//字符串相加，得到NSDecimalNumber格式结果
+ (NSDecimalNumber *)decimalNumberAddWithString:(NSString *)addendValue addValue:(NSString *)addValue
{
    NSDecimalNumber *addNumber = [NSDecimalNumber decimalNumberWithString:addValue];
    NSDecimalNumber *addendNumber = [NSDecimalNumber decimalNumberWithString:addendValue];
    NSDecimalNumber *result = [addendNumber decimalNumberByAdding:addNumber];
    return result;
}
//字符串相减，得到NSDecimalNumber格式结果
+ (NSDecimalNumber *)decimalNumberSubtractWithString:(NSString *)subendValue subValue:(NSString *)subValue
{
    NSDecimalNumber *subNumber = [NSDecimalNumber decimalNumberWithString:subValue];
    NSDecimalNumber *subendNumber = [NSDecimalNumber decimalNumberWithString:subendValue];
    NSDecimalNumber *result = [subendNumber decimalNumberBySubtracting:subNumber];
    return result;
}
//字符串相乘，得到NSDecimalNumber格式结果
+ (NSDecimalNumber *)decimalNumberMutiplyWithString:(NSString *)multiplierValue multiplicandValue:(NSString *)multiplicandValue
{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *result = [multiplierNumber decimalNumberByMultiplyingBy:multiplicandNumber];
    return result;
}
//字符串相除，得到NSDecimalNumber格式结果
+ (NSDecimalNumber *)decimalNumberDivideWithString:(NSString *)dividendValue divideValue:(NSString *)divideValue
{
    NSDecimalNumber *divideNumber = [NSDecimalNumber decimalNumberWithString:divideValue];
    NSDecimalNumber *dividendNumber = [NSDecimalNumber decimalNumberWithString:dividendValue];
    NSDecimalNumber *result = [dividendNumber decimalNumberByDividingBy:divideNumber];
    return result;
}

//四舍五入
+(NSString *)decimalNumberRounding:(NSString *)strNumber afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithString:strNumber];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    //NSDictionary转换为Data
    NSData *jsonData = nil;
    if (dic) {
        jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    //Data转换为JSONSTRING
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



/*邮箱验证  */
+(BOOL) isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


/*车牌号验证 */
+(BOOL) validateCarNo:(NSString* )carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}

//

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
/*
 *由两个dic合并成一个dic
 */
+(NSMutableDictionary *)generateDictionaryFromOriginDic:(NSMutableDictionary *)originDic AndNewDic:(NSDictionary *)newDic
{
    NSArray *keys;
    id key, value;
    
    keys = [newDic allKeys];
    for (int i = 0; i < keys.count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [newDic objectForKey: key];
        [originDic setValue:value forKey:key];
    }
    return originDic;
}

+(NSString *)parseAliasToEllipsis:(NSString *)alias{
    NSString *ellipsisAlias = alias;
    if (ellipsisAlias.length==2) {
        ellipsisAlias = [alias stringByReplacingCharactersInRange:NSMakeRange(alias.length-1, 1) withString:@"*"];
    }else if(ellipsisAlias.length>2){
        for (int i=1; i<ellipsisAlias.length-1; i++) {
            ellipsisAlias = [ellipsisAlias stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
        }
    }
    return ellipsisAlias;
}

//根据顾客生命周期Id得到顾客生命周期名称
+(NSString *)parseRemoteLifeTypeToStrLifeType:(id)lifeType{
    return [self parseIntLifeTypeToStrLifeType:[lifeType intValue]];
}
+(NSString *)parseIntLifeTypeToStrLifeType:(int)lifeType{
    NSString *lifeTypeName = @"";
    switch (lifeType) {
        case CsLifeTypeIsNew:
            lifeTypeName = @"新顾客";
            break;
        case CsLifeTypeIsGrow:
            lifeTypeName = @"成长期顾客";
            break;
        case CsLifeTypeIsStable:
            lifeTypeName = @"稳定顾客";
            break;
        case CsLifeTypeIsLoyal:
            lifeTypeName = @"忠实顾客";
            break;
        case CsLifeTypeIsSilent:
            lifeTypeName = @"沉默顾客";
            break;
        case CsLifeTypeIsDie:
            lifeTypeName =@"快流失顾客";
            break;
        default:
            break;
    }
    return lifeTypeName;
}
@end
