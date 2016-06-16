//
//  AddBankCardController.m
//  infoPromotion
//
//  Created by imac on 15/9/22.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "AddBankCardController.h"
#import "ESCameraViewController.h"
#import "ESEditViewController.h"
#import "BankCardAddController.h"
#import "RecoverPaymentPasswordMiddleStepController.h"
@interface AddBankCardController ()<ESCameraDelegate,ESEditDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bankCardOwner;
@property (weak, nonatomic) IBOutlet UITextField *bankCardNum;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, retain) UIImage *img;
- (IBAction)cameraClick:(id)sender;
- (IBAction)nextStepClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@end

@implementation AddBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBackItem];
    [self initWithTextField];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
-(void)initWithTextField
{
    self.bankCardNum.delegate = self;
    [self.bankCardNum addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventAllEditingEvents];
    self.nextStepBtn.backgroundColor =[TDColorUtil parse:@"#BDBDBD"];
    self.nextStepBtn.userInteractionEnabled = NO;
}
-(void)initWithBackItem
{
    self.navigationItem.title = @"添加银行卡";
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)valueChange:(UITextField *)textField
{
    if (self.bankCardNum.text.length) {
        self.nextStepBtn.userInteractionEnabled = YES;
        self.nextStepBtn.backgroundColor = [TDColorUtil parse:@"#EC5413"];
    }else {
        self.nextStepBtn.userInteractionEnabled =NO;
        self.nextStepBtn.backgroundColor = [TDColorUtil parse:@"#BDBDBD"];
    }
}
#pragma mark -private
-(void)checkCard:(NSString *)cardNum AndName:(NSString *)nameStr;
{
    int oddSum = 0;
    int evenSum = 0;
    int allSum = 0;
    NSMutableString *cardStr = [[NSMutableString alloc]init];
    for (NSInteger i=cardNum.length-1; i>=0; i--) {
        NSString *tmpString = [cardNum substringWithRange:NSMakeRange(i, 1)];
        [cardStr appendString:tmpString];
    }
    for (NSInteger j=0; j<cardStr.length; j++) {
        NSString *Str = [cardStr substringWithRange:NSMakeRange(j, 1)];
        int tmpVal = [Str intValue];
        if ((j%2)!=0) {
            tmpVal *=2;
            if (tmpVal>=10) {
                tmpVal-=9;
            }
            oddSum += tmpVal;
        }else{
            evenSum +=tmpVal;
        }
    }
    allSum = oddSum + evenSum;
    if ((allSum%10)==0&&[nameStr length]!=0) {
        if (self.forgetPaymentPassword == YES) {
            RecoverPaymentPasswordMiddleStepController *vc = [[RecoverPaymentPasswordMiddleStepController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
        BankCardAddController *message = [[BankCardAddController alloc]init];
        message.bankCardNum = self.bankCardNum.text;
        message.bankCardOwner = self.bankCardOwner.text;
        [message.bankCardAddDic setObject:self.bankCardNum.text forKey:@"bankCardNum"];
        [message.bankCardAddDic setObject:self.bankCardOwner.text forKey:@"bankCardOwner"];
        [self.navigationController pushViewController:message animated:YES];
        self.bankCardNum.text = nil;
        }
    }else{
        if ((allSum%10)!=0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"银行卡号输入有误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入持卡人姓名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
}
#pragma mark -ESCameraDelegate
-(void)didEndRecWithResult:(NSString *)strResult image:(UIImage *)img from:(id)sender
{
    UIViewController *vc = (UIViewController*)sender;
    
    //    [vc dismissViewControllerAnimated:NO completion:^(){
    if(strResult != nil)
    {
        ESEditViewController *editVc = [[ESEditViewController alloc] init];
        editVc.str = strResult;
        editVc.img = img;
        editVc.delegate = self;
        self.str = strResult;
        self.img = img;
        //        [self presentViewController:editVc animated:YES completion:nil];
        [vc.navigationController pushViewController:editVc animated:YES];
    }
    //     }];

}
#pragma mark -ESEditDelegate
-(void)didBackfrom:(id)sender
{
    UIViewController *vc = (UIViewController*)sender;
    [vc.navigationController popViewControllerAnimated:NO];
}
-(void)didEndEdit:(NSString*)str from:(id)sender
{
    [self.navigationController popToViewController:self animated:YES];
    self.bankCardNum.text = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (self.bankCardNum.text.length) {
        self.nextStepBtn.backgroundColor = [TDColorUtil parse:@"#EC5413"];
        self.nextStepBtn.userInteractionEnabled = YES;
    }
}

#pragma mark -IBActions
- (IBAction)cameraClick:(id)sender {
    [self resignFirstResponder];
    ESCameraViewController *esVc = [[ESCameraViewController alloc] init];
    esVc.delegate = self;
    [self.navigationController pushViewController:esVc animated:YES];
}

- (IBAction)nextStepClick:(id)sender {
    [self checkCard:self.bankCardNum.text AndName:self.bankCardOwner.text];
}

@end
