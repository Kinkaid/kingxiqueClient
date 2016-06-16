//
//  CheckoutProductCell.m
//  infoPromotion
//
//  Created by zhujingci on 15/8/12.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "SelectProductsCell.h"

@implementation SelectProductsCell{
    
    __weak IBOutlet UIImageView *_img;
    
    __weak IBOutlet UILabel *_priceLabel;
    
    __weak IBOutlet UILabel *_productNameLabel;
    
    __weak IBOutlet UILabel *_stockLabel;
    
    __weak IBOutlet UILabel *_productCountLabel;
    
    
}

-(void)setProduct:(ProductEntity *)product{
    _product = product;
    [_img sd_setImageWithURL:[TDImageUtil getThumbImageURLById:product.cover] placeholderImage:[UIImage imageNamed:@"icon-product-default"]];
    _productNameLabel.text = product.product_name;
    _stockLabel.text = _product.stock>0?[NSString stringWithFormat:@"库存 %i件",_product.stock]:@"暂无库存信息";
    _priceLabel.text = [TDDataUtil parseIntPriceToStrPrice:product.price];
    _productCountLabel.text = [NSString stringWithFormat:@"%i",_product.chechkout_num];
}
//加
- (IBAction)addNumHandler:(id)sender {
   
    _product.chechkout_num ++;
    _productCountLabel.text = [NSString stringWithFormat:@"%i",_product.chechkout_num];
     [self.delegate addProductNum:_product atIndexPath:_indexPath];
    
}
//减
- (IBAction)minusNumHandler:(id)sender {
    if (_product.chechkout_num>0) {
        _product.chechkout_num--;
        _productCountLabel.text = [NSString stringWithFormat:@"%i",_product.chechkout_num];
        [self.delegate minusProductNum:_product atIndexPath:_indexPath];
    }
    
}
//查看大图
- (IBAction)checkBigImageHandler:(id)sender {
    [self.delegate checkBigImage:_product];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
