//
//  PayCouponCell.h
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/23.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponEntity.h"

@interface PayCouponCell : UITableViewCell

-(void)showCellWithModel:(CouponEntity *)coupon andIndex:(NSIndexPath *)indexPath;

@end
