//
//  ServiceManager.h
//  citylife
//
//  Created by chenkaiwei  on 15-1-8.
//  Copyright (c) 2015年 tgram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

static NSString *FAIL = @"fail";
@interface ServiceManager : NSObject

+(ServiceManager*)sharedInstance;

//==第一组
-(void)postToMethod:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic successAlert:(NSString*)sucAlertMsg failureAlert:(NSString*)failAlertMsg;

-(void)getToMethod:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic successAlert:(NSString*)sucAlertMsg failureAlert:(NSString*)failAlertMsg;

-(void)putToMethod:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic successAlert:(NSString*)sucAlertMsg failureAlert:(NSString*)failAlertMsg;
-(void)deleteToMethod:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic successAlert:(NSString*)sucAlertMsg failureAlert:(NSString*)failAlertMsg;

//==第二组
-(void)postAction:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;
-(void)getAction:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;
-(void)putAction:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;
-(void)deleteAction:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;

//==第三组(带动态参数)
-(void)postFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;
-(void)getFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;
-(void)putFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;
-(void)deleteFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;

//==第四组(新的接口地址)
-(void)postNewFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;
-(void)getNewFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;
-(void)putNewFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;
-(void)deleteNewFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail;


@end
