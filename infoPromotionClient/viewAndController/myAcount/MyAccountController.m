//
//  MyAccountController.m
//  infoPromotionClient
//
//  Created by imac on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "MyAccountController.h"
#import "MyAccountCell.h"
#import "ChargeViewController.h"
#import "MySpecialProductOrderController.h"
#import "BillController.h"
#import "AddBankCardEntranceController.h"
#import "RecoverPaymentPasswordController.h"
#import "MoneyRolloutController.h"
#import "SettingController.h"
#import "PersonalInfomationController.h"
#import "ShopMainController.h"

#define cellId @"MyAccountCell"
#define topicImageHeight 200.0f
@interface MyAccountController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (nonatomic,strong)NSMutableArray *picArr;
@property (nonatomic,strong)NSMutableArray *titleArr;
@property (nonatomic,strong)NSMutableArray *cellImageWidthArr;
@property (nonatomic,strong)NSMutableArray *cellImageHeightArr;
@end

extern CGFloat SCREEN_WIDTH;
@implementation MyAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNav];
    [self initWithData];
    [self initWithTabelView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)initWithNav
{

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

-(void)initWithData
{
    self.picArr = [[NSMutableArray alloc]initWithObjects:@"VIP_",@"quan_",@"tejia_",@"jifen_",@"kefu_",nil];
    self.titleArr = [[NSMutableArray alloc]initWithObjects:@"会员卡",@"优惠券",@"特价商品订单",@"积分",@"客服电话",nil];
    self.cellImageWidthArr = [[NSMutableArray alloc]initWithObjects:@"17",@"17",@"15",@"14",@"15", nil];
    self.cellImageHeightArr = [[NSMutableArray alloc]initWithObjects:@"13",@"12",@"18",@"16",@"15", nil];
}
-(void)initWithTabelView
{
    [self.tableView registerNibByCellId:cellId];
    [self.tableView setTableHeaderView:self.headerView];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];     //  tableView取消多余行数
}

#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.picArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellImageView.image = [UIImage imageNamed:self.picArr[indexPath.row]];
    cell.TitleLabel.text = self.titleArr[indexPath.row];
    cell.imageViewWidth.constant = [self.cellImageWidthArr[indexPath.row] floatValue];
    cell.imageViewHeight.constant = [self.cellImageHeightArr[indexPath.row]  floatValue];
    if (indexPath.row !=4) {
        cell.subView.hidden = YES;
        }else{
        cell.subView.hidden = NO;
        cell.countLabel.text = @"0571-56018980";
        cell.countLabel.textColor = [TDColorUtil parse:@"#3B87EB"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
        
        }
            break;
        case 1:
        {
        
        }
            break;
        case 2:
        {
            MySpecialProductOrderController *vc = [[MySpecialProductOrderController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
        
        }
            break;
        case 4:
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"拨打客服电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
            break;
        default:
            break;
    }
}
#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    
    if (y < 0) {
        self.topImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, topicImageHeight - y);
    }
    if (y > 0) {
        self.topImageView.frame = CGRectMake(0, 0-y, SCREEN_WIDTH, topicImageHeight);
    }
}
//设置
- (IBAction)settingAction:(id)sender {
    SettingController *vc = [[SettingController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//个人信息
- (IBAction)personnalDetailsAction:(id)sender {
    PersonalInfomationController *vc = [[PersonalInfomationController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//账单
- (IBAction)checkOrderAction:(id)sender {
    BillController *billCtrl = [[BillController alloc] init];
    billCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:billCtrl animated:YES];
}
//充值
- (IBAction)rechargeAction:(id)sender {
    ChargeViewController*vc = [[ChargeViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//提现
- (IBAction)withdrawCashAction:(id)sender {
    MoneyRolloutController *vc = [[MoneyRolloutController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//支付密码
- (IBAction)withdrawPasswordAction:(id)sender {
    RecoverPaymentPasswordController *vc = [[RecoverPaymentPasswordController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//我的银行卡
- (IBAction)myBankCardAction:(id)sender {
    AddBankCardEntranceController *vc = [[AddBankCardEntranceController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"0571-56018980"]]];
    }
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
