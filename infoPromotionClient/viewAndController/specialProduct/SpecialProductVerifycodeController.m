//
//  SpecialProductVerifycodeController.m
//  infoPromotionClient
//
//  Created by zhujingci on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "SpecialProductVerifycodeController.h"
#import "SpecialProductVerifycodeCell.h"

@interface SpecialProductVerifycodeController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *verifycodeTableHeaderView;

//验证码table
@property (weak, nonatomic) IBOutlet UITableView *verifycodeTable;


@end

#define specialProductVerifycodeCellId @"SpecialProductVerifycodeCell"
@implementation SpecialProductVerifycodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationStyle];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -private
-(void)setNavigationStyle{
    self.title = @"订单详情";
}
-(void) initTableView{
    [self.verifycodeTable setTableHeaderView:self.verifycodeTableHeaderView];
    [self.verifycodeTable registerNibByCellId:specialProductVerifycodeCellId];
}
#pragma mark -IBActions
- (IBAction)checkTradeInfoHandler:(id)sender {
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SpecialProductVerifycodeCell *cell = [tableView dequeueReusableCellWithIdentifier:specialProductVerifycodeCellId forIndexPath:indexPath];
    return cell;
}

@end
