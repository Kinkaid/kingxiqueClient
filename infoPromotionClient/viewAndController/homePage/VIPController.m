//
//  VIPController.m
//  infoPromotion
//
//  Created by imac on 15/12/16.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import "VIPController.h"
#import "VIPCell.h"
#import "CustomerVipCardController.h"
#import "PrivilegeCircleController.h"
#import "MyAccountController.h"
#import "LoginAndRegiterPrefaceController.h"
@interface VIPController ()<UITableViewDataSource,UITableViewDelegate,shopCallAndChatAndCounponActionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UILabel *vipTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *jiantouImageView;
@property (weak, nonatomic) IBOutlet UIView *collecttionShopExampleView;
@property (nonatomic) int i;

@property (nonatomic,strong)NSMutableArray *ary;

@end

@implementation VIPController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ary = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",nil];
    [self initWithItem];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [super viewWillAppear:animated];//登陆成功
    [TDApplicationUtil makeSureLoginThen:^{
        _i = 5;
        [self initWithTableView];
    } controller:self];
    _i = arc4random()%4;
    [self initWithTableView];
    
    
}
//收藏店铺
- (IBAction)collectShopAction:(id)sender {
   
}

-(void)initWithItem
{
    self.title = @"VIP";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"m-dingxiaoxi"] style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ditu"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClick)];
}
-(void)rightClick
{
    
}
-(void)leftClick
{
}
-(void)initWithTableView
{
    CGFloat width = self.view.frame.size.width;
    self.navigationController.navigationBar.translucent = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"VIPCell" bundle:nil] forCellReuseIdentifier:@"VIPCell"];
    CGRect newFrame = self.headerView.frame;
    
    newFrame.size.height = width*25.0/64.0+35+6+((width-25)/2.0)*63.0/148.0+8+6+40;
   
    self.headerView.frame = newFrame;
    [self.tableView setTableHeaderView:self.headerView];
    [self.headerView sizeToFit];
    if (_i==0) {
        self.jiantouImageView.hidden = NO;
        self.collecttionShopExampleView.hidden = NO;
    }else{
        self.jiantouImageView.hidden = YES;
        self.collecttionShopExampleView.hidden = YES;
    }
    [self.tableView reloadData];
}
#pragma mark -- tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VIPCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VIPCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.cellId = indexPath.row;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _i;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

#pragma mark -- IBActions
//会员卡action
- (IBAction)vipCardAction:(id)sender {
    CustomerVipCardController *ctrl = [[CustomerVipCardController alloc] init];
    ctrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
}
//优惠圈action
- (IBAction)couponCircleAction:(id)sender {
    PrivilegeCircleController *vc = [[PrivilegeCircleController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)callToShoperActionWithRow:(NSInteger)cellId
{
    NSLog(@"%ld",cellId);
}
-(void)chatToShoperAction
{

}
-(void)couponListAction
{
    
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
