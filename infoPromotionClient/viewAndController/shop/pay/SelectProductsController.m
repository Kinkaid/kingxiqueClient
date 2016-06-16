
//  SelectProductsController.m
//  infoPromotion
//
//  Created by zhujingci on 15/8/12.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "SelectProductsController.h"
#import "SelectProductsCell.h"
#import "SelectProductsCartCell.h"
#import <KLCPopup/KLCPopup.h>
#import "SelectProductsCategoryCell.h"
#import "CheckoutCategoryEntity.h"
#import <KLCPopup.h>
#import "SelectProductsConfirmController.h"

@interface SelectProductsController ()<UITableViewDelegate,UITableViewDataSource,SelectProductsCartCellDelegate,SelectProductsCellDelegate>

//商品列表
@property (weak, nonatomic) IBOutlet UITableView *productTable;

//类别列表
@property (weak, nonatomic) IBOutlet UITableView *categoryTable;

//底栏
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *numView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalFeeLabel;

//购物车
@property (strong, nonatomic) IBOutlet UIView *cartView;
@property (weak, nonatomic) IBOutlet UITableView *cartTable;
@property (strong, nonatomic) IBOutlet UIControl *cartShadeControl;

//商品大图
@property (strong, nonatomic) IBOutlet UIView *checkBigPicView;
@property (weak, nonatomic) IBOutlet UIImageView *bigPicImageView;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *segmentLine;


@end

extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
static NSString *cellId = @"SelectProductsCell";
static NSString *cartCellId = @"SelectProductsCartCell";
static NSString *productCategoryCellId = @"SelectProductsCategoryCell";
static CGFloat bottomViewHeight = 50.0f;
static CGFloat cartViewHeight = 400.0f;
static CGFloat contentViewMarginTop = 164.0f;
@implementation SelectProductsController{
    
    NSMutableArray *_categoryList;
    
    NSMutableArray *_cartProductList;
    
    NSInteger _curIndex;
    
    CGFloat _oldOffSet;
    
    int _curProductNum;
    
    int _curTotalFee;
    
    BOOL isSlideDown;//是否向下滑动
    
    KLCPopup *_checkBigPicPop;
    
    KLCPopup *_bottomPop;
    
    NSIndexPath *_editPriceIndexPath;
    
    //标记是否是商品管理返回,因为商品管理返回需刷新商品列表，而结算返回不需要刷新
    BOOL isProductManageBack;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initTableView];
    
