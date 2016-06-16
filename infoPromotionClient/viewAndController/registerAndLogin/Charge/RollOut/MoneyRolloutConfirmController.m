//
//  MoneyRolloutConfirmController.m
//  infoPromotion
//
//  Created by imac on 15/9/25.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import "MoneyRolloutConfirmController.h"
#import <KLCPopup/KLCPopup.h>
#import "DateChooseCell.h"
#import "CommitSuccessController.h"
@interface MoneyRolloutConfirmController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardRegionLabel;

@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;

@property (strong,nonatomic)UIAlertView *autoRolloutAlert;
@property (strong, nonatomic) IBOutlet UIView *dateChooseView;
@property (weak, nonatomic) IBOutlet UIButton *affirmRolloutBtn;

- (IBAction)confirmBtnAction:(id)sender;


@property KLCPopup *curPop;
@property (weak, nonatomic) IBOutlet UITableView *dateTableView;

@property (nonatomic,strong)UIImageView *dateAffirmImageView1;
@property (nonatomic,strong)UIImageView *dateAffirmImageView2;
@property (nonatomic,strong)UIImageView *dateAffirmImageView3;
@property (nonatomic,strong)UILabel *chooseLabel1;
@property (nonatomic,strong)UILabel *chooseLabel2;
@property (nonatomic,strong)UILabel *chooseLabel3;
@property (nonatomic)int date;
- (IBAction)openBtn:(id)sender;
- (IBAction)affirmRolloutBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *rolloutMoney;

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *datePickerView;
@property (nonatomic,strong)NSArray *dateArr;

@property (nonatomic)int isNow;
@end

@implementation MoneyRolloutConfirmController
//友盟页面统计
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPickerView];
    self.title = @"转出";
    self.date = 5;
    [self createBankCardAffirmMessage];
    // Do any additional setup after loading the view from its nib.
}
-(void)setPickerView
{
    self.dateArr = [[NSArray alloc]init];
    [[ServiceManager sharedInstance] getFunction:@"/account/withdraw/rate" params:nil attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        NSDecimalNumber *rate = [TDDataUtil decimalNumberMutiplyWithString:data[@"rate"] multiplicandValue:@"100"];
        self.dateArr = @[[NSString stringWithFormat:@"即时到账(%@%%手续费)",rate ],@"次日24点前到账(免手续费)"];
        
    } failActions:nil serviceFail:nil];
    [self.datePickerView removeFromSuperview];
    self.dateTextField.inputView = self.datePickerView;
    self.dateTextField.delegate = self;
}
#pragma mark --UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dateArr.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  self.dateArr[row];
}

- (void)createBankCardAffirmMessage
{
    self.moneyLabel.text= self.money;
    self.nameLabel.text = self.data[@"owner_name"];
    self.cardNumLabel.text = self.data[@"card_no"];
    self.bankNameLabel.text = self.data[@"bank_name"];
    self.cardRegionLabel.text = [NSString stringWithFormat:@"%@ %@",self.data[@"province"],self.data[@"city"]];
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

- (IBAction)openBtn:(id)sender {
    [self.dateTableView registerNib:[UINib nibWithNibName:@"DateChooseCell" bundle:nil] forCellReuseIdentifier:@"DateChooseCell"];
    [self showDateChoosePop];

}

- (IBAction)affirmRolloutBtn:(id)sender {
    if ([self.rolloutMoney.text floatValue] == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"转出金额不能为0" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if ([self.rolloutMoney.text floatValue]>[self.money floatValue]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"转出金额不能大于余额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if(!self.dateTextField.text.length){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择到账时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];

    }else{
    ServiceManager *manager = [ServiceManager sharedInstance];
    NSDictionary *dict = @{@"shop_id":@"6736579794329406417",@"bankcard_id":@"5540262394748198644",@"change":[TDDataUtil parseStrPriceToParamPrice:self.rolloutMoney.text],@"des":self.remarkTextField.text,@"withdraw_type":@(self.isNow)};
    [manager postFunction:@"/account/withdraw" params:dict attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        CommitSuccessController *vc = [[CommitSuccessController alloc]init];
        vc.bankDic = self.data;
        NSArray *vcArr = self.navigationController.viewControllers;
        vc.delegate = vcArr[1];
        vc.lastFourNum = [self.cardNumLabel.text substringFromIndex:self.cardNumLabel.text.length-4];
        [self.navigationController pushViewController:vc animated:YES];
    } failActions:nil serviceFail:nil];
  }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.autoRolloutAlert) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
//    [self.navigationController popViewControllerAnimated:YES];
    
    }
}
-(void)carryValue:(carryBlock)myBlock
{
    self.myBlock = myBlock;
}

