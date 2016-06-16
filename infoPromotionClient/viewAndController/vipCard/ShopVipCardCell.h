//
//  ShopVipCardCell.h
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/29.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDStrokeLabel.h"
@interface ShopVipCardCell : UITableViewCell
//会员卡底色
@property (weak, nonatomic) IBOutlet UIImageView *cardColorImageView;
//会员卡名称label
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
//有效期
@property (weak, nonatomic) IBOutlet UILabel *cardValidityLabel;
//会员卡名称左边小图片
@property (weak, nonatomic) IBOutlet UIImageView *cardNameLeftImageView;
//会员卡名称右边小图片
@property (weak, nonatomic) IBOutlet UIImageView *cardNameRightImageView;
//分割线view
@property (weak, nonatomic) IBOutlet UIView *cardNameDownView;
//￥
@property (weak, nonatomic) IBOutlet TDStrokeLabel *moneySignalLabel;
//剩余金额
@property (weak, nonatomic) IBOutlet TDStrokeLabel *monayLabel;
//元
@property (weak, nonatomic) IBOutlet TDStrokeLabel *yuanWordLabel;
//面值
@property (weak, nonatomic) IBOutlet TDStrokeLabel *faceValueLabel;
//剩余卡数量
@property (weak, nonatomic) IBOutlet UILabel *surplusLabel;

-(void)showDataWithDictionary:(NSDictionary *)dic;
@end
