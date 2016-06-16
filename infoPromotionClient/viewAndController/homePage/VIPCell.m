//
//  VIPCell.m
//  infoPromotion
//
//  Created by imac on 15/12/16.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import "VIPCell.h"

@implementation VIPCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//电话
- (IBAction)callAction:(id)sender {
    [self.delegate callToShoperActionWithRow:self.cellId];
}

//聊天
- (IBAction)chatAction:(id)sender {
    [self.delegate chatToShoperAction];
}

//优惠
- (IBAction)couponAction:(id)sender {
    [self.delegate couponListAction];
}


@end
