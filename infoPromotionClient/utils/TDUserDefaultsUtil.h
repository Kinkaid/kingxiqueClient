//
//  TDUserDefaultsUtil.h
//  infoPromotion
//
//  Created by 朱靓慈 on 15/4/22.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

static  NSString* SHOP_CHANGED=@"shopChanged";
@interface TDUserDefaultsUtil : NSObject

+(void)setShopIndex:(long) index;
+(long)getShopIndex;
+(NSDecimalNumber *)getCustomerId;
+(NSDecimalNumber *)getShopId ;
+(BOOL)haveShopId;
+(NSString *) getShopName;
+(NSDictionary *)getShop;
+(NSArray *) getShops;
+(NSString *) getMobile;
+(NSString *) getPsw;//获取密码
+(NSDecimalNumber *)getSellerId;
+(NSString *)getContactName;//获取店主姓名
+(NSArray *)getPrivileges;
+(NSString *)getToken;
+(NSString *)getKey;
+(NSArray *)getUnits;
+(NSString *)getInviteCode;//邀请码
+(NSString *)getShopXzqhId;
+(int)getSellerRole;
//删除用户信息
+(void) deleteUserDefaults;
+(BOOL)havePhoneNum;
@end
