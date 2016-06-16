//
//  ScancodeCheckOutController.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/23.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "VipcardChargeController.h"
#import "PayChannelEntity.h"
#import "PayChannelCell.h"
#import "PaySuccessController.h"

#define payChannelCellId @"PayChannelCell"
@interface VipcardChargeController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *payChannelTable;
//会员卡名称
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
//发卡商家
@property (weak, nonatomic) IBOutlet UILabel *cardShopLabel;
//会员卡有效期
@property (weak, nonatomic) IBOutlet UILabel *cardValidityLabel;
//会员卡面值
@property (weak, nonatomic) IBOutlet UILabel *cardFaceValueLabel;
//商铺赠送金额
@property (weak, nonatomic) IBOutlet UILabel *cardPresentValueLabel;
//实际付款
@property (weak, nonatomic) IBOutlet UILabel *virtualPaymentLabel;


@end



@implementation VipcardChargeController{
    NSMutableArray *_payChannelData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationStyle];
    [self initTableView];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -private
-(void)setNavigationStyle{
    self.title = @"开卡";
    self.navigationController.navigationBar.translucent = YES;
}
-(void)initTableView{
    [self.payChannelTable registerNibByCellId:payChannelCellId];
}
-(void)loadData{
    _payChannelData = [[NSMutableArray alloc] init];
    PayChannelEntity *payChannelEntity = [[PayChannelEntity alloc] init];
    payChannelEntity.payChannel = @"余额支付";
    payChannelEntity.payChannelImageStr = @"yue";
    payChannelEntity.payChannelSubTxt = @"余额: 550元";
    payChannelEntity.payChannelSelect = YES;
    [_payChannelData addObject:payChannelEntity];
    PayChannelEntity *payChannelEntity2 = [[PayChannelEntity alloc] init];
    payChannelEntity2.payChannel = @"微信支付";
    payChannelEntity2.payChannelImageStr = @"weixin";
    payChannelEntity2.payChannelSelect = NO;
    [_payChannelData addObject:payChannelEntity2];
    PayChannelEntity *payChannelEntity3 = [[PayChannelEntity alloc] init];
    payChannelEntity3.payChannel = @"支付宝支付";
    payChannelEntity3.payChannelImageStr = @"zhifu";
    payChannelEntity3.payChannelSelect = NO;
    [_payChannelData addObject:payChannelEntity3];
    PayChannelEntity *payChannelEntity6 = [[PayChannelEntity alloc] init];
    payChannelEntity6.payChannel = @"银行卡支付";
    payChannelEntity6.payChannelImageStr = @"yinhangka";
    payChannelEntity6.payChannelSelect = NO;
    [_payChannelData addObject:payChannelEntity6];
    [self.payChannelTable reloadData];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _payChannelData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:payChannelCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showCellWithModel:_payChannelData[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    PayChannelCell *cell = (PayChannelCell *)[tableView cellForRowAtIndexPath:indexPath];
//    PayChannelEntity *payChannelEntity = _payChannelData[indexPath.row];
//    payChannelEntity.payChannelSelect = !payChannelEntity.payChannelSelect;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (int i=0; i<_payChannelData.count; i++) {
        PayChannelEntity *payChannelEntity = _payChannelData[i];
        if (i!=indexPath.row) {
            payChannelEntity.payChannelSelect = NO;
            [_payChannelData replaceObjectAtIndex:i withObject:payChannelEntity];
        }else{
            payChannelEntity.payChannelSelect = YES;
            [_payChannelData replaceObjectAtIndex:i withObject:payChannelEntity];
        }
    }
    [self.payChannelTable reloadData];
//    [cell showCellWithModel:payChannelEntity];
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    PayChannelCell *cell = (PayChannelCell *)[tableView cellForRowAtIndexPath:indexPath];
//    PayChannelEntity *payChannelEntity = _payChannelData[indexPath.row];
//    payChannelEntity.payChannelSelect = !payChannelEntity.payChannelSelect;
//    [cell showCellWithModel:payChannelEntity];
//}
- (IBAction)paymentAction:(id)sender {
    PaySuccessController *vc = [[PaySuccessController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
