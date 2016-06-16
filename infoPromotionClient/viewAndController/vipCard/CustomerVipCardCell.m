//
//  CustomerVipCardCell.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/30.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "CustomerVipCardCell.h"

@implementation CustomerVipCardCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showDataWithDictionary:(NSDictionary *)dic
{
    [self showCardItemWithCardType:[dic[@"cardType"] intValue]];

}
-(void)showCardItemWithCardType:(int)cardType
{
    switch (cardType) {
        case 1:
        {
           [self initWithCardNameLeftImage:[UIImage imageNamed:@"yuanlv"] AndRightImage:[UIImage imageNamed:@"yuanlvyou"] AndCardNameLabelColor:[TDColorUtil parse:@"#507800"] AndDownViewColor:[TDColorUtil parse:@"#EEF365"] AndCardImage:[UIImage imageNamed:@"vipCard_background_lvse"]];
        }
            break;
        case 2:
        {
            [self initWithCardNameLeftImage:[UIImage imageNamed:@"yuanhhuang"] AndRightImage:[UIImage imageNamed:@"yuanhhuangyou"] AndCardNameLabelColor:[TDColorUtil parse:@"#AB7902"] AndDownViewColor:[TDColorUtil parse:@"#EFF368"] AndCardImage:[UIImage imageNamed:@"vipCard_background_huangse"]];
        }
            break;
        case 3:
        {
             [self initWithCardNameLeftImage:[UIImage imageNamed:@"yuancheng"] AndRightImage:[UIImage imageNamed:@"yuanchengyou"] AndCardNameLabelColor:[TDColorUtil parse:@"#834802"] AndDownViewColor:[TDColorUtil parse:@"#F2D065"] AndCardImage:[UIImage imageNamed:@"vipCard_background_chengse"]];
        }
            break;
        case 4:
        {
            [self initWithCardNameLeftImage:[UIImage imageNamed:@"yuanlan"] AndRightImage:[UIImage imageNamed:@"yuanlan-you"] AndCardNameLabelColor:[TDColorUtil parse:@"#18658D"] AndDownViewColor:[TDColorUtil parse:@"#5CD1F4"] AndCardImage:[UIImage imageNamed:@"vipCard_background_lanse"]];
        }
            break;
        case 5:
        {
             [self initWithCardNameLeftImage:[UIImage imageNamed:@"yuanfen"] AndRightImage:[UIImage imageNamed:@"yuanfenyou"] AndCardNameLabelColor:[TDColorUtil parse:@"#9B2F53"] AndDownViewColor:[TDColorUtil parse:@"#FCA6C3"] AndCardImage:[UIImage imageNamed:@"vipCard_background_fense"]];
        }
            break;
            
        default:
            break;
    }
}
-(void)initWithCardNameLeftImage:(UIImage *)leftImage AndRightImage:(UIImage *)rightImage AndCardNameLabelColor:(UIColor *)labelBackgroundColor AndDownViewColor:(UIColor *)downViewColor AndCardImage:(UIImage*)cardImage
{
    self.cardNameLabel.textColor = downViewColor;
    self.cardNameLeftImageView.image = leftImage;
    self.cardNameRightImageView.image = rightImage;
    self.cardNameLabel.backgroundColor = labelBackgroundColor;
    self.cardNameDownView.backgroundColor = downViewColor;
    self.balanceLabel.textColor = downViewColor;
    self.faceValueLabel.textColor = downViewColor;
    self.cardValidityLabel.textColor = labelBackgroundColor;
    self.cardColorImageView.image = cardImage;
}
@end
