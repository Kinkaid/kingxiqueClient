//
//  CheckoutProductCell.h
//  infoPromotion
//
//  Created by zhujingci on 15/8/12.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductEntity.h"

@protocol SelectProductsCellDelegate <NSObject>

-(void)addProductNum:(ProductEntity *)product atIndexPath:(NSIndexPath *)indexPath;
-(void)minusProductNum:(ProductEntity *)product atIndexPath:(NSIndexPath *)indexPath;
-(void)checkBigImage:(ProductEntity *)product;

@end

@interface SelectProductsCell : UITableViewCell

@property(strong,nonatomic) ProductEntity *product;
@property(strong,nonatomic) NSIndexPath *indexPath;
@property(weak,nonatomic) id<SelectProductsCellDelegate>delegate;

@end
