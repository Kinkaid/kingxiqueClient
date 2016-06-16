//
//  TDConfigInfoUtil.h
//  infoPromotion
//
//  Created by zhujingci on 15/11/18.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const APPID = @"tgram";
static NSString * const APPSECRET = @"a9338fce6b23cb1af1c735ad65c0d032";
static NSString * const IV = @"e6850dd78f3778606d37c5d5344cb4f7";


//static NSString * const UPYUNURL = @"http://res.kingxique.com/magpie/v2.0.0";//正式
//static NSString * const SERVICEURL = @"http://www.kingxique.com/magpie/api/v2.0";//正式
//static NSString * const SERVICEURL_NEW = @"http://www.kingxique.com/magpie/api/v2.0";//正式
//static NSString * const  SERVICEURL_PRE= @"http://www.kingxique.com";//正式
//又拍云图片上传地址
//static NSString *const IMAGEURL = @"http://pic.kingxique.com/";//正式
/*注意，一定要去UpYun.h改DEFAULT_BUCKET和DEFAULT_PASSCODE*/

static NSString * const UPYUNURL = @"http://res.567m.com/magpie";//测试
static NSString * const SERVICEURL = @"http://192.168.1.188:19080/vip";//测试
static NSString * const SERVICEURL_NEW = @"http://api.567m.com:4080/xsy/3.0";//测试
static NSString * const  SERVICEURL_PRE= @"http://www.567m.com";//测试

//又拍云图片上传地址
static NSString * const IMAGEURL = @"http://pic.567m.com/";//测试
/*注意，一定要去UpYun.h改DEFAULT_BUCKET和DEFAULT_PASSCODE*/

//友盟AppKey
static NSString *const UMENG_APPKEY = @"560a140867e58eec2e003f3a";

//appstore APPID
#define kStoreAppId @"1025410959"

//高德地图 APIKEY
static NSString *const MAMAP_APIKEY = @"a2b905c4ed89c8d0c2005c59b0641481";

//微信相关
/*注意，payRequsestHandler.h 修改相关参数*/

//支付宝相关
/*注意，AlipayHeader.h 修改相关参数*/

/*注意不要忘了50单*/

/*注意不要忘了将PushConfig.plist中的APS_FOR_PRODUCTION改成开发环境或生产环境对应的值。开发环境为0，生产环境为1*/

@interface TDConfigInfoUtil : NSObject

@end
