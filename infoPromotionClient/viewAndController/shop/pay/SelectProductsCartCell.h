//
//  SelectProductsCartCell.h
//  infoPromotion
//
//  Created by zhujingci on 15/8/13.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductEntity.h"

@protocol SelectProductsCartCellDelegate <NSObject>

-(void)minusCartProduct:(ProductEntity *)product;
-(void)addCartProductNum:(ProductEntity *)product;

@end

@interface SelectProductsCartCell : UITableViewCell

@property(strong,nonatomic) ProductEntity *product;

@property(weak,nonatomic)NSObject<SelectProductsCartCellDelegate> *delegate;

@end
