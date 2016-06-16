//
//  TDDataConvertUtil.h
//  infoPromotionClient
//
//  Created by zhujingci on 16/3/3.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductEntity.h"
#import "CheckoutCategoryEntity.h"

@interface TDDataConvertUtil : NSObject

//商品
+(ProductEntity *)getProductEntityWithDic:(NSDictionary *)dic;

//商品列表
+(CheckoutCategoryEntity *)getCheckoutCategoryEntityWithDic:(NSDictionary *)dic;
@end
