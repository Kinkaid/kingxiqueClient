//
//  VIPCell.h
//  infoPromotion
//
//  Created by imac on 15/12/16.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol shopCallAndChatAndCounponActionDelegate <NSObject>

-(void)callToShoperActionWithRow:(NSInteger)cellId;
-(void)chatToShoperAction;
-(void)couponListAction;

@end

@interface VIPCell : UITableViewCell

@property (nonatomic)NSInteger cellId;
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopHoursLabel;

@property (nonatomic,strong)id<shopCallAndChatAndCounponActionDelegate>delegate;
@end
