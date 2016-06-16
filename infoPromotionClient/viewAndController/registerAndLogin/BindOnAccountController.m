//
//  BindOnAccountController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/16.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "BindOnAccountController.h"

@interface BindOnAccountController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *identifyCodeTextField;
@property (weak, nonatomic) IBOutlet UILabel *identifyLabel;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic) int second;
@end

@implementation BindOnAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithItem];
    // Do any additional setup after loading the view from its nib.
}
-(void)initWithItem
{
    self.title = @"账号与安全";
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.navigationBar.hidden = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.identifyLabel addGestureRecognizer:tap];
}
-(void)tapClick
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
    [self.timer setFireDate:[NSDate distantPast]];
    self.second = 60;
}
-(void)timerFireMethod
{
    if (self.second == 1) {
        [self.timer invalidate];
        self.second = 60;
        self.identifyLabel.text = @"获取验证码";
        self.identifyLabel.layer.borderColor = [TDColorUtil parse:@"#E85524"].CGColor;
        self.identifyLabel.textColor = [TDColorUtil parse:@"#E85524"];
        self.phoneNumTextField.userInteractionEnabled =YES;
        self.identifyLabel.userInteractionEnabled = YES;
    }else{
        self.second -- ;
        self.identifyLabel.text = [NSString stringWithFormat:@"%d 秒",self.second];
        self.identifyLabel.layer.borderColor = [TDColorUtil parse:@"#B3B3B3"].CGColor;
        self.identifyLabel.textColor = [TDColorUtil parse:@"#4D4D4D"];
        self.phoneNumTextField.userInteractionEnabled = NO;
        self.identifyLabel.userInteractionEnabled = NO;
    }
}
- (IBAction)phoneNumTextFieldChanged:(id)sender {
    UITextField *textField = sender;
    if (textField == self.phoneNumTextField) {
        if (textField.text.length ==13) {
            self.identifyLabel.layer.borderColor = [TDColorUtil parse:@"#E85524"].CGColor;
            self.identifyLabel.textColor = [TDColorUtil parse:@"#E85524"];
            self.identifyLabel.userInteractionEnabled = YES;
        }else {
            self.identifyLabel.layer.borderColor = [TDColorUtil parse:@"#BDBDBD"].CGColor;
            self.identifyLabel.textColor = [TDColorUtil parse:@"#BDBDBD"];
            self.identifyLabel.userInteractionEnabled = NO;
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneNumTextField) {
        if (range.location>=13) {
            return NO;
        }else {
            if (textField.text.length == 3||textField.text.length==8) {
                textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
            }
            return YES;
        }
    }else {
        return YES;
    }
}
//确认登陆 需要销毁定时器
- (IBAction)confirmLoginAction:(id)sender {
//    if (self.phoneNumTextField.text.length!=13) {
//        [self initWithAlertView:@"请输入正确的手机号码"];
//    }else if (self.identifyCodeTextField.text.length==0){
//        [self initWithAlertView:@"请输入验证码"];
//    }else {
//    }
//    [[NSUserDefaults standardUserDefaults] setObject:@"18530640571" forKey:@"mobile"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)initWithAlertView:(NSString *)errMessage
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:errMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
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
