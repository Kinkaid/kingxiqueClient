//
//  DirectPayController.m
//  infoPromotionClient
//
//  Created by zhujingci on 16/3/2.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "DirectPayController.h"

#define PayCouponCellId @"PayCouponCell"
#define PayVipCardCellId @"PayVipCardCell"
@interface DirectPayController ()

@property (weak, nonatomic) IBOutlet UITableView *directPayTableview;
@property (strong, nonatomic) IBOutlet UIView *directPayTableHeaderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noDiscountSelectViewMarginBottom;
@property (weak, nonatomic) IBOutlet UIButton *noDiscountSelectButton;
@property (weak, nonatomic) IBOutlet UIView *noDiscountInputView;
//付给哪个店铺
@property (weak, nonatomic) IBOutlet UILabel *payToShopNameLabel;
//费用合计
@property (weak, nonatomic) IBOutlet UILabel *needPayMoneyCountLabel;

@end

extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
static BOOL hasNoDiscount;//标记 是否有不参与优惠的金额
static CGFloat noDiscountInputViewHeight = 40.0f;//不参与优惠输入View的高度

@implementation DirectPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationStyle];
    [self initTableView];
    hasNoDiscount = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -private
-(void)setNavigationStyle{
    self.navigationController.navigationBar.translucent = YES;
}
//初始化tableview
-(void)initTableView{
    [self.directPayTableview registerNibByCellId:PayCouponCellId];
    [self.directPayTableview registerNibByCellId:PayVipCardCellId];
    [self.directPayTableview setTableHeaderView:self.directPayTableHeaderView];
}
#pragma mark -IBActions
- (IBAction)payAction:(id)sender {
    PayChannelController *ctrl = [[PayChannelController alloc] init];
    ctrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
}
- (IBAction)noDiscountSelectAction:(id)sender {
    hasNoDiscount = !hasNoDiscount;
    if (hasNoDiscount) {//有不参与优惠的金额
        self.noDiscountSelectViewMarginBottom.constant = noDiscountInputViewHeight + 26.0f;
        self.noDiscountInputView.hidden = NO;
        [self.noDiscountSelectButton setImage:[UIImage imageNamed:@"dagou"] forState:UIControlStateNormal];
        CGRect newFrame = self.directPayTableHeaderView.frame;
        newFrame.size.height = newFrame.size.height + noDiscountInputViewHeight;
        self.directPayTableHeaderView.frame = newFrame;
    }else{//无不参与优惠的金额
        self.noDiscountSelectViewMarginBottom.constant = 26.0f;
        self.noDiscountInputView.hidden = YES;
        [self.noDiscountSelectButton setImage:[UIImage imageNamed:@"budagou"] forState:UIControlStateNormal];
        CGRect newFrame = self.directPayTableHeaderView.frame;
        newFrame.size.height = newFrame.size.height - noDiscountInputViewHeight;
        self.directPayTableHeaderView.frame = newFrame;
    }
    [self.directPayTableview setTableHeaderView:self.directPayTableHeaderView];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PayCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:PayCouponCellId forIndexPath:indexPath];
        [cell showCellWithModel:nil andIndex:indexPath];
        return cell;
    }else{
        PayVipCardCell *cell = [tableView dequeueReusableCellWithIdentifier:PayVipCardCellId forIndexPath:indexPath];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}


@end
