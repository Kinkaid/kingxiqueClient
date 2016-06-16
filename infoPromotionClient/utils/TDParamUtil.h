//
//  TDParamUtil.h
//  infoPromotion
//
//  Created by 朱靓慈 on 15/3/2.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDParamUtil : NSObject

+(NSDictionary *) formatServiceParam:(NSDictionary *)params;

+(NSString *) formatAuthorization:(NSDictionary *)params;

@end
