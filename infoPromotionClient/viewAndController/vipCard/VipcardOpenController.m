//
//  VipcardOpenController.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/30.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "VipcardOpenController.h"
#import "VipcardChargeController.h"
#import "ShopVipCardCell.h"
#define cellId @"ShopVipCardCell"
extern CGFloat SCREEN_WIDTH;
@interface VipcardOpenController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cardHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *cardTableView;

//店铺名称
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
//使用门店数量
@property (weak, nonatomic) IBOutlet UILabel *availableShopCountLabel;
//使用范围
@property (weak, nonatomic) IBOutlet UILabel *useRangeLabel;
//使用场景
@property (weak, nonatomic) IBOutlet UILabel *useSceneLabel;
//使用限制
@property (weak, nonatomic) IBOutlet UILabel *useLimitLabel;
//消费限制
@property (weak, nonatomic) IBOutlet UILabel *consumeLimitLabel;
//其他说明
@property (weak, nonatomic) IBOutlet UILabel *otherStateLabel;
//联系电话
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;

@end

@implementation VipcardOpenController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBackItem];
    [self initWithItem];
    // Do any additional setup after loading the view from its nib.
}
-(void)initWithBackItem
{
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
-(void)initWithItem
{
    self.title = @"会员卡详情";
    [self.cardTableView registerNibByCellId:cellId];
    self.cardTableView.scrollEnabled = NO;
    self.navigationController.navigationBar.translucent = NO;
    NSMutableArray *useNoticeArr =[[NSMutableArray alloc]initWithObjects:self.useRangeLabel.text,self.useSceneLabel.text,self.useLimitLabel.text,self.consumeLimitLabel.text,self.otherStateLabel.text,nil];
    CGFloat height = 0;
    for (int i=0; i<useNoticeArr.count; i++) {
        height += [LJKHelper textHeightFromTextString:useNoticeArr[i] width:SCREEN_WIDTH-92 fontSize:13]-16>=0?[LJKHelper textHeightFromTextString:useNoticeArr[i] width:SCREEN_WIDTH-92 fontSize:13]:16;
    }
    self.cardHeight.constant =(SCREEN_WIDTH-32)*163.0/292.0+16;
    self.contentViewHeight.constant = (SCREEN_WIDTH-32)*163.0/292.0 + 334+72+height;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"zhuanfa"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
}
-(void)rightClick
{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREEN_WIDTH-32)*163.0/292.0+16;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopVipCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showDataWithDictionary:@{@"cardType":@(arc4random()%5+1)}];
    return cell;
}
//开卡店铺
- (IBAction)cardShopAction:(id)sender {
}
//联系电话
- (IBAction)callAction:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"联系商家:%@",self.phoneNumLabel.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
//适用门店
- (IBAction)availableShopAction:(id)sender {
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneNumLabel.text]]];
    }
}
- (IBAction)openCardAction:(id)sender {
    VipcardChargeController *vc = [[VipcardChargeController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
