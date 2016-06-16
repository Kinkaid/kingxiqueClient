//
//  BankCardAddController.m
//  infoPromotion
//
//  Created by zhujingci on 15/9/3.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "BankCardAddController.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <KLCPopup/KLCPopup.h>
#import "BankListHeaderView.h"
#import "BankCardAddCell.h"
#import "BankListModel.h"
#import "BankCardAddTextCell.h"
#import <KLCPopup.h>
#define cellID @"BankCardAddCell"
#define cellId @"BankCardAddTextCell"
#define bankListHeaderCellId @"BankListHeaderView"

@interface BankCardAddController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *BankListCollectionView;

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *uncommenDataArr;

@property (weak, nonatomic) IBOutlet UITextField *depositBank;

@property (strong, nonatomic) IBOutlet UIView *popView;

@property (nonatomic,strong)KLCPopup *curPop;

- (IBAction)addBankBtn:(id)sender;
- (IBAction)popBtnAction:(id)sender;

@end

@implementation BankCardAddController{
    
    __weak IBOutlet UIPickerView *_regionPickerView;
    
    __weak IBOutlet UITextField *_regionInput;
    
    __weak IBOutlet UIPickerView *_bankPickerView;
    
    __weak IBOutlet UITextField *_bankInput;
    
    
    
    NSArray *_regionList;
    
    IBOutlet UIView *_bankChooseView;
    
    KLCPopup *_curPop;
    
    NSString *_bankId;
    
    
}
//友盟页面统计

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [MobClick beginLogPageView:@"BankCardAddController"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [MobClick endLogPageView:@"BankCardAddController"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationStyle];
    [self setPickerView];
    [self initBankCollection];
    [self createCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createCollectionView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.BankListCollectionView.delegate = self;
    self.BankListCollectionView.dataSource = self;
    [self.BankListCollectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
    [self.BankListCollectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
    [self.BankListCollectionView registerNib:[UINib nibWithNibName:bankListHeaderCellId bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:bankListHeaderCellId];
}
#pragma mark -collectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataArr.count;
        
    }else{
        return self.uncommenDataArr.count;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BankCardAddCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        BankListModel *model = self.dataArr[indexPath.item];
        [cell showDataWithModel:model];
        return cell;
    }else{
        BankCardAddTextCell *textCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        BankListModel *model = self.uncommenDataArr[indexPath.item];
        
        [textCell showDataWithModel:model];
        return textCell;
    }
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reuseView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BankListHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:bankListHeaderCellId forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headerView.titleLabel.text = @"常用银行";
        }else{
            headerView.titleLabel.text = @"城市商业银行";
        }
        reuseView = headerView;
    }
    
    
    return reuseView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    //如果垂直滚动 view的width与集合视图一致,需要设置高度
    return CGSizeMake(self.view.frame.size.width,30);
}
#pragma mark -private
-(void)setNavigationStyle{
    self.title = @"添加银行卡";
}
-(void)setPickerView{
    [_regionPickerView removeFromSuperview];
    _regionInput.inputView = _regionPickerView;
    _regionList = [[NSMutableArray alloc] init];
    [self loadXzqhData];
}
-(void)initBankCollection{
    //    [self.BankListCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell"];
    self.dataArr = [[NSMutableArray alloc]init];
    self.uncommenDataArr = [[NSMutableArray alloc]init];
    [self loadBanksData];
}
//加载行政区划数据
-(void)loadXzqhData{
    ServiceManager *manager = [ServiceManager sharedInstance];
    [manager getFunction:@"/system/xzqh" params:nil attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        
        _regionList = data[@"xzqh"];
        
    } failActions:nil serviceFail:nil];
}
//加载银行数据
-(void)loadBanksData{
    ServiceManager *manager = [ServiceManager sharedInstance];
    [manager getFunction:@"/account/withdraw/banks" params:nil attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        NSArray *ary = data[@"common_bank_list"];
        for (NSDictionary *dic in ary) {
            BankListModel *model = [[BankListModel alloc]init];
            model.bankNameStr = dic[@"bank_name"];
            model.idStr = dic[@"id"];
            [self.dataArr addObject:model];
        }
        NSArray *uncommenAry = data[@"uncommon_bank_list"];
        for (NSDictionary *dic in uncommenAry) {
            BankListModel *model = [[BankListModel alloc]init];
            model.bankNameStr = dic[@"bank_name"];
            model.idStr = dic[@"id"];
            [self.uncommenDataArr addObject:model];
        }
    } failActions:nil serviceFail:nil];
}

