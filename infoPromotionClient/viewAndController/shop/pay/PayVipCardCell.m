//
//  PayVipCardCell.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/23.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "PayVipCardCell.h"

@implementation PayVipCardCell{
    
    __weak IBOutlet UIImageView *_vipcardMarkImage;
    __weak IBOutlet NSLayoutConstraint *_toplineMarginLeft;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showCellWithModel:(CouponEntity *)coupon andIndex:(NSIndexPath *)indexPath{
    if (indexPath.row>0) {
        _vipcardMarkImage.hidden = YES;
        _toplineMarginLeft.constant = 45;
    }else{
        _vipcardMarkImage.hidden = NO;
        _toplineMarginLeft.constant = 0;
    }
}

@end
