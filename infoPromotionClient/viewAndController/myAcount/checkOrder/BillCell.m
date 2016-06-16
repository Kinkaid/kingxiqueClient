//
//  BillCell.m
//  infoPromotion
//
//  Created by zhujingci on 15/6/12.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "BillCell.h"

@implementation BillCell{
    
    __weak IBOutlet UIImageView *_img;
    __weak IBOutlet UILabel *_cellTypeLabel;
    __weak IBOutlet UILabel *_billDesLabel;
    
    __weak IBOutlet UILabel *_createTimeLabel;
    
    __weak IBOutlet UILabel *_changeLabel;
    
    __weak IBOutlet UILabel *_dealStatusLabel;
}
- (void)setData:(NSDictionary *)data{
    [self setCellTypeString:data];
    int payChannel = [data[@"pay_channel"] intValue];
    int billType = [data[@"opt_type"] intValue];
    NSString *des = data[@"des"];
    if (billType == CsBillTypeIsChongzhi) {
        des = @"账户充值";
    }else if(billType == CsBillTypeIsTixian){
        des = @"商户提现";
    }
    if (billType == CsBillTypeIsChongzhi||billType == CsBillTypeIsTixian) {//充值或提现 在描述中需标明资金渠道
        switch (payChannel) {
            case CsPayChannelIsAlipay:
                _billDesLabel.text = [NSString stringWithFormat:@"%@-支付宝",des];
                break;
            case CsPayChannelIsWX:
                _billDesLabel.text = [NSString stringWithFormat:@"%@-微信",des];
                break;
            case CsPayChannelIsBank:
                _billDesLabel.text = [NSString stringWithFormat:@"%@-银行",des];
                break;
            default:
                _billDesLabel.text = @"";
                break;
        }
    }else{
        _billDesLabel.text = des;
    }
    _createTimeLabel.text = [TDDataUtil parseRemoteDataToDateString:data[@"update_time"] withFormatterString:@"yyyy.MM.dd HH:mm"];
    if ([data[@"change"] intValue]>0) {
        _changeLabel.text =[NSString stringWithFormat:@"+%@",[TDDataUtil parseRemoteMoneyString:data[@"change"]]];
    }else {
        _changeLabel.text =[TDDataUtil parseRemoteMoneyString:data[@"change"]];
    }
    
    int dealStatus = [data[@"deal_status"] intValue];
    [self setDealStatusString:dealStatus];
    
}

-(void)setCellTypeString:(NSDictionary *)data{
    int billType = [data[@"opt_type"] intValue];
    switch (billType) {
        case CsBillTypeIsChongzhi:
            _cellTypeLabel.text = @"充值";
            _img.image = [UIImage imageNamed:@"icon-chongzhi"];
            break;
        case CsBillTypeIsTixian:
            _cellTypeLabel.text = @"转出";
            _img.image = [UIImage imageNamed:@"icon-jinbizhuanchu"];
            break;
        case CsBillTypeIsFuwuxiaofei:
            _cellTypeLabel.text = @"消费";
            _img.image = [UIImage imageNamed:@"icon-iconxiaofeijilu"];
            break;
        case CsBillTypeIsJiangli:
            _cellTypeLabel.text = @"补贴";
            _img.image = [UIImage imageNamed:@"icon-xiazai"];
            break;
        case CsBillTypeIsFuwutuikuan:
            _cellTypeLabel.text = @"推广撤单";
            _img.image = [UIImage imageNamed:@"icon-tuikuan"];
            break;
        default:
            break;
    }
}
-(void)setDealStatusString:(int)dealStatus{
    switch (dealStatus) {
        case CsWithdrawStatusIsWaitPay:
            _dealStatusLabel.text = @"未付款";
            _dealStatusLabel.textColor = [TDColorUtil parse:@"#FF813D"];
            break;
        case CsWithdrawStatusIsDealing:
            _dealStatusLabel.text = @"正在处理";
            _dealStatusLabel.textColor = [TDColorUtil parse:@"#FF813D"];
            break;
        case CsWithdrawStatusIsSuccess:
            _dealStatusLabel.text = @"交易成功";
            _dealStatusLabel.textColor = [TDColorUtil parse:@"#AAAAAA"];
            break;
        case CsWithdrawStatusIsFail:
            _dealStatusLabel.text = @"交易失败";
            _dealStatusLabel.textColor = [TDColorUtil parse:@"#FF813D"];
            break;
        case CsWithdrawStatusIsBankDealing:
            _dealStatusLabel.text = @"银行处理中";
            _dealStatusLabel.textColor = [TDColorUtil parse:@"#FF813D"];
            break;
        default:
            break;
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
