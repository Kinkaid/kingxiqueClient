//
//  OrderDetailController.m
//  infoPromotionClient
//
//  Created by imac on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailCodeCell.h"
#import "SpecialProductDetailCell.h"
#import "ShopMainController.h"
#define OrderCodeCellId @"OrderDetailCodeCell"
#define ProductCellId @"SpecialProductDetailCell"
extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
@interface OrderDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonViewHeight;


@property (weak, nonatomic) IBOutlet UIScrollView *productScrollView;
//商品主标题
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
//商品副标题
@property (weak, nonatomic) IBOutlet UILabel *productSubTitleLabel;
//当前价格
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
//原始价格
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
//有效期
@property (weak, nonatomic) IBOutlet UILabel *validityLabel;
//随时退View
@property (weak, nonatomic) IBOutlet UIView *refundAnyTimeView;
//过期退View
@property (weak, nonatomic) IBOutlet UIView *refundPastDueView;
//评论数量
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
//开卡店铺
@property (weak, nonatomic) IBOutlet UILabel *openCardShopNameLabel;
//店铺电话
@property (weak, nonatomic) IBOutlet UILabel *shopPhoneNumLabel;
//使用范围
@property (weak, nonatomic) IBOutlet UILabel *useRangeLabel;
//使用规范
@property (weak, nonatomic) IBOutlet UILabel *useFlowPathLabel;


@property (weak, nonatomic) IBOutlet UITableView *orderCodeTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderCodeTableViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *productTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productTableViewHeight;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (nonatomic,strong)UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIView *refundAndCommentView;

@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBackItem];
    [self initWithItem];
    [self initWithScrollView];
    [self initWithTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}
-(void)initWithBackItem
{
    self.title = @"订单详情";
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
    int j = arc4random()%2;
    self.orderCodeTableViewHeight.constant = 100;
    self.productTableViewHeight.constant = 180;
    NSMutableArray *useNoticeArr = [[NSMutableArray alloc]initWithObjects:self.useRangeLabel.text,self.useFlowPathLabel.text,nil];
    CGFloat useNoticeHeight = 0;
    for (int i=0; i<useNoticeArr.count; i++) {
        useNoticeHeight +=[LJKHelper textHeightFromTextString:useNoticeArr[i] width:SCREEN_WIDTH-94 fontSize:13]>=16?[LJKHelper textHeightFromTextString:useNoticeArr[i] width:SCREEN_WIDTH-94 fontSize:13]-16:0;
    }
    self.contentViewHeight.constant = SCREEN_WIDTH*37.0/65.0+463+useNoticeHeight+100+180;
    if (j==1) {
        self.refundAndCommentView.hidden = NO;
        self.buttonViewHeight.constant = 48;
    }else{
        self.refundAndCommentView.hidden = YES;
        self.buttonViewHeight.constant = 0;
    }
}
-(void)initWithTableView
{
    [self.orderCodeTableView registerNibByCellId:OrderCodeCellId];
    self.orderCodeTableView.scrollEnabled =NO ;
    self.productTableView.scrollEnabled = NO ;
    [self.productTableView registerNibByCellId:ProductCellId];
}
-(void)initWithScrollView
{
    self.productScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*5, SCREEN_WIDTH*37.0/65.0);
    for (int i=0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i,0, SCREEN_WIDTH, SCREEN_WIDTH*37.0/65.0)];
        imageView.image = [UIImage imageNamed:@"meishi_"];
        [self.productScrollView addSubview:imageView];
    }
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3.0*2, SCREEN_WIDTH*37.0/65.0-25, SCREEN_WIDTH/3.0, 6)];
    self.pageControl.currentPageIndicatorTintColor = [TDColorUtil parse:@"#EC5413"];
    self.pageControl.pageIndicatorTintColor = [TDColorUtil parse:@"#FFFFFF"];
    self.pageControl.numberOfPages = 5;
    [self.contentView addSubview:self.pageControl];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.productTableView) {
        return 60;
    }else{
        return 50;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.productTableView) {
        return 3;
    }else{
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.productTableView) {
        SpecialProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductCellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        OrderDetailCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCodeCellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.productScrollView) {
        _pageControl.currentPage=scrollView.contentOffset.x/SCREEN_WIDTH;
    }
}

- (IBAction)shopMessageAction:(id)sender {
    ShopMainController *vc = [[ShopMainController alloc]init];
    vc.checkShopInfo = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)callShopAction:(id)sender {
}

#pragma mark -- IBActions
- (IBAction)refundAction:(id)sender {
}
- (IBAction)commentAction:(id)sender {
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