-(void)showBankListPop{
    _curPop = [KLCPopup popupWithContentView:_bankChooseView];
    [_curPop show];
}
-(void)hideBankListPop{
    [_curPop dismiss:YES];
}


#pragma mark -UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    NSInteger componetsNum = 1;
    if (pickerView==_regionPickerView) {
        componetsNum= 2;
    }else if(pickerView == _bankPickerView){
        componetsNum = 1;
    }
    return componetsNum;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger rowsNum = 0;
    if (pickerView == _regionPickerView) {
        if (component==0) {
            rowsNum =  _regionList.count;
        }else{
            NSInteger provinceRow = [_regionPickerView selectedRowInComponent:0];
            NSArray *citys = _regionList[provinceRow][@"children"];
            rowsNum = citys.count;
        }
    }
    return rowsNum;
    
}
#pragma mark -UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = @"";
    if (pickerView == _regionPickerView) {
        if (component==0) {
            str =  _regionList[row][@"short_name"];
        }else{
            NSInteger provinceRow = [_regionPickerView selectedRowInComponent:0];
            NSArray *citys = _regionList[provinceRow][@"children"];
            str =  citys[row][@"short_name"];
        }
    }
    return str;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}
#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _regionInput) {
        if (_regionList.count==0) {
            return NO;
        }
    }else if(textField == _bankInput){
        [self showBankListPop];
        return NO;
    }
    return YES;
}

//银行卡开户城市及所属银行点击 "完成"
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==_regionInput) {
        NSInteger provinceRow = [_regionPickerView selectedRowInComponent:0];
        NSInteger cityRow = [_regionPickerView selectedRowInComponent:1];
        NSArray *citys = _regionList[provinceRow][@"children"];
        textField.text = [NSString stringWithFormat:@"%@ %@",_regionList[provinceRow][@"short_name"],citys[cityRow][@"short_name"]];
    }
    
}

#pragma mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = (self.BankListCollectionView.frame.size.width - 4*6)/3;
    CGFloat cellHeight = cellWidth/2;
    CGSize size = CGSizeMake(cellWidth, cellHeight);
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BankListModel *model = (BankListModel *)self.dataArr[indexPath.item];
        _bankInput.text =model.bankNameStr;
        _bankId = model.idStr;
    }
    else{
        BankListModel *model = (BankListModel *)self.uncommenDataArr[indexPath.item];
        _bankInput.text =model.bankNameStr;
        _bankId = model.idStr;
    }
    [self hideBankListPop];
}
- (IBAction)addBankBtn:(id)sender {

    if (_bankInput.text.length==0||_regionInput.text.length==0||self.bankCardNum.length==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请把信息填写完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        
        NSString *bankCardRegion = _regionInput.text;
        NSArray *regionArr = [bankCardRegion componentsSeparatedByString:@" "];
        NSString *bankCardCity = regionArr[1];
        NSString *bankCardProvince = regionArr[0];
        NSDictionary *bankCardMessage = @{@"shop_id":[TDUserDefaultsUtil getShopId],@"owner_name":self.bankCardOwner,@"card_no":self.bankCardNum,@"bank_name":_bankInput.text,@"bank_id":_bankId,@"deposit_bank":self.depositBank.text,@"city":bankCardCity,@"province":bankCardProvince,@"cover":@""};
        ServiceManager *manager = [ServiceManager sharedInstance];
        NSDictionary *attr = @{@"showHud":@NO};
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
        hud.labelText = [NSString stringWithFormat:@"银行卡信息正在认证中..."];
        hud.mode = MBProgressHUDModeText;
        [manager postFunction:@"/account/withdraw/bankcard" params:bankCardMessage attributes:attr success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
            UIViewController *viewVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
            [hud hide:YES];
            [self.navigationController popToViewController:viewVC animated:YES];
           
        } failActions:@{@"0":^(NSDictionary *responseObject, NSDictionary *data, NSString *msg){
            [hud hide:YES];
            [self showPop];
        }} serviceFail:nil];
    [MobClick event:@"BankCardAdd" attributes:nil];
   }
}
-(void)showPop
{
    self.curPop = [KLCPopup popupWithContentView:self.popView];
    self.curPop.shouldDismissOnBackgroundTouch = NO;
    [self.curPop show];
}
- (IBAction)popBtnAction:(id)sender {
    [self.curPop dismiss:YES];
    NSArray *vcArr = self.navigationController.viewControllers;
    [self.navigationController popToViewController:vcArr[2] animated:YES];
}
@end
