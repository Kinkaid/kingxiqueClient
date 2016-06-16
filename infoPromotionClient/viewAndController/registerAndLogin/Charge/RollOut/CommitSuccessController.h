//
//  CommitSuccessController.h
//  infoPromotion
//
//  Created by imac on 15/10/29.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommitSuccess <NSObject>

-(void)carryDic:(NSDictionary *)dictionary;
@end

@interface CommitSuccessController : UIViewController

@property (nonatomic,strong)NSDictionary *bankDic;
@property (nonatomic,strong)NSString *lastFourNum;
@property (nonatomic,strong)id<CommitSuccess>delegate;


@end
