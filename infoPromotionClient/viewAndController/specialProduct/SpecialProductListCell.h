//
//  SpecialProductListCell.h
//  infoPromotionClient
//
//  Created by imac on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialProductListCell : UITableViewCell

@property (retain, nonatomic) CAGradientLayer *gradient;
//现价
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
//原价
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
//有效期
@property (weak, nonatomic) IBOutlet UILabel *validityLabel;
//商品描述
@property (weak, nonatomic) IBOutlet UILabel *productdescriptionLabel;
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
//剩余
@property (weak, nonatomic) IBOutlet UILabel *surplusLabel;
-(void)showDataWithDic:(NSDictionary *)productDic;
@end
