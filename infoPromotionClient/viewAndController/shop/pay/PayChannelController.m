//
//  PayChannelController.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/23.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "PayChannelController.h"
#import "PayChannelEntity.h"
#import "PayChannelCell.h"
#import "PaySuccessController.h"

#define payChannelCellId @"PayChannelCell"
@interface PayChannelController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *payChannelTable;
//店铺名称
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
//订单金额
@property (weak, nonatomic) IBOutlet UILabel *orderMoneyLabel;
//优惠金额
@property (weak, nonatomic) IBOutlet UILabel *discountMoneyLabel;
//抽到奖励
@property (weak, nonatomic) IBOutlet UILabel *awardMoneyLabel;
//还需支付
@property (weak, nonatomic) IBOutlet UILabel *needPayMoneyCountLabel;


@end


static NSMutableArray *_payChannelData;
@implementation PayChannelController

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
    self.title = @"支付确认";
}
-(void)initTableView{
    [self.payChannelTable registerNibByCellId:payChannelCellId];
}
-(void)loadData{
    
    NSMutableArray *payChannelArr = [[NSMutableArray alloc]initWithObjects:@[@"余额支付",@"yue",@"余额: 50元",@(YES)],@[@"微信支付",@"weixin",@"",@(NO)],@[@"支付宝支付",@"zhifu",@"",@(NO)],@[@"会员卡使用",@"huiyuan",@"会员卡1名称",@(NO)],@[@"会员卡使用",@"",@"会员卡2名称",@(NO)],@[@"银行卡支付",@"yinhangka",@"",@(NO)],nil];
    _payChannelData = [[NSMutableArray alloc] init];
    for (int i=0; i<payChannelArr.count; i++) {
        PayChannelEntity *payChannelModel = [[PayChannelEntity alloc]init];
        payChannelModel.payChannel = payChannelArr[i][0];
        payChannelModel.payChannelImageStr = payChannelArr[i][1];
        payChannelModel.payChannelSubTxt = payChannelArr[i][2];
        payChannelModel.payChannelSelect = [payChannelArr[i][3] boolValue];
        [_payChannelData addObject:payChannelModel];
    }
    [self.payChannelTable reloadData];
}
#pragma mark -IBActions
//付款
- (IBAction)payAction:(id)sender {
    PaySuccessController *ctrl = [[PaySuccessController alloc] init];
    ctrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
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
//    payChannelEntity.payChannelSelect = !payChannelEntity.payChannelSelect;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//     [cell showCellWithModel:payChannelEntity];
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    PayChannelCell *cell = (PayChannelCell *)[tableView cellForRowAtIndexPath:indexPath];
//    PayChannelEntity *payChannelEntity = _payChannelData[indexPath.row];
//    payChannelEntity.payChannelSelect = !payChannelEntity.payChannelSelect;
//    [cell showCellWithModel:payChannelEntity];
//}
@end
