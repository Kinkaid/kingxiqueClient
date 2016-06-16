//
//  TDColorUtil.h
//  infoPromotion
//
//  Created by chenkaiwei  on 15-2-12.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TDColorUtil : NSObject

+(UIColor *)parse:(NSString *)color;

+(UIColor *)themeColor;

+(UIColor*)tabbarColor;

+(UIColor*)tabbarSelectColor;

+(UIColor *)navigationBarTintColor;

+(UIColor *)navigationBarTitleColor;

@end
