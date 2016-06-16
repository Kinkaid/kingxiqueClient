//
//  SelectProductsCartCell.m
//  infoPromotion
//
//  Created by zhujingci on 15/8/13.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "SelectProductsCartCell.h"

@implementation SelectProductsCartCell{
    
    __weak IBOutlet UILabel *_productNameLabel;
    
    __weak IBOutlet UILabel *_priceLabel;
    
    __weak IBOutlet UILabel *_productCountLabel;
    
}

-(void)setProduct:(ProductEntity *)product{
    _product = product;
    _productNameLabel.text = product.product_name;
    _priceLabel.text = [TDDataUtil parseIntPriceToStrPrice:product.price];
    _productCountLabel.text = [NSString stringWithFormat:@"%i",product.chechkout_num];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)minusCartProductNumHandler:(id)sender {
    if (_product.chechkout_num>0) {
        _product.chechkout_num--;
        _productCountLabel.text = [NSString stringWithFormat:@"%i",_product.chechkout_num];
        [self.delegate minusCartProduct:_product];
    }
    
}

- (IBAction)addCartProductNumHandler:(id)sender {
    _product.chechkout_num++;
    _productCountLabel.text = [NSString stringWithFormat:@"%i",_product.chechkout_num];
    [self.delegate addCartProductNum:_product];
}

@end
