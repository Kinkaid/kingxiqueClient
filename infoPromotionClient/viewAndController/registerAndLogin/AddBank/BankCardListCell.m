//
//  BankCardListCell.m
//  infoPromotion
//
//  Created by imac on 15/10/29.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import "BankCardListCell.h"

@implementation BankCardListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setBankMessageDic:(NSDictionary *)bankMessageDic
{
    self.bankNameLabel.text =bankMessageDic[@"bank_name"] ;
    self.bankRegionLabel.text =[NSString stringWithFormat:@"%@ %@",bankMessageDic[@"province"],bankMessageDic[@"city"]];
    NSString *carNumStr = [bankMessageDic[@"card_no"] substringFromIndex:[bankMessageDic[@"card_no"] length]-4];
    self.bankCardLastFourNumLabel.text =[NSString stringWithFormat:@"%@",carNumStr];
     self.bankImageView.image =[UIImage imageNamed:self.bankNameLabel.text]?[UIImage imageNamed:self.bankNameLabel.text]:[UIImage imageNamed:@"default-bankcard"];
     NSArray *bankAry = @[@{@"bank":@"上海浦东发展银行",@"color":@"#4f7bc3"},@{@"bank":@"中信银行",@"color":@"#db625a"},@{@"bank":@"中国光大银行",@"color":@"#dbd95a"},@{@"bank":@"中国农业银行",@"color":@"#43b99f"},@{@"bank":@"中国工商银行",@"color":@"#db625a"},@{@"bank":@"中国建设银行",@"color":@"#4f8ec3"},@{@"bank":@"中国民生银行",@"color":@"#47b17c"},@{@"bank":@"中国邮政储蓄银行",@"color":@"#47b17c"},@{@"bank":@"中国银行",@"color":@"#db625a"},@{@"bank":@"交通银行",@"color":@"#4f7bc3"},@{@"bank":@"兴业银行行",@"color":@"#4f8ec3"},@{@"bank":@"华夏银行",@"color":@"#db625a"},@{@"bank":@"平安银行",@"color":@"#e48450"},@{@"bank":@"广发银行",@"color":@"#db625a"},@{@"bank":@"恒丰银行",@"color":@"#b69755"},@{@"bank":@"招商银行",@"color":@"#db625a"},@{@"bank":@"浙商银行",@"color":@"#e5a949"},@{@"bank":@"渤海银行",@"color":@"#4f8ec3"}];
    for (NSDictionary *bankColor in bankAry) {
        if (bankMessageDic[@"bank_name"]==bankColor[@"bank"]) {
             self.backColorView.backgroundColor = [TDColorUtil parse:bankColor[@"color"]];
            break;
        }
    }
    
}
@end
