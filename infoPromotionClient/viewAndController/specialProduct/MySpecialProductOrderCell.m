//
//  MySpecialProductOrderCell.m
//  infoPromotionClient
//
//  Created by imac on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "MySpecialProductOrderCell.h"


@implementation MySpecialProductOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showDataWithDic:(NSDictionary *)productDic
{
    
}
#pragma mark -- IBActions
- (IBAction)leftBtnAction:(id)sender {

    [self.delegate leftBtnActionWithCellRow:self.cellRow withBtn:self.leftBtn];
}
- (IBAction)rightBtnAction:(id)sender {
    [self.delegate rightBtnActionWithCellRow:self.cellRow withBtn:self.rightBtn];
}


@end
