//
//  LoginController.m
//  infoPromotionClient
//
//  Created by imac on 16/1/26.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
#import "BindOnAccountController.h"
#import "TDWeixinUtil.h"
@interface LoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *eyesBtn;
@property (nonatomic)int i;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"手机号登陆";
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}


#pragma mark -IBActions
//密码显示与否
- (IBAction)eyesAction:(id)sender {
    if (self.eyesBtn.selected) {
        self.eyesBtn.selected = NO;
        self.passwordTextField.secureTextEntry = YES;
        [self.eyesBtn setImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateNormal];
    }else{
        self.eyesBtn.selected = YES;
        self.passwordTextField.secureTextEntry = NO;
        [self.eyesBtn setImage:[UIImage imageNamed:@"zhengyan"] forState:UIControlStateNormal];
    }
    
}

//忘记密码
- (IBAction)forgetPasswordAction:(id)sender {
  
}
//登陆
- (IBAction)loginAction:(id)sender {
//    if (!self.phoneNumTextField.text.length) {
//        [self initWithAlertView:@"请输入手机号码"];
//    }else if (!self.passwordTextField.text.length){
//        [self initWithAlertView:@"请输入密码"];
//    }else{
//        //app版本
//        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//        NSDictionary *paramas = @{@"user_name":self.phoneNumTextField.text,@"psw":self.passwordTextField.text,@"reg_type":@(1),@"client_id":[[UIDevice currentDevice].identifierForVendor UUIDString],@"client_type":@(1),@"client_version":[UIDevice currentDevice].systemVersion,@"app_version":[NSString stringWithFormat:@"v%@",currentVersion]};
//        ServiceManager *manager = [ServiceManager sharedInstance];
//        [manager postFunction:@"/customer/login" params:paramas attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
//            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",data[@"customer_id"]] forKey:@"customer_id"];
//            [[NSUserDefaults standardUserDefaults]setObject:data[@"key"] forKey:@"key"];
//            [[NSUserDefaults standardUserDefaults]setObject:data[@"mobile"] forKey:@"mobile"];
//            [[NSUserDefaults standardUserDefaults]setObject:data[@"token"] forKey:@"token"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            [self dismissViewControllerAnimated:YES completion:nil];
//
//        } failActions:@{@"-1":^(NSDictionary *responseObject, NSDictionary *data, NSString *msg){
//        }} serviceFail:nil];
//    }
     [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)initWithAlertView:(NSString *)alertViewStr
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:alertViewStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
#pragma mark - textFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.passwordTextField) {

        return YES;
    }else {
        if (range.location>10) {
            return NO;
        }else{
            return YES;
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!self.passwordTextField.text.length) {
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