#pragma mark -private
-(void)showDateChoosePop{
    self.curPop = [KLCPopup popupWithContentView:self.dateChooseView];
    [self.curPop show];
}
-(void)hideDateChoosePop{
    [self.curPop dismiss:YES];
}
- (IBAction)confirmBtnAction:(id)sender {
        ServiceManager *manager = [ServiceManager sharedInstance];
    NSDictionary *dict = @{@"shop_id":@"6736579794329406417",@"bankcard_id":self.data[@"bankcard_id"],@"day":@(self.date)};
        [manager postFunction:@"/account/withdraw/auto" params:dict attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
            self.autoRolloutAlert= [[UIAlertView alloc]initWithTitle:@"提示" message:@"定时自动转出功能已开启" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [self.autoRolloutAlert show];
            self.myBlock(true,self.date,[self.cardNumLabel.text substringFromIndex:self.cardNumLabel.text.length-4]);
        } failActions:nil serviceFail:nil];
    [self hideDateChoosePop];
}
#pragma mark -- delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DateChooseCell *cell = [self.dateTableView dequeueReusableCellWithIdentifier:@"DateChooseCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dateAffirmImageView.image = [UIImage imageNamed:@"bain"];
    if (indexPath.row == 0) {
       cell.dateAffirmImageView.image = [UIImage imageNamed:@"dagou"];
       cell.dateLabel.textColor = [TDColorUtil parse:@"#333333"];
       cell.dateLabel.text = @"每月5日";
        self.dateAffirmImageView1 = cell.dateAffirmImageView;
        self.chooseLabel1 = cell.dateLabel;
    }else if(indexPath.row == 1){
        cell.dateLabel.text = @"每月15日";
        self.dateAffirmImageView2 = cell.dateAffirmImageView;
        self.chooseLabel2 = cell.dateLabel;
    }else{
        cell.dateLabel.text = @"每月25日";
        self.dateAffirmImageView3 = cell.dateAffirmImageView;
        self.chooseLabel3 = cell.dateLabel;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        self.dateAffirmImageView1.image = [UIImage imageNamed:@"dagou"];
        self.dateAffirmImageView2.image = [UIImage imageNamed:@"bain"];
        self.dateAffirmImageView3.image = [UIImage imageNamed:@"bain"];
       
        self.chooseLabel1.textColor = [TDColorUtil parse:@"#333333"];
        self.chooseLabel2.textColor = [TDColorUtil parse:@"#A7A7A7"];
        self.chooseLabel3.textColor = [TDColorUtil parse:@"#A7A7A7"];
        self.date = 5;
    }else if (indexPath.row == 1){
        self.dateAffirmImageView2.image = [UIImage imageNamed:@"dagou"];
        self.dateAffirmImageView1.image = [UIImage imageNamed:@"bain"];
        self.dateAffirmImageView3.image = [UIImage imageNamed:@"bain"];
        self.chooseLabel2.textColor = [TDColorUtil parse:@"#333333"];
        self.chooseLabel1.textColor = [TDColorUtil parse:@"#A7A7A7"];
        self.chooseLabel3.textColor = [TDColorUtil parse:@"#A7A7A7"];
         self.date = 15;
    }else{
        self.dateAffirmImageView3.image = [UIImage imageNamed:@"dagou"];
        self.dateAffirmImageView2.image = [UIImage imageNamed:@"bain"];
        self.dateAffirmImageView1.image = [UIImage imageNamed:@"bain"];
        self.chooseLabel3.textColor = [TDColorUtil parse:@"#333333"];
        self.chooseLabel2.textColor = [TDColorUtil parse:@"#A7A7A7"];
        self.chooseLabel1.textColor = [TDColorUtil parse:@"#A7A7A7"];
        self.date = 25;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
       return [TDApplicationUtil judgeDecimalTextFieldAllowInput:textField shouldChangeCharactersInRange:range replacementString:string decimalLimit:2];//只允许输入两位小数
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.dateTextField) {
        NSInteger ret = [self.datePickerView selectedRowInComponent:0];
        textField.text = self.dateArr[ret];
        if (ret == 0) {
            self.isNow = 2;
        }else {
            self.isNow =  1;
        }
    }
//    if (self.dateTextField.text.length&&self.rolloutMoney.text.length) {
//        self.affirmRolloutBtn.userInteractionEnabled = YES;
//        self.affirmRolloutBtn.backgroundColor = [TDColorUtil parse:@"#B03621"];
//    }else {
//        self.affirmRolloutBtn.userInteractionEnabled = NO;
//        self.affirmRolloutBtn.backgroundColor = [UIColor lightGrayColor];
//    }
}
@end
