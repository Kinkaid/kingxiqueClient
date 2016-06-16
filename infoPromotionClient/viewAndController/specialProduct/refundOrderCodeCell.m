//
//  refundOrderCodeCell.m
//  infoPromotionClient
//
//  Created by imac on 16/2/23.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "refundOrderCodeCell.h"

@implementation refundOrderCodeCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)selecteAction:(id)sender {
    
    [self.delegate codeOrReasonSelectedWithIndexPath:self.indexPath];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
