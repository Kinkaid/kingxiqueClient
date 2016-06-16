//
//  CouponEntity.h
//  infoPromotion
//
//  Created by zhujingci on 15/5/1.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponEntity : NSObject

@property NSString *shop_id;
@property NSString *coupon_id;
@property NSString *coupon_name;
@property NSString *seller_id;
@property NSString *des;
@property NSString *time_end;
@property NSString *time_start;

@property int coupon_type;//优惠券类别，1:满减优惠，2:折扣 3:代金券
@property int pay_count_limit;
@property int pay_amount_limit;
@property int use_count_limit;
@property int discount;
@property int mj_amount_limit;
@property int time_limit_type;
@property NSArray *time_limit;
@property NSDate *create_time;
@property BOOL selected;
@property BOOL isPlatPresent;//是否是平台赠送
@property long provider_id;//平台赠送此id为0，否则不为0
@property NSDecimalNumber *group_id;//小生易优惠活动group_id

//使用信息
@property int use_count;
@property int total_fee;
@property int total_discount;
@property int status;

@property BOOL isShowCouponUseInfo;//是否显示优惠券使用信息


@end
