//
//  RecoverPaymentPasswordController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/1.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "RecoverPaymentPasswordController.h"
#import "RecoverPaymentPasswordBankCardListCell.h"
#import "AddBankCardEntranceCell.h"
#import "AddBankCardController.h"
#import "RecoverPaymentPasswordMiddleStepController.h"

extern CGFloat SCREEN_WIDTH;
#define entranceCellId @"AddBankCardEntranceCell"
#define bankCardListCellId @"RecoverPaymentPasswordBankCardListCell"
@interface RecoverPaymentPasswordController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *bankListArr;
@end

@implementation RecoverPaymentPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initWithBackItem];
    [self initWithTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)loadData
{
    self.bankListArr = [[NSMutableArray alloc]init];
    [self.bankListArr addObject:@"1"];
    [self.bankListArr addObject:@"2"];
    [self.bankListArr addObject:@"3"];
}
-(void)initWithBackItem
{
    self.title = @"找回支付密码";
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
-(void)initWithTableView
{
    [self.tableView registerNibByCellId:entranceCellId];
    [self.tableView registerNibByCellId:bankCardListCellId];
}
#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 46;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.bankListArr.count;
    }else {
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RecoverPaymentPasswordBankCardListCell *cell = [tableView dequeueReusableCellWithIdentifier:bankCardListCellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        AddBankCardEntranceCell *cell = [tableView dequeueReusableCellWithIdentifier:entranceCellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {//银行列表
        if (self.bankListArr.count) {//有数据时返回view 没有数据时返回nil
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 40)];
            view.backgroundColor = [UIColor clearColor];
            UILabel *label = [[UILabel alloc]initWithFrame:view.frame];
            label.backgroundColor = [UIColor clearColor];
            label.text = @"     通过银行卡找回";
            label.textColor = [TDColorUtil parse:@"#4D4D4D"];
            label.font = [UIFont systemFontOfSize:12];
            [view addSubview:label];
            return view;
        }else{
            return nil;
        }
    }else{//通过绑定新卡找回密码
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [TDColorUtil parse:@"#4D4D4D"];
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"     绑定新卡找回";
        [view addSubview:label];
        return view;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {//银行列表
        if (self.bankListArr.count) {
            return 40;
        }else{
            return 0.1;
        }
    }else{//绑定新卡入口
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AddBankCardController *vc = [[AddBankCardController alloc]init];
        vc.forgetPaymentPassword = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section ==1) {
        AddBankCardController *vc = [[AddBankCardController alloc]init];
        vc.forgetPaymentPassword = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
