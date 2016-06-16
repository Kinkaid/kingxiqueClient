//
//  BankCardAddController.h
//  infoPromotion
//
//  Created by zhujingci on 15/9/3.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BankCardAddController : UIViewController

@property (nonatomic,copy)NSString *bankCardOwner;

@property (nonatomic,copy)NSString *bankCardNum;

@property (nonatomic,strong)NSMutableDictionary *bankCardAddDic;
@end
