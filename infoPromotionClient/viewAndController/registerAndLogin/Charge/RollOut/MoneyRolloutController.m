//
//  MoneyRolloutController.m
//  infoPromotion
//
//  Created by imac on 15/9/28.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import "MoneyRolloutController.h"
#import "BankCardListCell.h"
#import <HMSegmentedControl.h>
#import <KLCPopup/KLCPopup.h>
//#import "BankAccountDao.h"
#import "BankCardAddController.h"
#import "AddBankCardController.h"
#import "MoneyRolloutConfirmController.h"
#import "RolloutRecorderCell.h"
//#import "UIImage+Tint.h"
#import "MJRefresh.h"
//#import "EncourageFooterCell.h"
#import "CommitSuccessController.h"
#import "AddBankCardEntranceCell.h"
#define BankCardCellId @"BankCardListCell"
@interface MoneyRolloutController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,CommitSuccess>
@property (weak, nonatomic) IBOutlet UITableView *MoneyRolloutTableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UILabel *currentBalance;
- (IBAction)cancelBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *autoRollMessageLabel;

//存放数据源
@property (nonatomic,strong)NSMutableArray *bankCardMessageDataArr;
@property (nonatomic,strong)NSMutableArray *autoListDataArr;
@property (nonatomic,strong)NSDictionary *recordDic;

@property (weak, nonatomic) IBOutlet UITableView *rolloutRecordTabelView;
@property (strong, nonatomic) IBOutlet UIView *autoRolloutView;

//判断自动转账按钮状态
@property (nonatomic)Boolean autoState;

@property (nonatomic) NSInteger curBankCardRow;

//查询已绑定银行卡列表返回的bankcard_id
@property (nonatomic)long bankCardId;

@end
int autoListPage = 1;
extern CGFloat SCREEN_HEIGHT;
extern CGFloat SCREEN_WIDTH;
@implementation MoneyRolloutController
//友盟页面统计
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self loadAutoRolloutView];
   
    [[ServiceManager sharedInstance] getFunction:@"/shop/account/balance" params:@{@"shop_id":@"6736579794329406417"} attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        self.currentBalance.text = [TDDataUtil parseRemoteMoneyString:data[@"balance"]];
        } failActions:nil serviceFail:nil];
    self.bankCardMessageDataArr = [[NSMutableArray alloc]init];
    [self loadAccountList];
}

