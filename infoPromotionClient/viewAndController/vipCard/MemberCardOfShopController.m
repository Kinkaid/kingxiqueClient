//
//  MemberCardOfShopController.m
//  infoPromotionClient
//
//  Created by imac on 15/12/31.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "MemberCardOfShopController.h"
#import "ShopVipCardCell.h"
#define cellId @"ShopVipCardCell"
extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;

@interface MemberCardOfShopController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MemberCardOfShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithItem];
    [self initWithTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)initWithItem
{
    self.title = @"会员卡";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shezhi"] style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
}
-(void)rightClick
{
    
}
-(void)initWithTableView
{
    [self.tableView registerNibByCellId:cellId];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopVipCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showDataWithDictionary:@{@"caryType":@(arc4random()%5+1)}];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = (SCREEN_WIDTH-32.0)*163.0/292.0+16.0f;
    return cellHeight;
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
