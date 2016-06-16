//
//  SpecialProductDetailCell.h
//  infoPromotionClient
//
//  Created by imac on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialProductDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
-(void)showDataWithDic:(NSDictionary *)productDic;
@end
