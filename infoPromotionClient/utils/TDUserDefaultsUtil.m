//
//  TDUserDefaultsUtil.m
//  infoPromotion
//
//  Created by 朱靓慈 on 15/4/22.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "TDUserDefaultsUtil.h"


@implementation TDUserDefaultsUtil

static long _index=0;

+(void)setShopIndex:(long)index{
    _index=index;
}
+(long)getShopIndex{
    return _index;
}
//+(NSString *) getUserId:(NSUserDefaults*)userDefaults{
//    return [userDefaults valueForKey:@"user_id"] ;
//}
+(NSDecimalNumber *)getCustomerId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [[NSDecimalNumber alloc] initWithString:[userDefaults valueForKey:@"customer_id"]];
}
+(NSDecimalNumber *) getShopId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *shopInfo = [[userDefaults valueForKey:@"shops"] objectAtIndex:_index];
    return [[NSDecimalNumber alloc] initWithString:[shopInfo valueForKey:@"shop_id"]];
}
+(BOOL)haveShopId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *shopInfo = [[userDefaults valueForKey:@"shops"] objectAtIndex:_index];
    if ([shopInfo valueForKey:@"shop_id"]) {
        return YES;
    }
    return NO;
}
+(NSString *) getShopName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *shopInfo = [[userDefaults valueForKey:@"shops"] objectAtIndex:_index];
    return [shopInfo valueForKey:@"shop_name"];
}
+(NSDictionary *)getShop {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [[userDefaults valueForKey:@"shops"] objectAtIndex:_index];
}

+(NSArray *) getShops{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"shops"] ;
}
+(NSString *) getMobile{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"mobile"] ;
}
+(NSString *) getPsw{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"psw"];
}
+(NSDecimalNumber *)getSellerId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *shopInfo = [[userDefaults valueForKey:@"shops"] objectAtIndex:_index];
    NSString *sellerId = [shopInfo valueForKey:@"seller_id"];
    return [[NSDecimalNumber alloc] initWithString:sellerId];
    
}
+(NSString *)getContactName{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *shopInfo = [[userDefaults valueForKey:@"shops"] objectAtIndex:_index];
    NSString *contactName = [shopInfo valueForKey:@"contact_name"];
    return contactName;
    
}
+(NSArray *)getPrivileges{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *shopInfo = [[userDefaults valueForKey:@"shops"] objectAtIndex:_index];
    NSArray *privileges = [shopInfo valueForKey:@"privileges"];
    return privileges;
    
}
+(NSString *)getInviteCode{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *shopInfo = [[userDefaults valueForKey:@"shops"] objectAtIndex:_index];
    NSString *inviteCode = [shopInfo valueForKey:@"invite_code"];
    return inviteCode;
}
+(NSString *)getShopXzqhId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *shopInfo = [[userDefaults valueForKey:@"shops"] objectAtIndex:_index];
    NSString *xzqhId = [shopInfo valueForKey:@"xzqh_id"];
    return xzqhId;
}
+(NSString *)getToken{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return [userDefaults valueForKey:@"token"];
    return @"56d795510cf2c38ec5e8837b";
}
+(NSString *)getKey{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"key"] ;
}
+(NSArray *)getUnits{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"units"] ;
}
+(int)getSellerRole{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *shopInfo = [[userDefaults valueForKey:@"shops"] objectAtIndex:_index];
    int sellerRole = [shopInfo[@"seller_role"] intValue];
    return sellerRole;
}
//删除用户信息
+(void) deleteUserDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"alias"];
    [userDefaults removeObjectForKey:@"psw"];
    [userDefaults removeObjectForKey:@"mobile"];
    [userDefaults removeObjectForKey:@"customer_id"];
    [userDefaults removeObjectForKey:@"gendor"];
    [userDefaults removeObjectForKey:@"avatar"];
    [userDefaults removeObjectForKey:@"token"];
    [userDefaults removeObjectForKey:@"key"];
    [userDefaults removeObjectForKey:@"shops"];
    [userDefaults removeObjectForKey:@"units"];
    [userDefaults removeObjectForKey:@"invite_code"];
    [userDefaults synchronize];
}
+(BOOL)havePhoneNum{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"mobile"] length]==11) {
        return YES;
    }
    return NO;
}
@end
