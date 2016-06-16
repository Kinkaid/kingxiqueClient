//
//  CouponCircleSubCell.h
//  infoPromotionClient
//
//  Created by imac on 15/12/21.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponCircleSubCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
-(void)showDataWithText:(NSString *)comment;
@end