//    [self loadData];
    [self loadTestData];
    [self initSubView];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self hideBottomPop];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (isProductManageBack) {//若是商品管理返回
        _categoryList = [[NSMutableArray alloc] init];
        _cartProductList = [[NSMutableArray alloc] init];
        [self loadData];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_curProductNum>0) {//bottomPop的显示放在didappear里能减少切换时bottomPop显示隐藏的bug频率
        [self showBottomPop];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -private
-(void)initData{
    _categoryList = [[NSMutableArray alloc] init];
    _cartProductList = [[NSMutableArray alloc] init];
    _curIndex = 0;
    _oldOffSet = 0;
    isSlideDown = YES;
    _curProductNum = 0;
    isProductManageBack = NO;
}
-(void)initTableView{
    [self.productTable registerNibByCellId:cellId];
    [self.productTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.cartTable registerNibByCellId:cartCellId];
    [self.categoryTable registerNibByCellId:productCategoryCellId];
}
-(void)initSubView{
    self.cartShadeControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-bottomViewHeight);
    [self.cartShadeControl addTarget:self action:@selector(hideCartPop) forControlEvents:UIControlEventTouchUpInside];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.cartShadeControl];
    self.cartShadeControl.hidden = YES;
    
    self.cartView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, cartViewHeight);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.cartView];
}
//加载数据
-(void)loadData{
    NSDictionary *params = @{@"shop_id":[TDUserDefaultsUtil getShopId],@"supply_status":@1};
    [[ServiceManager sharedInstance] getFunction:@"/shop/product/categories" params:params attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        NSArray *categories = data[@"categories"];
        for (NSDictionary *categoryDic in categories) {
            CheckoutCategoryEntity *categoryEntity = [TDDataConvertUtil getCheckoutCategoryEntityWithDic:categoryDic];
            [_categoryList addObject:categoryEntity];
            
        }
        [self.categoryTable reloadData];
        [self.productTable reloadData];
    } failActions:nil serviceFail:nil];
}
//加载测试数据
-(void)loadTestData{
    for (int i=0; i<5; i++) {
        CheckoutCategoryEntity *categoryEntity = [[CheckoutCategoryEntity alloc] init];
        categoryEntity.category_id = [NSString stringWithFormat:@"100%d",i];
        categoryEntity.category_name = @"今日特惠";
        categoryEntity.sn = i;
        NSMutableArray *products = [[NSMutableArray alloc] init];
        for (int j=0; j<5; j++) {
            ProductEntity *productEntity = [[ProductEntity alloc] init];
            productEntity.product_id = [NSString stringWithFormat:@"100%d%d",i,j];
            productEntity.product_name = @"好吃的";
            productEntity.price = 10000;
            productEntity.cover = @"product/2016/1/7f043d18584633318c42f80822a4b0ee_768X1024.jpg";
            [products addObject:productEntity];
        }
        categoryEntity.products = products;
        [_categoryList addObject:categoryEntity];
    }
    [self.categoryTable reloadData];
    [self.productTable reloadData];
    
}
-(NSMutableArray *)getTradeProductsParams{
    NSMutableArray *tradeProducts = [[NSMutableArray alloc] init];
    for (ProductEntity *cartProduct in _cartProductList) {
        NSDictionary *tradeProduct = @{@"product_id":cartProduct.product_id,@"price":[[NSNumber alloc] initWithInt:cartProduct.price],@"discount":@0,@"product_count":[[NSNumber alloc] initWithInt:cartProduct.chechkout_num]};
        [tradeProducts addObject:tradeProduct];
    }
    return tradeProducts;
}
//计算总额
-(void)calTotalNum{
    _curTotalFee = 0;
    _curProductNum = 0;
    for (ProductEntity *_cartProduct in _cartProductList) {
        _curTotalFee += _cartProduct.price*_cartProduct.chechkout_num;
        _curProductNum += _cartProduct.chechkout_num;
    }
    self.totalFeeLabel.text = [NSString stringWithFormat:@"%@元",[TDDataUtil parseIntPriceToStrPrice:_curTotalFee]];
    self.numLabel.text = [NSString stringWithFormat:@"%i",_curProductNum];
}
//购物车数量变化引起原商品列表数量变化
-(void)modifyProductCountWithCartCount:(ProductEntity *)product objAtIndexPath:(NSIndexPath *)indexPath{
    CheckoutCategoryEntity *categoryEntity =_categoryList[indexPath.section];
    NSMutableArray *products = [[NSMutableArray alloc] initWithArray:categoryEntity.products];
    ProductEntity *productEntity = products[indexPath.row];
    productEntity.chechkout_num = product.chechkout_num;
    [products replaceObjectAtIndex:indexPath.row withObject:productEntity];
    categoryEntity.products = products;
    [_categoryList replaceObjectAtIndex:indexPath.section withObject:categoryEntity];
}
//底栏
-(void)showBottomPop{
    self.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-bottomViewHeight-contentViewMarginTop, SCREEN_WIDTH, bottomViewHeight);
    _bottomPop = [KLCPopup popupWithContentView:self.bottomView showType:KLCPopupShowTypeSlideInFromBottom dismissType:KLCPopupDismissTypeSlideOutToBottom maskType:KLCPopupMaskTypeNone dismissOnBackgroundTouch:NO dismissOnContentTouch:NO];
    CGPoint point = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-contentViewMarginTop-(bottomViewHeight/2));
    [_bottomPop showAtCenter:point inView:self.view];
    [_bottomPop show];
}
-(void)hideBottomPop{
    [_bottomPop dismiss:YES];
}
//购物车
-(void)showCartPop{
    [TDApplicationUtil showPop:self.cartView toFrame:CGRectMake(0, SCREEN_HEIGHT-cartViewHeight-bottomViewHeight, SCREEN_WIDTH, cartViewHeight)];
    self.cartShadeControl.hidden = NO;
}
-(void)hideCartPop{
    [TDApplicationUtil showPop:self.cartView toFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, cartViewHeight)];
    self.cartShadeControl.hidden = YES;
    for (ProductEntity *product in _cartProductList) {
        [self modifyProductCountWithCartCount:product objAtIndexPath:product.index_path];
    }
    [self.productTable reloadData];
    
}
//商品大图
-(void)showBigPicPop{
    self.checkBigPicView.frame = CGRectMake(0, 0, SCREEN_WIDTH-20.0f, 310.0f);
    _checkBigPicPop = [KLCPopup popupWithContentView:self.checkBigPicView];
    [_checkBigPicPop show];
}
-(void)hideBigPicPop{
    [_checkBigPicPop dismiss:YES];
}
//类别列表选中行
-(void)didSelectCategoryTable{
    [self.categoryTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:_curIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
#pragma mark -IBActions
//购物车
- (IBAction)cartBtnTouchUpHandler:(id)sender {
    [self.cartTable reloadData];
    [self showCartPop];
}
//去结算
- (IBAction)gotoPayHandler:(id)sender {
    //    NSDictionary *params = @{@"shop_id":[TDUserDefaultsUtil getShopId],@"seller_id":[TDUserDefaultsUtil getSellerId],@"total_fee":[[NSNumber alloc] initWithInt:_curTotalFee],@"trade_products":[self getTradeProductsParams]};
    //    [[ServiceManager sharedInstance] postFunction:@"/trade/sellerwithproduct" params:params attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
    //        [self hideCartPop];
    //        TradeEntity *trade = [[TradeEntity alloc] init];
    //        trade.trade_id = data[@"trade_id"];
    //        trade.total_fee = _curTotalFee;
    //        isProductManageBack = NO;
    //
    //    } failActions:nil serviceFail:nil];
    SelectProductsConfirmController *confirmCtrl = [[SelectProductsConfirmController alloc] init];
    [self.navigationController pushViewController:confirmCtrl animated:YES];
}
//关闭大图
- (IBAction)closeBigPicPopAction:(id)sender {
    [self hideBigPicPop];
}


#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.productTable) {//商品列表
        CheckoutCategoryEntity *categoryEntity = _categoryList[section];
        if (section == _categoryList.count-1) {
            return categoryEntity.products.count+1;//若是最后一个section，则底部需要留空白
        }else{
           return categoryEntity.products.count;
        }
        
    }else if(tableView == self.cartTable){//购物车
        return _cartProductList.count;
    }else if(tableView == self.categoryTable){//商品类别
        return _categoryList.count;
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.productTable) {//商品列表
        CheckoutCategoryEntity *categoryEntity = _categoryList[indexPath.section];
        if (indexPath.section == _categoryList.count-1&&indexPath.row == categoryEntity.products.count) {//若是最后一个section，则底部需要留空白
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            return cell;
        }else{
            SelectProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            
            cell.product =categoryEntity.products[indexPath.row];
            cell.indexPath = indexPath;
            return cell;
        }
    }else if(tableView == self.categoryTable){//商品类别
        SelectProductsCategoryCell *cell=[tableView dequeueReusableCellWithIdentifier:productCategoryCellId forIndexPath:indexPath];
        CheckoutCategoryEntity *categoryEntity = _categoryList[indexPath.row];
        cell.categoryEntity = categoryEntity;
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if(tableView == self.cartTable){//购物车
        SelectProductsCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cartCellId forIndexPath:indexPath];
        cell.product = _cartProductList[indexPath.row];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        return nil;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==self.productTable) {//商品列表
        return _categoryList.count;
    }else if(tableView == self.categoryTable){//商品类别
        return 1;
    }else if(tableView == self.cartTable){//购物车
        return 1;
    }else{
        return 0;
    }
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.categoryTable) {
        CheckoutCategoryEntity *categoryEntity = _categoryList[indexPath.row];
        NSArray *products = categoryEntity.products;
        if (products.count>0) {
            [self.productTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView==self.productTable) {//商品列表
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 30.0)];
        customView.backgroundColor = [TDColorUtil parse:@"#F2F2F6"];
        
        UILabel * headerLabel = [[UILabel alloc]init];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.opaque = NO;
        headerLabel.textColor = [UIColor lightGrayColor];
        headerLabel.highlightedTextColor = [UIColor whiteColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:12];
        headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 30.0);
        CheckoutCategoryEntity *categoryEntity = _categoryList[section];
        headerLabel.text =  categoryEntity.category_name;
        
        [customView addSubview:headerLabel];
        
        return customView;
    }else{
        return nil;
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==self.cartTable) {//商品列表
        return YES;
    }
    return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {//删除行
        ProductEntity *cartProduct = _cartProductList[indexPath.row];
        cartProduct.chechkout_num = 0;
        [self modifyProductCountWithCartCount:cartProduct objAtIndexPath:cartProduct.index_path];
        [_cartProductList removeObjectAtIndex:indexPath.row];
        [self.cartTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self calTotalNum];
        if (_cartProductList.count==0) {
            [self hideCartPop];
            [self hideBottomPop];
            [self.productTable reloadData];
            _curProductNum = 0;
            _cartProductList = [[NSMutableArray alloc] init];
        }
    }
}
//实现右侧table滑动 左侧segment联动
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (tableView==self.productTable) {//商品列表
        if (isSlideDown) {//下滑状态执行
            if(section<_categoryList.count-1){
                _curIndex = section+1;
                [self didSelectCategoryTable];
            }
            
            
        }
    }
    
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (tableView==self.productTable) {//商品列表
        if (!isSlideDown) {//上滑状态执行
            _curIndex = section;
            [self didSelectCategoryTable];
        }
    }
    
}
//判断上滑下滑状态
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y>_oldOffSet) {
        isSlideDown = YES;
    }else{
        isSlideDown = NO;
    }
    _oldOffSet = scrollView.contentOffset.y;
    
}

