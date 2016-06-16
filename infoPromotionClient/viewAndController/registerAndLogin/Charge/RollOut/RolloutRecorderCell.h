//
//  RolloutRecorderCell.h
//  infoPromotion
//
//  Created by imac on 15/9/28.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RolloutRecorderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bankLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *bankState;
@property (weak, nonatomic) IBOutlet UILabel *bankCardLastNum;

-(void)showDataWithDictionary:(NSDictionary *)dic;
@end
