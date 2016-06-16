//
//  MoneyRolloutConfirmController.h
//  infoPromotion
//
//  Created by imac on 15/9/25.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^carryBlock) (Boolean autoState,int date,NSString *num);
@interface MoneyRolloutConfirmController : UIViewController

@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic)NSString * money;//余额
@property (nonatomic,copy)NSString *otherAccountId;

@property (nonatomic,strong)carryBlock myBlock;

-(void)carryValue:(carryBlock)myBlock;
@end
