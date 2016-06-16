//
//  CheckoutCategoryEntity.h
//  infoPromotion
//
//  Created by zhujingci on 15/9/2.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckoutCategoryEntity : NSObject
@property NSString *category_id;
@property NSString *shop_id;
@property NSString *category_name;
@property int sn;
@property NSDate *create_time;
@property NSDate *update_time;
@property NSArray *products;

@end
