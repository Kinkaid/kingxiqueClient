//
//  BankCardAddCell.m
//  infoPromotion
//
//  Created by imac on 15/9/22.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "BankCardAddCell.h"
@implementation BankCardAddCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)showDataWithModel:(BankListModel *)model
{
   NSString *bankImageURLStr = [NSString stringWithFormat:@"%@/img/bank/%@.jpg",UPYUNURL,model.bankNameStr];
    NSString *bankImageURLStrReal = [bankImageURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.bankNameImage sd_setImageWithURL:[NSURL URLWithString:bankImageURLStrReal]];
}
@end