-(void)carryDic:(NSDictionary *)dictionary
{
    self.autoState = [dictionary[@"state"] boolValue];
//    self.autoRollMessageLabel.text = [NSString stringWithFormat:@"每月%d日余额将会自动给转至尾号为%@的中国招商银行账户.如要恢复实时转出需关闭该功能",[dictionary[@"date"] intValue],dictionary[@"num"]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self initWithNavigation];
    [self initWithTableView];
    [self initWithRefresh];
}
-(void)initWithNavigation
{
    self.title = @"转出";
    [TDApplicationUtil setWhiteNavigation:self.navigationController];
    self.autoListDataArr = [[NSMutableArray alloc]init];
}
-(void)initWithTableView
{
    [self.MoneyRolloutTableView registerNib:[UINib nibWithNibName:BankCardCellId bundle:nil] forCellReuseIdentifier:BankCardCellId];
    [self.MoneyRolloutTableView registerNib:[UINib nibWithNibName:@"AddBankCardEntranceCell" bundle:nil] forCellReuseIdentifier:@"AddBankCardEntranceCell"];
    [self.rolloutRecordTabelView registerNib:[UINib nibWithNibName:@"RolloutRecorderCell" bundle:nil]forCellReuseIdentifier:@"RolloutRecorderCell"];
    [self.MoneyRolloutTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 120);
    [self.MoneyRolloutTableView setTableHeaderView:self.headerView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//加载已关联账户数据
-(void)loadAccountList{
    ServiceManager *manager = [ServiceManager sharedInstance];
    NSDictionary *params = @{@"shop_id":@"6736579794329406417"};
    [manager getFunction:@"/shop/bankcard/binding" params:params attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        self.bankCardMessageDataArr = [[NSMutableArray alloc] initWithArray:data[@"bankcard_list"]];
        [self.MoneyRolloutTableView reloadData];
        if (self.autoState == YES||self.autoRolloutState == YES) {
            NSDictionary *params = @{@"shop_id":@"6736579794329406417",@"page":@(autoListPage)};
            if (autoListPage == 1) {
                self.autoListDataArr = [[NSMutableArray alloc]init];
            }
            [manager getFunction:@"/account/withdraw/auto/list" params:params attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
                NSString *cardNumLast =[NSString stringWithFormat:@"%@",data[@"card_no"]];
                self.autoRollMessageLabel.text = [NSString stringWithFormat:@"每月%d日余额将会自动给转至尾号为%@的%@账户.如要恢复实时转出需关闭该功能",[data[@"auto_day"] intValue],[cardNumLast substringFromIndex:cardNumLast.length-4],data[@"bank_name"]];
                self.recordDic  = [[NSDictionary alloc]initWithDictionary:data];
                for (NSMutableDictionary *dic in data[@"withdraw_list"]) {
                    [self.autoListDataArr addObject:dic];
                }
                [self.rolloutRecordTabelView.header endRefreshing];
                [self.rolloutRecordTabelView.footer endRefreshing];
                if (self.autoListDataArr.count == 0) {//已全部加载完毕
                    self.rolloutRecordTabelView.footer.state = MJRefreshFooterStateNoMoreData;
                }
                [self.rolloutRecordTabelView reloadData];
            } failActions:nil serviceFail:nil];
        }
        
    } failActions:nil serviceFail:nil];
    
}
-(void)loadAutoRolloutView
{
    if (self.autoRolloutState == true||self.autoState == true) {
        self.autoRolloutView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:self.autoRolloutView];
        [self.rolloutRecordTabelView reloadData];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.MoneyRolloutTableView){
        
        if (indexPath.section<self.bankCardMessageDataArr.count) {
            
            BankCardListCell *cell = [self.MoneyRolloutTableView dequeueReusableCellWithIdentifier:BankCardCellId forIndexPath:indexPath];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.frame = CGRectMake(16, 0, self.view.frame.size.width-32, 84);
            cell.bankMessageDic = self.bankCardMessageDataArr[indexPath.section];
            return cell;
        }else{
            AddBankCardEntranceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddBankCardEntranceCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if(tableView ==self.rolloutRecordTabelView)
    {
        RolloutRecorderCell*cell = [tableView dequeueReusableCellWithIdentifier:@"RolloutRecorderCell" forIndexPath:indexPath];
        cell.bankName.text = self.recordDic[@"bank_name"];
        NSString *cardStr = [NSString stringWithFormat:@"%@",self.recordDic[@"card_no"]];
        cell.bankCardLastNum.text = [NSString stringWithFormat:@"****%@",[cardStr substringFromIndex:cardStr.length-4]];
        [cell showDataWithDictionary:self.autoListDataArr[indexPath.row]];
        return cell;
    }else{
        return nil;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.rolloutRecordTabelView) {
        return 66;
    }
    if (indexPath.section == self.bankCardMessageDataArr.count) {
        return 44;
    }else{
        return 70;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.MoneyRolloutTableView) {
        if (section == self.bankCardMessageDataArr.count) {
            return 22;
        }else {
            return 0.1;
        }
    }
    return 1;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (tableView == self.rolloutRecordTabelView) {
        return 5.0f;
    }else{
        return 6.0f;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.MoneyRolloutTableView) {
        return 1;
    }else{
        return self.autoListDataArr.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.rolloutRecordTabelView) {
        return 1;
    }
    else{
        return self.bankCardMessageDataArr.count+1;
    }
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.MoneyRolloutTableView) {
        if (indexPath.section == self.bankCardMessageDataArr.count) {
            return NO;
        }
        return YES;
    }
    return NO;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.MoneyRolloutTableView) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            ServiceManager *manager = [ServiceManager sharedInstance];
            NSDictionary *dict = @{@"bankcard_id":self.bankCardMessageDataArr[indexPath.section][@"bankcard_id"],@"shop_id":[TDUserDefaultsUtil getShopId]};
            [manager deleteFunction:@"/account/withdraw/bankcard" params:dict attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
                [self.bankCardMessageDataArr removeObjectAtIndex:indexPath.section];
                [self.MoneyRolloutTableView reloadData];
            } failActions:nil serviceFail:nil];
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.MoneyRolloutTableView){
        if (indexPath.section==self.bankCardMessageDataArr.count) {
            AddBankCardController *ctrl = [[AddBankCardController alloc] init];
            [self.navigationController pushViewController:ctrl animated:YES];
        }else{
            MoneyRolloutConfirmController *ctrl = [[MoneyRolloutConfirmController alloc] init];
            ctrl.data = self.bankCardMessageDataArr[indexPath.section];
            ctrl.money = self.currentBalance.text;
            [ctrl carryValue:^(Boolean autoState,int date,NSString *num) {
                self.autoState = autoState;
                self.autoRollMessageLabel.text = [NSString stringWithFormat:@"每月%d日余额将会自动给转至尾号为%@的银行账户.如要恢复实时转出需关闭该功能",date,num];
            }];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
    }
}

- (IBAction)cancelBtnAction:(id)sender {
  //取消自动提款接口
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定时自动转出功能将要关闭" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = 2;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2) {//取消自动提款 确认
        ServiceManager *manager = [ServiceManager sharedInstance];
        NSDictionary *dict = @{@"shop_id":[TDUserDefaultsUtil getShopId]};
        [manager deleteFunction:@"/account/withdraw/auto" params:dict attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
            self.autoState = false;
            self.autoRolloutState = false;
            [self.autoRolloutView removeFromSuperview];
        } failActions:nil serviceFail:nil];
        
    }else if(alertView.tag == 1){
        if (buttonIndex==1) {//点击确认
            ServiceManager *manager = [ServiceManager sharedInstance];
            NSDictionary *dict = @{@"bankcard_id":self.bankCardMessageDataArr[_curBankCardRow][@"bankcard_id"],@"shop_id":[TDUserDefaultsUtil getShopId]};
            [manager deleteFunction:@"/account/withdraw/bankcard" params:dict attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {

            } failActions:nil serviceFail:nil];

            [self.bankCardMessageDataArr removeObjectAtIndex:_curBankCardRow];
        }
        [self.MoneyRolloutTableView reloadData];
    }
    
}
-(void)initWithRefresh
{
    autoListPage = 1;
    __weak typeof(self) weakSelf = self;
    //下拉刷新
    [self.rolloutRecordTabelView addLegendHeaderWithRefreshingBlock:^{
        autoListPage = 1;
        [weakSelf loadAccountList];
    }];
    //上拉加载
    [self.rolloutRecordTabelView addLegendFooterWithRefreshingBlock:^{
        autoListPage ++;
        [weakSelf loadAccountList];
    }];
}
@end
