//
//  CustomerVipCardController.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/30.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "CustomerVipCardController.h"
#import "CustomerVipCardCell.h"
#import "RefundVipCardCell.h"
#import "VIPCardUseMessageController.h"
#import "AnnouncementsController.h"

#define customerVipCardCellId @"CustomerVipCardCell"
#define refundVipCardCellId @"RefundVipCardCell"

@interface CustomerVipCardController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *customerVipCardsTable;


@end

extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
CGFloat customerVipcardMarginLeft =16.0f;//会员卡距左
CGFloat customerVipcardMarginBottom = 16.0f;//会员卡距底
CGFloat customerVipcardSectionFooterHeight = 8.0f;//tableviewsection底部高度
CGFloat customerVipcardSectionHeaderHeight = 48.0f;//tableviewsection头部部高度

@implementation CustomerVipCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaVigationStyle];
    [self initTableView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -private
-(void)setNaVigationStyle{
    self.title = @"会员卡卡包";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zhuyishixiang"] style:UIBarButtonItemStylePlain target:self action:@selector(goToAnnouncements)];
    
}
-(void)initTableView{
    [self.customerVipCardsTable registerNibByCellId:customerVipCardCellId];
    [self.customerVipCardsTable registerNibByCellId:refundVipCardCellId];
}
//前往查看注意事项
-(void)goToAnnouncements{
    AnnouncementsController *vc = [[AnnouncementsController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CustomerVipCardCell *cell = [tableView dequeueReusableCellWithIdentifier:customerVipCardCellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell showDataWithDictionary:@{@"cardType":@(arc4random()%5+1)}];
        return cell;
    }else{
        RefundVipCardCell *cell = [tableView dequeueReusableCellWithIdentifier:refundVipCardCellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = (SCREEN_WIDTH-customerVipcardMarginLeft*2)*163/292+customerVipcardMarginBottom;
    return cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return customerVipcardSectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return customerVipcardSectionFooterHeight;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, customerVipcardSectionHeaderHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(customerVipcardMarginLeft, 0.0, SCREEN_WIDTH-customerVipcardMarginLeft*2, customerVipcardSectionHeaderHeight)];
    label.text = @"发卡商家:度的小店";
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textColor = [TDColorUtil parse:@"#333333"];
    [headerView addSubview:label];
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VIPCardUseMessageController *ctrl = [[VIPCardUseMessageController alloc] init];
    ctrl.titleStr = @"酷迪宠物普通卡";
    [self.navigationController pushViewController:ctrl animated:YES];
}
@end
