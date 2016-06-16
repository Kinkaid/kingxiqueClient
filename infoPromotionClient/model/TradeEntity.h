//
//  TradeEntity.h
//  infoPromotion
//
//  Created by zhujingci on 15/4/25.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeEntity : NSObject

@property NSString *trade_id;
@property NSString *coupon_id;
@property NSDate *create_time;
@property NSArray *products;
@property NSString *pay_url;
@property int total_fee;
@property int trade_status;


@end
