//
//  RefundOrderReasonCell.m
//  infoPromotionClient
//
//  Created by imac on 16/2/23.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "RefundOrderReasonCell.h"

@implementation RefundOrderReasonCell

- (void)awakeFromNib {
    // Initialization code
    self.otherReasonTextView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self.delegate otherReasonTextView:textView];
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length==0) {
        self.reasonLabel.hidden = NO;
    }else{
        self.reasonLabel.hidden = YES;
    }
}

@end
