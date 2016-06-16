//
//  SpecialProductDetailController.m
//  infoPromotionClient
//
//  Created by imac on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "SpecialProductDetailController.h"
#import "SpecialProductDetailCell.h"
#import "SpecialProductPayController.h"
#import "ShopMainController.h"
#define cellId @"SpecialProductDetailCell"
extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
@interface SpecialProductDetailController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *productPicScrollView;
//商品标题
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
//商品副标题
@property (weak, nonatomic) IBOutlet UILabel *productSubTitleLabel;
//当前价格
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
//原始价格
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
//剩余份数
@property (weak, nonatomic) IBOutlet UILabel *surplusProductCountLabel;
//有效期
@property (weak, nonatomic) IBOutlet UILabel *validityLabel;
//随时退
@property (weak, nonatomic) IBOutlet UIView *refundAnyTimeView;
//过期退
@property (weak, nonatomic) IBOutlet UIView *refundPastDueView;
//评论数量
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
//开卡店铺
@property (weak, nonatomic) IBOutlet UILabel *openCardShopLabel;
//店铺电话
@property (weak, nonatomic) IBOutlet UILabel *shopPhoneNumLabel;
//使用范围
@property (weak, nonatomic) IBOutlet UILabel *useRangeLabel;
//使用流程
@property (weak, nonatomic) IBOutlet UILabel *useFlowPathLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation SpecialProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBackItem];
    [self initWithItem];
    [self initWithScrollView];
    [self initWithTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)initWithBackItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"specailProducZhuanfa"] style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
-(void)rightClick
{
    NSLog(@"hehe");
}
-(void)initWithItem
{
    self.title = @"特价商品详情";
    self.useFlowPathLabel.text = @"只能到店消费\n不能兑换现金、不能透支、不计利息";
    NSMutableArray *useNoticeArr = [[NSMutableArray alloc]initWithObjects:self.useRangeLabel.text,self.useFlowPathLabel.text,nil];
    CGFloat useNoticeHeight = 0;
    for (int i=0; i<useNoticeArr.count; i++) {
        useNoticeHeight += [LJKHelper textHeightFromTextString:useNoticeArr[i] width:SCREEN_WIDTH-94 fontSize:13]>=16?[LJKHelper textHeightFromTextString:useNoticeArr[i] width:SCREEN_WIDTH-94 fontSize:13]-16:0;
    }
    self.tableViewHeightConstraint.constant = 180;
    self.contentViewHeight.constant = 452+SCREEN_WIDTH*37.0/65.0+180+useNoticeHeight;
}
-(void)initWithScrollView
{
    self.productPicScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*5, SCREEN_WIDTH*37.0/65.0);
    for (int i=0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i,0, SCREEN_WIDTH, SCREEN_WIDTH*37.0/65.0)];
        imageView.image = [UIImage imageNamed:@"meishi_"];
        [self.productPicScrollView addSubview:imageView];
    }
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3*2, SCREEN_WIDTH*37.0/65.0-25, self.view.frame.size.width/3, 6)];
    self.pageControl.currentPageIndicatorTintColor = [TDColorUtil parse:@"#EC5413"];
    self.pageControl.pageIndicatorTintColor = [TDColorUtil parse:@"#FFFFFF"];
    self.pageControl.numberOfPages = 5;
    self.pageControl.userInteractionEnabled = NO;
    [self.contentView addSubview:self.pageControl];
}
-(void)initWithTableView
{
    [self.tableView registerNibByCellId:cellId];
    self.tableView.scrollEnabled = NO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.productPicScrollView) {
        _pageControl.currentPage=scrollView.contentOffset.x/SCREEN_WIDTH;
    }
}
#pragma mark -- IBActions
- (IBAction)buyAtOnceAction:(id)sender {
    SpecialProductPayController *vc = [[SpecialProductPayController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//查看评论
- (IBAction)checkCommentAction:(id)sender {
}
//发放店铺
- (IBAction)openCardShopAction:(id)sender {
    ShopMainController *vc = [[ShopMainController alloc]init];
    vc.checkShopInfo = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//联系电话
- (IBAction)callShoperAction:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"呼叫店主:%@",self.shopPhoneNumLabel.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 1;
    [alertView show];
    
}
#pragma mark -- alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.shopPhoneNumLabel.text]]];
    }
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
