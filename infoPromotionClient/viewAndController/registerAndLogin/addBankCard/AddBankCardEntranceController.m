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
#define entranceCellId @"AddBankCardEntranceCell"
#define bankCardListCellId @"BankCardListCell"
@interface AddBankCardEntranceController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bankCardListTableView;
@property (nonatomic,strong)NSMutableArray *bankCardListArr;
@end

@implementation AddBankCardEntranceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initWithTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData
{
    self.title= @"银行卡管理";
    self.bankCardListArr = [[NSMutableArray alloc]init];
    [self.bankCardListArr addObject:@"1"];
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
        return 70;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.bankCardListArr.count +1;
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
