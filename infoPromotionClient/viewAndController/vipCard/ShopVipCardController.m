//
//  ShopVipCardController.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/29.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "ShopVipCardController.h"
#import "ShopVipCardCell.h"

#define shopVipCardCellId @"ShopVipCardCell"

@interface ShopVipCardController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *vipCardsTable;


@end

extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
CGFloat cardMarginLeft =16.0f;//会员卡距左
CGFloat cardMarginBottom = 16.0f;//会员卡距底
CGFloat sectionFooterHeight= 8.0f;
CGFloat sectionHeaderHeight = 8.0f;

@implementation ShopVipCardController

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
    [self.vipCardsTable registerNibByCellId:shopVipCardCellId];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopVipCardCell *cell = [tableView dequeueReusableCellWithIdentifier:shopVipCardCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showDataWithDictionary:@{@"cardType:":@(arc4random()%5+1)}];
    return cell;
}
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = (SCREEN_WIDTH-cardMarginLeft*2)*163/292+cardMarginBottom;
    return cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return sectionFooterHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return sectionHeaderHeight;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, sectionHeaderHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
}
@end
