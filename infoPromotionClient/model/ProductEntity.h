//
//  ProductEntity.h
//  infoPromotion
//
//  Created by 朱靓慈 on 15/4/8.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>
/*钱以分为单位*/
@interface ProductEntity : NSObject<NSCopying,NSMutableCopying>{
     NSString *shop_id;
     NSString *product_id;
     NSString *product_name;
     int price;
     NSDecimalNumber  *create_user;
     NSString *ean;
     NSString *maker;
     int min_price;
     int costing;
     int sold_count;//已售总数
     NSString *des;
     NSString *cover;
     int stock;
     int supply_status;
     int menber_price;
     int product_category;
     NSDate *create_time;
     NSDate *update_time;
     int is_join_activity ;
     int chechkout_num;
     NSString *trade_product_id;
     NSDate *trade_create_time;
     NSString *coupon_id;
     int refund_count;
     NSIndexPath *index_path;
    int sn;
}

@property NSString *shop_id;
@property NSString *product_id;//服务端goods新改为product
@property NSString *product_name;
@property int price;
@property NSDecimalNumber  *create_user;
@property NSString *ean;
@property NSString *maker;
@property int min_price;
@property int costing;
@property int sold_count;//已售总数
@property NSString *des;
@property NSString *cover;
@property int stock;
@property int supply_status;//产品供应状态，1：正在销售，2：下架
@property int menber_price;
@property int product_category;
@property NSDate *create_time;
@property NSDate *update_time;


@property int is_join_activity ;
//结算数量
@property int chechkout_num;
//交易清单中产品ID
@property NSString *trade_product_id;
@property NSDate *trade_create_time;
@property NSString *coupon_id;
//退款数量
@property int refund_count;
@property NSIndexPath *index_path;
@property int sn;


@end
