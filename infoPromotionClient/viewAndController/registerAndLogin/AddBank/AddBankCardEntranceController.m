//
//  AddBankCardEntranceController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/1.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "AddBankCardEntranceController.h"
#import "AddBankCardEntranceCell.h"
#import "BankCardListCell.h"
#import "AddBankCardController.h"
#import "PasswordManagerController.h"
#import "RecoverPaymentPasswordController.h"
#define entranceCellId @"AddBankCardEntranceCell"
#define bankCardListCellId @"BankCardListCell"
extern CGFloat SCREEN_WIDHT;
extern CGFloat SCREEN_HEIGHT;
@interface AddBankCardEntranceController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UITableView *bankCardListTableView;
@property (nonatomic,strong)NSMutableArray *bankCardListArr;
@property (nonatomic,strong)KLCPopup *klcPopup;
@end

@implementation AddBankCardEntranceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBackItem];
    [self loadData];
    [self initWithTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)initWithBackItem
{
    self.title= @"银行卡管理";
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
-(void)loadData
{
    self.bankCardListArr = [[NSMutableArray alloc]init];
    [self.bankCardListArr addObject:@"1"];
    [self.bankCardListArr addObject:@"2"];
}
-(void)initWithTableView
{
    [self.bankCardListTableView registerNibByCellId:entranceCellId];
    [self.bankCardListTableView registerNibByCellId:bankCardListCellId];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.bankCardListArr.count) {
        return 46;
    }else{
        return 82;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == self.bankCardListArr.count) {
        return 6;
    }else{
        return 0.1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.bankCardListArr.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.bankCardListArr.count) {
            AddBankCardEntranceCell *cell = [tableView dequeueReusableCellWithIdentifier:entranceCellId forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }else {
        BankCardListCell *cell = [tableView dequeueReusableCellWithIdentifier:bankCardListCellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.bankCardListArr.count) {
        return YES;
    }else{
        return NO;
    }
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.bankCardListArr removeObjectAtIndex:indexPath.section];
    [self.bankCardListTableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==self.bankCardListArr.count) {
        int i = arc4random()%2;
        if (i==0) {
            self.klcPopup = [KLCPopup popupWithContentView:self.popView];
            self.klcPopup.shouldDismissOnBackgroundTouch = NO;
            [self.klcPopup show];
        }else{
            PasswordManagerController *vc = [[PasswordManagerController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
//忘记密码
- (IBAction)forgetPasswordAction:(id)sender {
    [self.klcPopup dismiss:YES];
    RecoverPaymentPasswordController *vc = [[RecoverPaymentPasswordController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
//取消
- (IBAction)klcPopupCancelAction:(id)sender {
    [self.klcPopup dismiss:YES];
}
//确认
- (IBAction)klcPopupEnsuerAction:(id)sender {
    [self.klcPopup dismiss:YES];
    AddBankCardController *vc =[[AddBankCardController alloc]init];
    [self.navigationController pushViewController: vc animated:YES];

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
