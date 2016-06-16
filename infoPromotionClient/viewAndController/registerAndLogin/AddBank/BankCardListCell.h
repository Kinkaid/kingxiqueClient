//
//  BankCardListCell.h
//  infoPromotion
//
//  Created by imac on 15/10/29.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankCardListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bankImageView;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankRegionLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankCardLastFourNumLabel;
@property (nonatomic,strong)NSDictionary *bankMessageDic;
@property (weak, nonatomic) IBOutlet UIView *backColorView;

@end
