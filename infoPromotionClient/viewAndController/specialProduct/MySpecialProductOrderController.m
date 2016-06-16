//
//  MySpecialProductOrderController.m
//  infoPromotionClient
//
//  Created by imac on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "MySpecialProductOrderController.h"
#import "MySpecialProductOrderCell.h"
#import "HMSegmentedControl.h"
#import "OrderDetailController.h"
#import "refundOrderController.h"
#define cellId @"MySpecialProductOrderCell"
@interface MySpecialProductOrderController ()<UITableViewDataSource,UITableViewDelegate,MySpecialProductOrderDelegate>
@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation MySpecialProductOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBackItem];
    [self initWithSegmentControl];
    [self initWithTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.translucent = NO;
}
-(void)initWithBackItem
{
    self.title = @"特价商品订单";
    self.navigationController.navigationBar.translucent = NO;
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
-(void)initWithSegmentControl
{
    self.segmentControl.sectionTitles = @[@"全部",@"待付款",@"待使用",@"待评价",@"已完成",@"退款",@"过期"];
    self.segmentControl.font = [UIFont systemFontOfSize:13];
    self.segmentControl.selectedTextColor = [TDColorUtil parse:@"#EC5413"];
    self.segmentControl.textColor = [TDColorUtil parse:@"#333333"];
    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentControl.selectionIndicatorHeight = 2;
    self.segmentControl.selectionStyle = HMSegmentedControlSegmentWidthStyleFixed;
    self.segmentControl.selectionIndicatorColor = [TDColorUtil parse:@"#EC5413"];
}
-(void)initWithTableView
{
    [self.tableView registerNibByCellId:cellId];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySpecialProductOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.delegate = self;
    cell.cellRow = indexPath.section;
    switch (indexPath.section) {
        case 0:
        {
           cell.orderStateLabel.text = @"待消费";
            [cell.leftBtn setTitle:@"退单" forState:UIControlStateNormal];
            [cell.rightBtn setTitle:@"查看券码" forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            cell.orderStateLabel.text = @"待付款";
            [cell.leftBtn setTitle:@"删除" forState:UIControlStateNormal];
            [cell.rightBtn setTitle:@"付款" forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            cell.orderStateLabel.text = @"待评价";
            [cell.leftBtn setTitle:@"删除" forState:UIControlStateNormal];
            [cell.rightBtn setTitle:@"评价" forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            cell.orderStateLabel.text = @"已完成";
            cell.orderStateLabel.textColor = [TDColorUtil parse:@"#1E9F00"];
            cell.leftBtn.hidden = YES;
            [cell.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailController *vc = [[OrderDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)segmentControlAction:(id)sender {
    switch (self.segmentControl.selectedSegmentIndex) {
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
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
            
        default:
            break;
    }
}
-(void)leftBtnActionWithCellRow:(NSInteger)cellRow withBtn:(UIButton *)leftBtn
{
    if ([leftBtn.titleLabel.text isEqualToString:@"退单"]) {
        refundOrderController *vc = [[refundOrderController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)rightBtnActionWithCellRow:(NSInteger)cellRow withBtn:(UIButton *)rightBtn
{
    NSLog(@"%ld----%@",cellRow,rightBtn.titleLabel.text);
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
