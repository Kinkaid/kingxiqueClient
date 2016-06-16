//
//  SelectProductsCategoryCell.h
//  infoPromotion
//
//  Created by zhujingci on 15/8/13.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckoutCategoryEntity.h"

@interface SelectProductsCategoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

@property(strong,nonatomic)CheckoutCategoryEntity *categoryEntity;

@end
