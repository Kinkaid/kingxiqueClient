//
//  RegisterController.m
//  infoPromotionClient
//
//  Created by imac on 16/1/26.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *identifyingCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgainTextField;
@property (weak, nonatomic) IBOutlet UIView *warningView;
@property (weak, nonatomic) IBOutlet UILabel *identifyingLabel;
@property (weak, nonatomic) IBOutlet UIControl *identifyingCodeBtn;


@property (strong,nonatomic)NSTimer *timer;
@property (nonatomic)int second;
@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.second = 60;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.hidden = YES;
     self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIButton *button = (UIButton *)[self.view viewWithTag:1];
    button.transform = CGAffineTransformMakeRotation(M_PI);
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//发送验证码
- (IBAction)identifyingCodeAction:(id)sender {
//    if (self.phoneNumTextField.text.length==11) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        [self.timer setFireDate:[NSDate distantPast]];
    ServiceManager *manager = [ServiceManager sharedInstance];
    NSDictionary *dic = @{@"mobile":self.phoneNumTextField.text};
    [manager postFunction:@"/customer/sendRegistSms" params:dic attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
    } failActions:nil serviceFail:nil];
    
//    }else{
//        [self initWithAlertView:@"输入手机号有误"];
//    }
}
-(void)timerFireMethod:(NSTimer *)theTimer
{
    if (self.second == 1) {
        [theTimer invalidate];
        self.second = 60;
        self.identifyingLabel.text=@"获取验证码";
        self.identifyingLabel.layer.borderColor = [TDColorUtil parse:@"#E85524"].CGColor;
        self.identifyingLabel.textColor = [TDColorUtil parse:@"#E85524"];
        self.phoneNumTextField.userInteractionEnabled =YES;
        self.identifyingCodeBtn.enabled = YES;
    }else{
        self.second--;
        self.identifyingLabel.text= [NSString stringWithFormat:@"%d 秒",self.second];
        self.identifyingLabel.layer.borderColor = [TDColorUtil parse:@"#4D4D4D"].CGColor;
        self.identifyingLabel.textColor = [TDColorUtil parse:@"#4D4D4D"];
        self.phoneNumTextField.userInteractionEnabled =NO;
        self.identifyingCodeBtn.enabled = NO;
    }
}
//确定 登陆成功需要销毁定时器
- (IBAction)confirmAction:(id)sender {
    if (!self.phoneNumTextField.text.length) {
        [self initWithAlertView:@"请输入手机号"];
    }else if (!self.identifyingCodeTextField.text.length){
        [self initWithAlertView:@"请输入验证码"];
    }else if (!self.passwordTextField.text.length){
        [self initWithAlertView:@"请输入密码"];
    }else if (!self.passwordAgainTextField.text.length){
        [self initWithAlertView:@"请再次输入密码"];
    }
    if (self.passwordAgainTextField.text.length&&self.passwordTextField.text.length) {
        if (![self.passwordTextField.text isEqualToString:self.passwordAgainTextField.text]) {
            self.warningView.hidden = NO;
        }else{
            ServiceManager *manager = [ServiceManager sharedInstance];
            NSDictionary *params = @{@"v_code":self.identifyingCodeTextField.text,@"mobile":self.phoneNumTextField.text,@"psw":self.passwordTextField.text};
            [manager postFunction:@"/customer/registByMobile" params:params attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
                [[NSUserDefaults standardUserDefaults] setObject:data[@"customer_id"] forKey:@"customer_id"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
            } failActions:nil serviceFail:nil];
            self.warningView.hidden = YES;
            
        }
    }
}
-(void)initWithAlertView:(NSString *)alertViewStr
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:alertViewStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if (textField ==self.phoneNumTextField) {
        if (range.location>=11) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}
- (IBAction)phoneNumTextFieldChanged:(id)sender {
    UITextField *textField = sender;
    if (textField == self.phoneNumTextField) {
        if (textField.text.length ==11) {
            self.identifyingLabel.layer.borderColor = [TDColorUtil parse:@"#E85524"].CGColor;
            self.identifyingLabel.textColor = [TDColorUtil parse:@"#E85524"];
            self.identifyingCodeBtn.userInteractionEnabled = YES;
        }else {
            self.identifyingLabel.layer.borderColor = [TDColorUtil parse:@"#BDBDBD"].CGColor;
            self.identifyingLabel.textColor = [TDColorUtil parse:@"#BDBDBD"];
            self.identifyingCodeBtn.userInteractionEnabled = NO;
        }
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
