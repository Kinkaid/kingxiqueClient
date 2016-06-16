//
//  RefundVipCardCell.h
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/30.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundVipCardCell : UITableViewCell
//会员卡名称
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
//余额多少元已退回您的账户
@property (weak, nonatomic) IBOutlet UILabel *refundMessageLabel;
//退款时间
@property (weak, nonatomic) IBOutlet UILabel *refundTimeLabel;
//20%不退  增送款不退
@property (weak, nonatomic) IBOutlet UILabel *refundDetailMessageLabel;

@end
