//
//  CheckoutPayChannelCell.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/23.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "PayChannelCell.h"

@implementation PayChannelCell{
   
    __weak IBOutlet UIView *_towLineView;
    
    __weak IBOutlet UILabel *_towLinePayChannelLabel;
    
    __weak IBOutlet UILabel *_payChannelSubTxtLabel;
    
    __weak IBOutlet UIView *_oneLineView;
    
    __weak IBOutlet UILabel *_oneLinePayChannelLabel;
    
    __weak IBOutlet UIImageView *_payChannelImage;
    
    __weak IBOutlet UIImageView *_payChannelSelectImage;
    
    __weak IBOutlet NSLayoutConstraint *_thinLineMarginLeft;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showCellWithModel:(PayChannelEntity *)payChannelEntity{
    if ([payChannelEntity.payChannelImageStr isEqualToString:@"icon_youhuiquan"]) {
        self.imageWidth.constant = 17;
        self.imageHeight.constant = 11;
    }else{
        self.imageHeight.constant = 21;
        self.imageWidth.constant = 21;
    }
    if (payChannelEntity.payChannelSubTxt&&payChannelEntity.payChannelSubTxt.length>0) {
        _towLineView.hidden = NO;
        _oneLineView.hidden = YES;
        _towLinePayChannelLabel.text = payChannelEntity.payChannel;
        _payChannelSubTxtLabel.text = payChannelEntity.payChannelSubTxt;
    }else{
        _towLineView.hidden = YES;
        _oneLineView.hidden = NO;
        _oneLinePayChannelLabel.text = payChannelEntity.payChannel;
    }
    _payChannelImage.image = [UIImage imageNamed:payChannelEntity.payChannelImageStr];
    if (payChannelEntity.payChannelImageStr&&payChannelEntity.payChannelImageStr.length>0) {
        _thinLineMarginLeft.constant = 0.0f;
    }else{
        _thinLineMarginLeft.constant = 55.0f;
    }
    if (payChannelEntity.payChannelSelect) {
        _payChannelSelectImage.image = [UIImage imageNamed:@"refundOrder_selected"];
    }else{
        _payChannelSelectImage.image = [UIImage imageNamed:@"refundOrder_unselected"];
    }
}
@end
