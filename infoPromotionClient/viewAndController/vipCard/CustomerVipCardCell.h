//
//  CustomerVipCardCell.h
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/30.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDStrokeLabel.h"
@interface CustomerVipCardCell : UITableViewCell
//会员卡颜色
@property (weak, nonatomic) IBOutlet UIImageView *cardColorImageView;
//会员卡名称左边小图片
@property (weak, nonatomic) IBOutlet UIImageView *cardNameLeftImageView;
//会员卡名称
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
//会员卡名称右边小图片
@property (weak, nonatomic) IBOutlet UIImageView *cardNameRightImageView;
//分割线
@property (weak, nonatomic) IBOutlet UIView *cardNameDownView;
//余额
@property (weak, nonatomic) IBOutlet TDStrokeLabel *balanceLabel;
//面值
@property (weak, nonatomic) IBOutlet TDStrokeLabel *faceValueLabel;
//有效期
@property (weak, nonatomic) IBOutlet UILabel *cardValidityLabel;

-(void)showDataWithDictionary:(NSDictionary *)dic;
@end
