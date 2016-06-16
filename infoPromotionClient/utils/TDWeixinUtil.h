//
//  TDWeixinUtil.h
//  infoPromotion
//
//  Created by chenkaiwei  on 15/5/13.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "payRequsestHandler.h"//微信支付服务器签名支付请求请求类


static NSString *WEIXIN_AUTH_LOGIN_SUCCESS=@"WEIXIN_AUTH_LOGIN_SUCCESS";
static NSString *WEIXIN_PAY_SUCCESS = @"WEIXIN_PAY_SUCCESS";
static NSString *WEIXIN_PAY_FAIL=@"WEIXIN_PAY_FAIL";
static NSString *WEIXIN_SHARE_SUCCESS = @"WEIXIN_SHARE_SUCCESS";
static NSString *WEIXIN_SHARE_FAIL = @"WEIXIN_SHARE_FAIL";


@interface TDWeixinUtil : NSObject

+(void)sendAuthLoginRequest;
+(void)sendLinkContent:(NSDictionary *)dic;
+(void)getAccessToken:(NSString *)code;
+ (void)sendPay:(NSMutableDictionary *)signParams;
+(void)sendImageContent:(UIImage *)image scene:(int)scene;

@end
