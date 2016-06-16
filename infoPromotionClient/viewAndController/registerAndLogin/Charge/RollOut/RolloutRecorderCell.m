//
//  RolloutRecorderCell.m
//  infoPromotion
//
//  Created by imac on 15/9/28.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import "RolloutRecorderCell.h"

@implementation RolloutRecorderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showDataWithDictionary:(NSDictionary *)dic
{
    self.money.text = [NSString stringWithFormat:@"%@",[TDDataUtil parseIntPriceToStrPrice:[dic[@"change"] intValue]]];
    self.date.text = [NSString stringWithFormat:@"%@",[TDDataUtil parseRemoteDataToDateString:dic[@"update_time"] withFormatterString:@"yyyy.MM.dd HH:mm"]];
    self.bankLogoImageView.image =[UIImage imageNamed:self.bankName.text]?[UIImage imageNamed:self.bankName.text]:[UIImage imageNamed:@"default-bankcard"];
}
@end
