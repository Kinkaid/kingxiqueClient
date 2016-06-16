//
//  CheckoutPayChannelCell.h
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/23.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayChannelEntity.h"

@interface PayChannelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

-(void)showCellWithModel:(PayChannelEntity *)payChannelEntity;

@end
