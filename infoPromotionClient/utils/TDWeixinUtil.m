//
//  TDWeixinUtil.m
//  infoPromotion
//
//  Created by chenkaiwei  on 15/5/13.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//
#import "payRequsestHandler.h"
#import "TDWeixinUtil.h"
#import "WXApi.h"


@implementation TDWeixinUtil



+(void)sendAuthLoginRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendAuthReq:req viewController:nil delegate:nil];
}
+(void)sendLinkContent:(NSDictionary *)dic
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = dic[@"title"];
    message.description = dic[@"description"];
    //    [message setThumbImage:dic[@"image"]];
    NSData *imageData = UIImageJPEGRepresentation(dic[@"image"], 0.1f);
    [message setThumbData:imageData];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = dic[@"webpageUrl"];
    
    message.mediaObject = ext;
    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

//通过code获取access_token
+(void)getAccessToken:(NSString *)code{
    
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",APP_ID,APP_SECRET,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *access_token = [dic objectForKey:@"access_token"];
                NSString *openid = [dic objectForKey:@"openid"];
                NSString *refresh_token = [dic objectForKey:@"refresh_token"];
                [self verifyAuthByToken:access_token refreshToken:refresh_token openid:openid];
                
            }
        });
    });
}

//获取access_token后，进行接口调用
+(void)verifyAuthByToken:(NSString *)access_token refreshToken:(NSString *)refresh_token openid:(NSString *)openid{
    //    https://api.weixin.qq.com/sns/auth?access_token=ACCESS_TOKEN&openid=OPENID
    NSString *url=[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/auth?access_token=%@&openid=%@",access_token,openid];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSString *errmsg = [dic objectForKey:@"errmsg"];
                if ([errmsg isEqualToString:@"ok"]) {
                    [self getUserInfoByToken:access_token refreshToken:refresh_token openId:openid];
                }else{
                    [self refreshAccessTokenByAppid:APP_ID refreshToken:refresh_token openid:openid];
                }
                
            }
        });
    });
}
//若access_token已超时进行refresh_token
+(void)refreshAccessTokenByAppid:(NSString *)appid refreshToken:(NSString *)refreshToken openid:(NSString *)openid{
    //https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=APPID&grant_type=refresh_token&refresh_token=REFRESH_TOKEN
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",appid,refreshToken];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *access_token = [dic objectForKey:@"access_token"];
                NSString *openid = [dic objectForKey:@"openid"];
                [self verifyAuthByToken:access_token refreshToken:refreshToken openid:openid];
                
            }
        });
    });
}
//获取用户信息
+(void)getUserInfoByToken:(NSString *)access_token refreshToken:(NSString *)refresh_token openId:(NSString *)openid
{
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSMutableDictionary *weixinData = [[NSMutableDictionary alloc]initWithDictionary:dic];
                [weixinData setValue:access_token forKey:@"access_token"];
                [weixinData setValue:refresh_token forKey:@"refresh_token"];
                [[NSNotificationCenter defaultCenter] postNotificationName:WEIXIN_AUTH_LOGIN_SUCCESS object:weixinData];
                /*
                 {
                 city = Haidian;
                 country = CN;
                 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
                 language = "zh_CN";
                 nickname = "xxx";
                 openid = oyAaTjsDx7pl4xxxxxxx;
                 privilege =     (
                 );
                 province = Beijing;
                 sex = 1;
                 unionid = oyAaTjsxxxxxxQ42O3xxxxxxs;
                 }
                 */
                
                
            }
        });
        
    });
}
+ (void)sendPay:(NSMutableDictionary *)signParams
{
    if(signParams == nil){
        
        [self alert:@"提示信息" msg:@"服务器返回数据出错"];
    }else{
        
        NSMutableString *stamp  = [signParams objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [signParams objectForKey:@"appid"];
        req.partnerId           = [signParams objectForKey:@"partnerid"];
        req.prepayId            = [signParams objectForKey:@"prepayid"];
        req.nonceStr            = [signParams objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [signParams objectForKey:@"package"];
        req.sign                = [signParams objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
}
+ (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}
+(void)sendImageContent:(UIImage *)image scene:(int)scene{
    WXMediaMessage *message = [WXMediaMessage message];
    
    CGSize thumbImgSize = CGSizeMake(image.size.width/3.0f, image.size.height/3.0f);
    UIImage *thumbImage = [TDImageUtil thumbnailWithImageWithoutScale:image size:thumbImgSize];
    [message setThumbImage:thumbImage];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImageJPEGRepresentation(image, 1.0);
    
    message.mediaObject = ext;
//    message.mediaTagName = @"WECHAT_TAG_JUMP_APP";
//    message.messageExt = @"这是第三方带的测试字段";
//    message.messageAction = @"<action>dotalist</action>";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    [WXApi sendReq:req];
}
@end
