//
//  SelectProductsCategoryCell.m
//  infoPromotion
//
//  Created by zhujingci on 15/8/13.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "SelectProductsCategoryCell.h"

@implementation SelectProductsCategoryCell



-(void)setCategoryEntity:(CheckoutCategoryEntity *)categoryEntity{
    _categoryNameLabel.text = categoryEntity.category_name;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
