//
//  GoodsEntity.m
//  infoPromotion
//
//  Created by 朱靓慈 on 15/4/8.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "ProductEntity.h"

@implementation ProductEntity

@synthesize shop_id;
@synthesize product_id;
@synthesize product_name;
@synthesize price;
@synthesize create_user;
@synthesize ean;
@synthesize maker;
@synthesize min_price;
@synthesize costing;
@synthesize sold_count;
@synthesize des;
@synthesize cover;
@synthesize stock;
@synthesize supply_status;
@synthesize menber_price;
@synthesize product_category;
@synthesize create_time;
@synthesize update_time;
@synthesize is_join_activity ;
@synthesize chechkout_num;
@synthesize trade_product_id;
@synthesize trade_create_time;
@synthesize coupon_id;
@synthesize refund_count;
@synthesize index_path;
@synthesize sn;


- (id)copyWithZone:(NSZone *)zone
{
    ProductEntity *copy = [[[self class] allocWithZone:zone] init];
    copy->shop_id = [shop_id copy];
    copy->product_id = product_id;
    copy->product_name = [product_name copy];
    copy->price = price;
    copy->create_user = create_user;
    copy->ean = ean;
    copy->maker = [maker copy];
    copy->min_price = min_price;
    copy->costing = costing;
    copy->sold_count = sold_count;
    copy->des = [des copy];
    copy->cover = [cover copy];
    copy->stock = stock;
    copy->supply_status = supply_status;
    copy->menber_price = menber_price;
    copy->product_category = product_category;
    copy->create_time = create_time;
    copy->update_time = update_time;
    copy->is_join_activity = is_join_activity;
    copy->chechkout_num = chechkout_num;
    copy->trade_product_id =  [trade_product_id copy];
    copy->trade_create_time =  trade_create_time;
    copy->coupon_id =  [coupon_id copy];
    copy->refund_count =  refund_count;
    copy->index_path =  [index_path copy];
    copy->sn =  sn;
    return copy;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    ProductEntity *copy = [[[self class] allocWithZone:zone] init];
    copy->shop_id = [shop_id mutableCopy];
    copy->product_id = product_id;
    copy->product_name = [product_name mutableCopy];
    copy->price = price;
    copy->create_user = create_user;
    copy->ean = ean;
    copy->maker = [maker mutableCopy];
    copy->min_price = min_price;
    copy->costing = costing;
    copy->sold_count = sold_count;
    copy->des = [des mutableCopy];
    copy->cover = [cover mutableCopy];
    copy->stock = stock;
    copy->supply_status = supply_status;
    copy->menber_price = menber_price;
    copy->product_category = product_category;
    copy->create_time = create_time;
    copy->update_time = update_time;
    copy->is_join_activity = is_join_activity;
    copy->chechkout_num = chechkout_num;
    copy->trade_product_id =  [trade_product_id mutableCopy];
    copy->trade_create_time =  trade_create_time;
    copy->coupon_id = [coupon_id mutableCopy];
    copy->refund_count =  refund_count;
    copy->index_path =  [index_path mutableCopy];
    copy->sn =  sn;
    return copy;
}

@end
