//
//  TDEnumDef.h
//  infoPromotion
//
//  Created by 朱靓慈 on 15/3/2.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int,CsLifeType) {
    CsLifeTypeIsNew = 1,//新顾客
    CsLifeTypeIsGrow = 2,//成长期顾客
    CsLifeTypeIsStable = 3,//稳定顾客
    CsLifeTypeIsLoyal = 4,//忠实顾客
    CsLifeTypeIsSilent = 5,//沉默顾客
    CsLifeTypeIsDie = 6//快流失顾客
};
typedef NS_ENUM(int, CsBillType){
    CsBillTypeIsShouru = 10001, //交易收入
    CsBillTypeIsTuikuan = 20001, //交易退款
    CsBillTypeIsChongzhi = 10002,//充值
    CsBillTypeIsTixian = 20002,//提现
    CsBillTypeIsFuwuxiaofei = 20003,//购买服务退款
    CsBillTypeIsFuwutuikuan = 10003,//购买服务消费
    CsBillTypeIsJiangli = 10004//系统奖励
};
//支付通道
typedef NS_ENUM(int, CsPayChannel){
    CsPayChannelIsWX = 1,//微信公众号
    CsPayChannelIsAlipay = 2,//支付宝
    CsPayChannelIsCash = 3,//现金
    CsPayChannelIsBank = 4,//银行卡
    CsPayChannelIsAccount = 5,//小生易账户
    CsPayChannelIsWXCard = 1001,//微信刷卡
    CsPayChannelIsWXApp = 1002//微信App
};
typedef NS_ENUM(int, CsWithdrawStatus) {
    CsWithdrawStatusIsWaitPay = 0,//未改变账户余额
    CsWithdrawStatusIsDealing = 1,//处理中
    CsWithdrawStatusIsSuccess = 2,//处理成功
    CsWithdrawStatusIsFail = 3,//处理失败
    CsWithdrawStatusIsBankDealing = 4//银行处理中
};

@interface TDEnumDef : NSObject

@end
