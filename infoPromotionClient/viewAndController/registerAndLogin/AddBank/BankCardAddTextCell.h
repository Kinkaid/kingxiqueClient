//
//  BankCardAddTextCell.h
//  infoPromotion
//
//  Created by imac on 15/9/22.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BankListModel.h"

@interface BankCardAddTextCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;

-(void)showDataWithModel:(BankListModel *)model;

@end
