//
//  AppDelegate.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/14.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LoginController.h"
#import "TDWeixinUtil.h"

NSString *ZFB_PAY_SUCCESS = @"ZFB_PAY_SUCCESS";
NSString *ZFB_PAY_FAIL = @"ZFB_PAY_FAIL";

CGFloat SCREEN_HEIGHT;
CGFloat SCREEN_WIDTH;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SCREEN_WIDTH= CGRectGetWidth([[UIScreen mainScreen] bounds]);
    SCREEN_HEIGHT=CGRectGetHeight([[UIScreen mainScreen] bounds]);
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        MainTabBarController *rootVC = [[MainTabBarController alloc] init];
    rootVC.tabBar.hidden= YES;
    window.rootViewController = rootVC;
    
    
    //向微信注册
    [WXApi registerApp:APP_ID withDescription:@"infoPromotionClient"];
    
    return YES;
}

#pragma mark -WXApiDelegate
//发送一个sendReq后，收到微信的回应
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        
        switch (resp.errCode) {
            case WXSuccess:
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:WEIXIN_PAY_SUCCESS object:nil];
                break;
                
            default:
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                [[NSNotificationCenter defaultCenter]postNotificationName:WEIXIN_PAY_FAIL object:nil];
                break;
        }
    }else if([resp isKindOfClass:[SendMessageToWXResp class]]){
        switch (resp.errCode) {
            case WXSuccess:
                [[NSNotificationCenter defaultCenter] postNotificationName:WEIXIN_SHARE_SUCCESS object:nil];
                break;
                
            default:
                NSLog(@"SendMessageToWXResp错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                [[NSNotificationCenter defaultCenter] postNotificationName:WEIXIN_SHARE_FAIL object:nil];
                break;
        }
    }else if([resp isKindOfClass:[SendAuthResp class]]){
        /*
         ErrCode ERR_OK = 0(用户同意)
         ERR_AUTH_DENIED = -4（用户拒绝授权）
         ERR_USER_CANCEL = -2（用户取消）
         code    用户换取access_token的code，仅在ErrCode为0时有效
         state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
         lang    微信客户端当前语言
         country 微信用户当前国家信息
         */
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode== 0) {
            NSString *code = aresp.code;
            [TDWeixinUtil getAccessToken:code];
        }
    }
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}
@end
