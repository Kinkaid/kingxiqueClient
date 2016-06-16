
//  ChargeViewController.m
//  infoPromotion
//
//  Created by chenkaiwei  on 15-2-12.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "ChargeViewController.h"
#import "MBProgressHUD.h"
#import "ServiceManager.h"
#import "AlipayHeader.h"
#import "TDWeixinUtil.h"

@interface ChargeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyTI;

@end
static BOOL chargeEnable = NO;
extern NSString *ZFB_PAY_SUCCESS;
extern NSString *ZFB_PAY_FAIL;
@implementation ChargeViewController{
    
    __weak IBOutlet UILabel *_banlance;
    
    __weak IBOutlet UIButton *_chargeBtn;
    
    __weak IBOutlet UIButton *_wxSelectBtn;
    
    __weak IBOutlet UIButton *_zfbSelectBtn;
    
    __weak IBOutlet UIControl *_zfbPayControl;
    
    __weak IBOutlet UIControl *_wxPayControl;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"充值";
    [TDApplicationUtil setWhiteNavigation:self.navigationController];
    [self getShopBalance];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paySuccessAction:) name:ZFB_PAY_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payFailed:) name:ZFB_PAY_FAIL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessAction:) name:WEIXIN_PAY_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFailed:) name:WEIXIN_PAY_FAIL object:nil];
    
    [_zfbSelectBtn setSelected:YES];
    [_zfbSelectBtn setImage:[UIImage imageNamed:@"icon-selected"] forState:UIControlStateSelected];
    [_zfbSelectBtn setImage:[UIImage imageNamed:@"icon-notselected"] forState:UIControlStateNormal];
    [_wxSelectBtn setImage:[UIImage imageNamed:@"icon-selected"] forState:UIControlStateSelected];
    [_wxSelectBtn setImage:[UIImage imageNamed:@"icon-notselected"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 交互事件

- (IBAction)moneyInputChanged:(id)sender {
    if(_moneyTI.text.length>0){
        [self makeChargeButtonEnable:YES];
    }else{
        [self makeChargeButtonEnable:NO];
    }
}
//控制充值按钮是否可用
- (void)makeChargeButtonEnable:(BOOL)enable {
    chargeEnable = enable;
    if (enable) {
        _chargeBtn.enabled = YES;
        _chargeBtn.backgroundColor = [TDColorUtil themeColor];
    } else {
        _chargeBtn.enabled = NO;
        _chargeBtn.backgroundColor = [TDColorUtil parse:@"#D8D8D8"];
    }
}

//选择支付方式
- (IBAction)controlDownAction:(id)sender {
    UIControl *control = (UIControl *)sender;
    control.backgroundColor = [TDColorUtil parse:@"#d8d8d8"];
}

- (IBAction)zfbBtnTouchUpAction:(id)sender {
    _zfbPayControl.backgroundColor = [UIColor whiteColor];
    _zfbSelectBtn.selected = YES;
    _wxSelectBtn.selected = NO;
}

- (IBAction)wxBtnTouchUpAction:(id)sender {
    _wxPayControl.backgroundColor = [UIColor whiteColor];
    _zfbSelectBtn.selected = NO;
    _wxSelectBtn.selected = YES;
}
//确认充值
- (IBAction)chargeEnsureTouchUpAction:(id)sender {
    [MobClick event:@"rechargeCommitButtonClick"];
    if(_zfbSelectBtn.selected){//选择支付宝支付
        [self zfbPay];
    }else if (_wxSelectBtn.selected) {//选择微信支付
        [self wxPay];
    }
    
}
//支付宝支付
-(void)zfbPay{
    NSString *amount = _moneyTI.text;
    if ([TDDataUtil parseStrPriceToIntPrice:amount]==0) {
        [TDApplicationUtil alertHud:@"充值金额需大于0" afterDelay:1];
        return;
    }
    ServiceManager *manager = [ServiceManager sharedInstance];
    NSDictionary *params = @{@"shop_id":[TDUserDefaultsUtil getShopId],@"user_id":[TDUserDefaultsUtil getUserId],@"change":[TDDataUtil parseStrPriceToParamPrice:amount],@"pay_channel":[[NSNumber alloc] initWithInt:CsPayChannelIsAlipay]};
    [manager postFunction:@"/account/inpour" params:params attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {//生成充值账单
        NSString *rechargeId = [data valueForKey:@"recharge_id"];
        [AlipayRequestConfig alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:rechargeId productName:@"小生易账户充值" productDescription:nil amount:amount notifyURL:kNotifyURL itBPay:@"1m"];
    } failActions:nil serviceFail:nil];
    
    
}
//微信支付
-(void)wxPay{
    NSString *amount = _moneyTI.text;
    if ([TDDataUtil parseStrPriceToIntPrice:amount]==0) {
        [TDApplicationUtil alertHud:@"充值金额需大于0" afterDelay:1];
        return;
    }
    ServiceManager *manager = [ServiceManager sharedInstance];
    NSDictionary *params = @{@"shop_id":[TDUserDefaultsUtil getShopId],@"user_id":[TDUserDefaultsUtil getUserId],@"change":[TDDataUtil parseStrPriceToParamPrice:amount],@"pay_channel":[[NSNumber alloc] initWithInt:CsPayChannelIsWXApp]};
    [manager postFunction:@"/account/inpour" params:params attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: data[@"appid"]        forKey:@"appid"];
        [signParams setObject: data[@"noncestr"]    forKey:@"noncestr"];
        [signParams setObject: data[@"package"]      forKey:@"package"];
        [signParams setObject: data[@"partnerid"]        forKey:@"partnerid"];
        [signParams setObject: data[@"timestamp"]   forKey:@"timestamp"];
        [signParams setObject: data[@"prepayid"]     forKey:@"prepayid"];
        [signParams setObject: data[@"sign"]     forKey:@"sign"];
        [TDWeixinUtil sendPay:signParams];
    } failActions:nil serviceFail:nil];
}
//支付成功
-(void)paySuccessAction:(NSNotification *)notification{
    [self getShopBalance];//刷新实时余额
    [self makeChargeButtonEnable:NO];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"成功充值%@元",_moneyTI.text] delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alertView show];
    _moneyTI.text = @"";
    
}
//支付失败
-(void)payFailed:(NSNotification *)notification{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
//获取实时余额
-(void)getShopBalance{
    [[ServiceManager sharedInstance] getFunction:@"/shop/account/balance" params:@{@"shop_id":[TDUserDefaultsUtil getShopId]} attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        _banlance.text=[TDDataUtil parseRemoteMoneyString:data[@"balance"]];
    } failActions:nil serviceFail:nil];
}

#pragma mark -UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==self.moneyTI) {
        return [TDApplicationUtil judgeDecimalTextFieldAllowInput:textField shouldChangeCharactersInRange:range replacementString:string decimalLimit:2];
    }
    return YES;
}
@end
