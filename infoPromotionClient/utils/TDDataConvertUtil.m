//
//  TDDataConvertUtil.m
//  infoPromotionClient
//
//  Created by zhujingci on 16/3/3.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "TDDataConvertUtil.h"

@implementation TDDataConvertUtil

//商品
+(ProductEntity *)getProductEntityWithDic:(NSDictionary *)dic{
    ProductEntity *productEntity = [[ProductEntity alloc]init];
    productEntity.product_id = dic[@"product_id"]?[NSString stringWithFormat:@"%@",dic[@"product_id"]]:nil;
    productEntity.create_user = dic[@"create_user"];
    productEntity.product_name = dic[@"product_name"];
    productEntity.price = [dic[@"price"] intValue];
    productEntity.ean = [NSString stringWithFormat:@"%@",dic[@"ean"]];
    productEntity.maker = dic[@"maker"];
    productEntity.min_price = [dic[@"min_price"] intValue];
    productEntity.costing = [dic[@"costing"] intValue];
    productEntity.sold_count = [dic[@"sold_count"] intValue];
    productEntity.des = dic[@"des"];
    productEntity.cover = dic[@"cover"];
    productEntity.supply_status = [dic[@"supply_status"] intValue];
    productEntity.menber_price = [dic[@"menber_price"] intValue];
    productEntity.product_category = [dic[@"product_category"] intValue];
    productEntity.create_time = [NSDate dateWithTimeIntervalSince1970:[dic[@"create_time"] longLongValue]/1000];
    productEntity.update_time = [NSDate dateWithTimeIntervalSince1970:[dic[@"update_time"] longLongValue]/1000];
    productEntity.is_join_activity = dic[@"is_join_activity"]?[dic[@"is_join_activity"] intValue]:1;
    productEntity.trade_product_id = dic[@"trade_product_id"];
    productEntity.stock = [dic[@"stock"] intValue];
    productEntity.chechkout_num = [dic[@"product_count"] intValue];
    productEntity.refund_count = [dic[@"refund_count"] intValue];
    productEntity.coupon_id = dic[@"coupon_id"]?[NSString stringWithFormat:@"%@",dic[@"coupon_id"]]:nil;
    productEntity.sn = [dic[@"sn"] intValue];
    return productEntity;
    
}

//商品列表
+(CheckoutCategoryEntity *)getCheckoutCategoryEntityWithDic:(NSDictionary *)dic{
    CheckoutCategoryEntity *categoryEntity = [[CheckoutCategoryEntity alloc] init];
    categoryEntity.category_id = dic[@"category_id"];
    categoryEntity.shop_id = dic[@"shop_id"];
    categoryEntity.category_name = dic[@"category_name"];
    categoryEntity.sn = [dic[@"sn"] intValue];
    categoryEntity.create_time = [TDDataUtil parseRemoteDataToDate:dic[@"create_time"]];
    categoryEntity.update_time = [TDDataUtil parseRemoteDataToDate:dic[@"update_time"]];
    NSMutableArray *productEntitys = [[NSMutableArray alloc] init];
    NSArray *productDics = dic[@"products"];
    for (NSDictionary *productDic in productDics) {
        ProductEntity *productEntity = [TDDataConvertUtil getProductEntityWithDic:productDic];
        [productEntitys addObject:productEntity];
    }
    categoryEntity.products = productEntitys;
    return categoryEntity;
}

@end
