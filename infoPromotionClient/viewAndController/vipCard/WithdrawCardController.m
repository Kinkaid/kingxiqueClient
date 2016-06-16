//
//  WithdrawCardController.m
//  infoPromotionClient
//
//  Created by imac on 15/12/31.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "WithdrawCardController.h"

@interface WithdrawCardController ()
//商铺名称
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
//卡内余额
@property (weak, nonatomic) IBOutlet UILabel *cardBalanceLabel;
//20%商家预收款
@property (weak, nonatomic) IBOutlet UILabel *advanceMoneyLabel;
//商家赠送款项
@property (weak, nonatomic) IBOutlet UILabel *presentLabel;
//退款总额
@property (weak, nonatomic) IBOutlet UILabel *refundLabel;

@end

@implementation WithdrawCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退卡";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)confirmRefundAction:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
