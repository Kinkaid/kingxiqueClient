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
//#import "MessageOfBankController.h"
#import "BankCardAddController.h"
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
//友盟页面统计
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加银行卡";
    self.bankCardNum.delegate = self;
    [self.bankCardNum addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventAllEditingEvents];
    self.bankCardOwner.text = [TDUserDefaultsUtil getContactName];
    self.nextStepBtn.backgroundColor = [UIColor lightGrayColor];
    self.nextStepBtn.userInteractionEnabled = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)valueChange:(UITextField *)textField
{
    if (self.bankCardNum.text.length) {
        self.nextStepBtn.userInteractionEnabled = YES;
        self.nextStepBtn.backgroundColor = [TDColorUtil parse:@"#FF7F00"];
    }else {
        self.nextStepBtn.userInteractionEnabled =NO;
        self.nextStepBtn.backgroundColor = [UIColor lightGrayColor];
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
        BankCardAddController *message = [[BankCardAddController alloc]init];
        message.bankCardNum = self.bankCardNum.text;
        message.bankCardOwner = self.bankCardOwner.text;
        [message.bankCardAddDic setObject:self.bankCardNum.text forKey:@"bankCardNum"];
        [message.bankCardAddDic setObject:self.bankCardOwner.text forKey:@"bankCardOwner"];
        [self.navigationController pushViewController:message animated:YES];
        self.bankCardNum.text = nil;
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
        self.nextStepBtn.backgroundColor = [TDColorUtil parse:@"#FF7F00"];
        self.nextStepBtn.userInteractionEnabled = YES;
    }
}

#pragma mark -IBActions
- (IBAction)cameraClick:(id)sender {
    ESCameraViewController *esVc = [[ESCameraViewController alloc] init];
    esVc.delegate = self;
    [self.navigationController pushViewController:esVc animated:YES];
}

- (IBAction)nextStepClick:(id)sender {
    [self checkCard:self.bankCardNum.text AndName:self.bankCardOwner.text];
}

@end