#pragma mark -CheckoutProductCellDelegate 商品列表Delegate
-(void)addProductNum:(ProductEntity *)product atIndexPath:(NSIndexPath *)indexPath{
    if (_curProductNum==0) {
        _numView.hidden = NO;
        [self showBottomPop];
    }
    
    
    BOOL isProductExist = false;
    for (int i=0;i<_cartProductList.count;i++) {//购物车中若存在则替换
        ProductEntity *cartProduct = _cartProductList[i];
        if ([cartProduct.product_id isEqualToString:product.product_id]) {
            [_cartProductList replaceObjectAtIndex:i withObject:product];
            isProductExist = true;
            break;
        }
    }
    if (!isProductExist) {//在购物车中不存在
        product.index_path = indexPath;
        [_cartProductList addObject:product];
    }
    [self calTotalNum];
    
    
}
-(void)minusProductNum:(ProductEntity *)product atIndexPath:(NSIndexPath *)indexPath{
    if (_curProductNum>0) {
        
        for (int i=0;i<_cartProductList.count;i++) {//购物车中若存在则替换
            ProductEntity *cartProduct = _cartProductList[i];
            if ([cartProduct.product_id isEqualToString:product.product_id]) {
                if (product.chechkout_num>0) {
                    [_cartProductList replaceObjectAtIndex:i withObject:product];
                }else{//减到0 直接从购物车去除
                    [_cartProductList removeObjectAtIndex:i];
                }
                break;
            }
        }
        [self calTotalNum];
    }
    if (_curProductNum==0) {
        _numView.hidden = YES;
        [self hideBottomPop];
    }
    
}
-(void)checkBigImage:(ProductEntity *)product{
    [self showBigPicPop];
}

#pragma mark -购物车商品Delegate
-(void)minusCartProduct:(ProductEntity *)product{
    if (_curProductNum>0) {
        [self calTotalNum];
    }
    if (_curProductNum==0) {
        _numView.hidden = YES;
        [self hideBottomPop];
        [self hideCartPop];
        _cartProductList = [[NSMutableArray alloc] init];
    }
}
-(void)addCartProductNum:(ProductEntity *)product{
    [self calTotalNum];
}


@end
