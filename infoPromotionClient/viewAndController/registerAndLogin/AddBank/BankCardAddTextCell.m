//
//  BankCardAddTextCell.m
//  infoPromotion
//
//  Created by imac on 15/9/22.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "BankCardAddTextCell.h"

@implementation BankCardAddTextCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)showDataWithModel:(BankListModel *)model
{
    self.bankNameLabel.text = model.bankNameStr;
}
@end
