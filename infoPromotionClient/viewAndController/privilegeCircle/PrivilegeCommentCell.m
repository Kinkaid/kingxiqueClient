//
//  PrivilegeCommentCell.m
//  infoPromotionClient
//
//  Created by imac on 16/1/4.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "PrivilegeCommentCell.h"

@implementation PrivilegeCommentCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)showDataWithText:(NSString *)comment
{
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
