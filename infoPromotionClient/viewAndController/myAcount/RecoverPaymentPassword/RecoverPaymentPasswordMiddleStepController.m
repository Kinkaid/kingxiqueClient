//
//  RecoverPaymentPasswordMiddleStepController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/1.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "RecoverPaymentPasswordMiddleStepController.h"
#import "PasswordManagerController.h"
#import "BankListHeaderView.h"
#import "BankCardAddCell.h"
#import "BankListModel.h"
#import "BankCardAddTextCell.h"
#define commonCellID @"BankCardAddCell"
#define unconmmonCellID @"BankCardAddTextCell"
#define bankListHeaderCellId @"BankListHeaderView"
@interface RecoverPaymentPasswordMiddleStepController ()<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//开户行
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;

@property (strong, nonatomic) IBOutlet UIView *bankChooseView;
@property (weak, nonatomic) IBOutlet UICollectionView *BankListCollectionView;
@property (nonatomic,strong)NSString*bankId;
@property (nonatomic,strong)NSMutableArray *commonBankDataArr;
@property (nonatomic,strong)NSMutableArray *uncommonBankDataArr;
@property (nonatomic,strong)KLCPopup *curPop;

//身份证号
@property (weak, nonatomic) IBOutlet UITextField *IDTextField;
//手机号
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *securityTextField;

//验证码label
@property (weak, nonatomic) IBOutlet UILabel *securityCodeLabel;
@property (weak, nonatomic) IBOutlet UIControl *secureityCodeBtn;
//发送验证码秒
@property (nonatomic)int second;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation RecoverPaymentPasswordMiddleStepController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBackItem];
    [self createCollectionView];
    [self loadBanksData];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.secureityCodeBtn.userInteractionEnabled = NO;
}
-(void)initWithBackItem
{
    self.navigationItem.title = @"找回支付密码";
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)];
    [self.bankNameLabel addGestureRecognizer:tap];
}
-(void)labelClick:(UITapGestureRecognizer *)tap
{
    self.curPop = [KLCPopup popupWithContentView:self.bankChooseView];
    self.curPop.shouldDismissOnBackgroundTouch = YES;
    [self.curPop show];
}
- (void)createCollectionView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.BankListCollectionView registerNib:[UINib nibWithNibName:commonCellID bundle:nil] forCellWithReuseIdentifier:commonCellID];
    [self.BankListCollectionView registerNib:[UINib nibWithNibName:unconmmonCellID bundle:nil] forCellWithReuseIdentifier:unconmmonCellID];
    [self.BankListCollectionView registerNib:[UINib nibWithNibName:bankListHeaderCellId bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:bankListHeaderCellId];
}
//加载银行数据
-(void)loadBanksData{
    self.commonBankDataArr = [[NSMutableArray alloc]init];
    self.uncommonBankDataArr = [[NSMutableArray alloc]init];
    ServiceManager *manager = [ServiceManager sharedInstance];
    [manager getFunction:@"/account/withdraw/banks" params:nil attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        NSArray *ary = data[@"common_bank_list"];
        for (NSDictionary *dic in ary) {
            BankListModel *model = [[BankListModel alloc]init];
            model.bankNameStr = dic[@"bank_name"];
            model.idStr = dic[@"id"];
            [self.commonBankDataArr addObject:model];
        }
        NSArray *uncommenAry = data[@"uncommon_bank_list"];
        for (NSDictionary *dic in uncommenAry) {
            BankListModel *model = [[BankListModel alloc]init];
            model.bankNameStr = dic[@"bank_name"];
            model.idStr = dic[@"id"];
            [self.uncommonBankDataArr addObject:model];
        }
    } failActions:nil serviceFail:nil];
}
#pragma mark -collectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.commonBankDataArr.count;
        
    }else{
        return self.uncommonBankDataArr.count;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BankCardAddCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:commonCellID forIndexPath:indexPath];
        BankListModel *model = self.commonBankDataArr[indexPath.item];
        [cell showDataWithModel:model];
        return cell;
    }else{
        BankCardAddTextCell *textCell = [collectionView dequeueReusableCellWithReuseIdentifier:unconmmonCellID forIndexPath:indexPath];
        BankListModel *model = self.uncommonBankDataArr[indexPath.item];
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
    return CGSizeMake(self.BankListCollectionView.frame.size.width,30);
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
        BankListModel *model = (BankListModel *)self.commonBankDataArr[indexPath.item];
        self.bankNameLabel.text =model.bankNameStr;
        self.bankNameLabel.textColor = [TDColorUtil parse:@"#333333"];
        _bankId = model.idStr;
    }
    else{
        BankListModel *model = (BankListModel *)self.uncommonBankDataArr[indexPath.item];
        self.bankNameLabel.text =model.bankNameStr;
        self.bankNameLabel.textColor = [TDColorUtil parse:@"#333333"];
        _bankId = model.idStr;
    }
    [self.curPop dismiss:YES];
}

- (IBAction)identifyCodeAction:(id)sender {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
        [self.timer setFireDate:[NSDate distantPast]];
         self.second = 60;
}
-(void)timerFireMethod
{
    if (self.second == 1) {
        [self.timer invalidate];
        self.second = 60;
        self.securityCodeLabel.text = @"获取验证码";
        self.securityCodeLabel.layer.borderColor = [TDColorUtil parse:@"#E85524"].CGColor;
        self.securityCodeLabel.textColor = [TDColorUtil parse:@"#E85524"];
        self.secureityCodeBtn.userInteractionEnabled = YES;
        self.phoneNumTextField.userInteractionEnabled = YES;
    }else{
        self.second -- ;
        self.securityCodeLabel.text = [NSString stringWithFormat:@"%d 秒后重新获取",self.second];
        self.securityCodeLabel.layer.borderColor = [TDColorUtil parse:@"#BDBDBD"].CGColor;
        self.securityCodeLabel.textColor = [TDColorUtil parse:@"#BDBDBD"];
        self.secureityCodeBtn.userInteractionEnabled = NO;
        self.phoneNumTextField.userInteractionEnabled = NO;
    }
}
-(void)initWithAlertView:(NSString *)errMessage
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:errMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)textFieldChanged:(id)sender {
    UITextField *textField = sender;
    if (textField == self.phoneNumTextField) {
        if (textField.text.length ==11) {
            self.securityCodeLabel.layer.borderColor = [TDColorUtil parse:@"#E85524"].CGColor;
            self.securityCodeLabel.textColor = [TDColorUtil parse:@"#E85524"];
            self.secureityCodeBtn.userInteractionEnabled = YES;
        }else {
            self.securityCodeLabel.layer.borderColor = [TDColorUtil parse:@"#BDBDBD"].CGColor;
            self.securityCodeLabel.textColor = [TDColorUtil parse:@"#BDBDBD"];
            self.secureityCodeBtn.userInteractionEnabled = NO;
        }
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneNumTextField) {
        if (range.location>=11) {
            return NO;
        }else {
            return YES;
        }
    }else {
        return YES;
    }
}
- (IBAction)nextStepAction:(id)sender {
    if ([self.bankNameLabel.text isEqualToString:@"请选择开户行"]) {
        [self initWithAlertView:@"请输入开户行"];
    }else if (!self.IDTextField.text.length){
        [self initWithAlertView:@"请输入身份证号"];
    }else if (!self.phoneNumTextField.text.length){
        [self initWithAlertView:@"请输入手机号"];
    }else if (!self.securityTextField.text.length){
        [self initWithAlertView:@"请输入验证码"];
    }else {
        PasswordManagerController *vc = [[PasswordManagerController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
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
