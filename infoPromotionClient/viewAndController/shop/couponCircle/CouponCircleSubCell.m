//
//  CouponCircleSubCell.m
//  infoPromotionClient
//
//  Created by imac on 15/12/21.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "CouponCircleSubCell.h"

@implementation CouponCircleSubCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showDataWithText:(NSString *)comment{
    int i;
    for (i=0; i<comment.length; i++) {
        if ([[comment substringWithRange:NSMakeRange(i, 1)] isEqualToString:@":"]) {
            break;
        }
    }
    int j;
    for (j=0; j<=i; j++) {
        if ([[comment substringWithRange:NSMakeRange(j, 1)] isEqualToString:@" "]) {
            break;
        }
    }
    if (j-1==i) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:comment];
        [attStr addAttribute:NSForegroundColorAttributeName value:[TDColorUtil parse:@"#586C93"] range:NSMakeRange(0, i)];
        self.contentLabel.attributedText = attStr;
    }else{
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:comment];
        [attstr addAttribute:NSForegroundColorAttributeName value:[TDColorUtil parse:@"#586C93"] range:NSMakeRange(0, j)];
        [attstr addAttribute:NSForegroundColorAttributeName value:[TDColorUtil parse:@"#586C93"] range:NSMakeRange(j+3, i-j-3)];
        self.contentLabel.attributedText = attstr;
    }


}
@end
