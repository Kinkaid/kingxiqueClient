//
//  SpecialProductPayController.m
//  infoPromotionClient
//
//  Created by zhujingci on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "SpecialProductPayController.h"
#import "PayChannelEntity.h"
#import "PayChannelCell.h"
#import "SpecialProductVerifycodeController.h"

#define payChannelCellId @"PayChannelCell"
@interface SpecialProductPayController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *payChannelTable;
@property (weak, nonatomic) IBOutlet UILabel *specialProductCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *beforeDiscountMoneyLabel;


@end

@implementation SpecialProductPayController{
    NSMutableArray *_payChannelData;
    NSMutableArray*_couponData;
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
-(void)setNavigationStyle
{
    self.title = @"提交订单";
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
-(void)initTableView{
    [self.payChannelTable registerNibByCellId:payChannelCellId];
}
-(void)loadData{
    
    NSMutableArray *couponArr = [[NSMutableArray alloc]initWithObjects:@[@"9.5折优惠",@"icon_youhuiquan",@"",@(NO)],@[@"满20减5",@"icon_youhuiquan",@"",@(NO)],nil];
    NSMutableArray *payChannelArr = [[NSMutableArray alloc]initWithObjects:@[@"余额支付",@"yue",@"余额: 50元",@(YES)],@[@"微信支付",@"weixin",@"",@(NO)],@[@"支付宝支付",@"zhifu",@"",@(NO)],@[@"会员卡使用",@"huiyuan",@"会员卡1名称",@(NO)],@[@"会员卡使用",@"",@"会员卡2名称",@(NO)],@[@"银行卡支付",@"yinhangka",@"",@(NO)],nil];
    _payChannelData = [[NSMutableArray alloc] init];
    _couponData = [[NSMutableArray alloc]init];
    for (int i=0; i<couponArr.count; i++) {
        PayChannelEntity *couponEntity = [[PayChannelEntity alloc]init];
        couponEntity.payChannel = couponArr[i][0];
        couponEntity.payChannelImageStr = couponArr[i][1];
        couponEntity.payChannelSelect = [couponArr[i][3] boolValue];
        [_couponData addObject:couponEntity];
    }
    for (int i=0; i<payChannelArr.count; i++) {
        PayChannelEntity *payChannelEntity = [[PayChannelEntity alloc] init];
        payChannelEntity.payChannel =payChannelArr[i][0];
        payChannelEntity.payChannelImageStr =payChannelArr[i][1];
        payChannelEntity.payChannelSubTxt = payChannelArr[i][2];
        payChannelEntity.payChannelSelect = [payChannelArr[i][3] boolValue];
        [_payChannelData addObject:payChannelEntity];
    }
    [self.payChannelTable reloadData];
}

#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _couponData.count;
    }else{
        return _payChannelData.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    headerView.backgroundColor = [TDColorUtil parse:@"#F5F5F5"];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:headerView.frame];
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.textColor = [TDColorUtil parse:@"#808080"];
    if (section == 0) {
        textLabel.text = @"    优惠券";
    }else{
    textLabel.text =@"    选择支付方式";
    }
    [headerView addSubview:textLabel];
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:payChannelCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        [cell showCellWithModel:_couponData[indexPath.row]];
    }else{
        [cell showCellWithModel:_payChannelData[indexPath.row]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        for (int i=0; i<_couponData.count; i++) {
            PayChannelEntity *payChannelModel = _couponData[i];
            if (i!=indexPath.row) {
                payChannelModel.payChannelSelect = NO;
                [_couponData replaceObjectAtIndex:i withObject:payChannelModel];
            }else{
                payChannelModel.payChannelSelect = !payChannelModel.payChannelSelect;
                [_couponData replaceObjectAtIndex:i withObject:payChannelModel];
            }
        }
    }else{
    for (int i=0; i<_payChannelData.count; i++) {
        PayChannelEntity *payChannelModel = _payChannelData[i];
        if (i!=indexPath.row) {
            payChannelModel.payChannelSelect = NO;
            [_payChannelData replaceObjectAtIndex:i withObject:payChannelModel];
        }else{
            payChannelModel.payChannelSelect = YES;
            [_payChannelData replaceObjectAtIndex:i withObject:payChannelModel];
        }
     }
    }
    [self.payChannelTable reloadData];
//    PayChannelCell *cell = (PayChannelCell *)[tableView cellForRowAtIndexPath:indexPath];
//    PayChannelEntity *payChannelEntity = _payChannelData[indexPath.row];
//    payChannelEntity.payChannelSelect = !payChannelEntity.payChannelSelect;
    
//    [cell showCellWithModel:payChannelEntity];
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    PayChannelCell *cell = (PayChannelCell *)[tableView cellForRowAtIndexPath:indexPath];
//    PayChannelEntity *payChannelEntity = _payChannelData[indexPath.row];
//    payChannelEntity.payChannelSelect = !payChannelEntity.payChannelSelect;
//    [cell showCellWithModel:payChannelEntity];
//}
//减法
- (IBAction)subtractAction:(id)sender {
    if ([self.specialProductCountLabel
        .text intValue]==1) {
        return;
    }else{
        self.specialProductCountLabel.text = [NSString stringWithFormat:@"%d",[self.specialProductCountLabel.text intValue]-1];
        self.beforeDiscountMoneyLabel.text  = [NSString stringWithFormat:@"￥%.2f",54.50*[self.specialProductCountLabel.text intValue]];
        
    }
    
}
//加法
- (IBAction)addAction:(id)sender {
    if ([self.specialProductCountLabel.text intValue]==10) {
        return;
    }else{
        self.specialProductCountLabel.text = [NSString stringWithFormat:@"%d",[self.specialProductCountLabel.text intValue]+1];
         self.beforeDiscountMoneyLabel.text  = [NSString stringWithFormat:@"￥%.2f",54.50*[self.specialProductCountLabel.text intValue]];
    }
}

#pragma mark -IBActions
- (IBAction)paymentAction:(id)sender {
    SpecialProductVerifycodeController *ctrl = [[SpecialProductVerifycodeController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

@end
