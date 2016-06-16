//
//  SelectProductsConfirmController.m
//  infoPromotionClient
//
//  Created by zhujingci on 16/3/4.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "SelectProductsConfirmController.h"

#define productCellId @"SelectProductsConfirmCell"
#define couponCellId @"PayCouponCell"
#define vipcardCellId @"PayVipCardCell"

@interface SelectProductsConfirmController ()

@property (weak, nonatomic) IBOutlet UITableView *confirmTable;


@end

extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
@implementation SelectProductsConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -private
-(void)initTableView{
    [self.confirmTable registerNibByCellId:productCellId];
    [self.confirmTable registerNibByCellId:couponCellId];
    [self.confirmTable registerNibByCellId:vipcardCellId];
}
#pragma mark -IBActions
- (IBAction)payAction:(id)sender {
    PayChannelController *ctrl = [[PayChannelController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {//商品列表
        return 2;
    }else if(section==1){//优惠券列表
        return 2;
    }else if(section==2){//会员卡列表
        return 1;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {//商品列表
        SelectProductsConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellId forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section==1){//优惠券列表
        PayCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:couponCellId forIndexPath:indexPath];
        [cell showCellWithModel:nil andIndex:indexPath];
        return cell;
    }else if (indexPath.section==2){//会员卡列表
        PayVipCardCell *cell = [tableView dequeueReusableCellWithIdentifier:vipcardCellId forIndexPath:indexPath];
        return cell;
    }else{
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {//商品列表
        return 76.0f;
    }else if (indexPath.section==1){//优惠券列表
        return 55.0f;
    }else if (indexPath.section==2){//会员卡列表
        return 55.0f;
    }else{
        return 0.0f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 32.0f;
    }else{
        return 0.0f;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 32.0f)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 16.0f, SCREEN_WIDTH, 12.0f)];
        label.text = @"商家优惠信息";
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = [TDColorUtil parse:@"#666666"];
        [headView addSubview:label];
        return headView;
    }else{
        return nil;
    }
    
}
@end
