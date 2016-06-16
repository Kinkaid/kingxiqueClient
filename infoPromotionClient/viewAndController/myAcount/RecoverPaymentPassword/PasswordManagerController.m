//
//  PasswordManagerController.m
//  infoPromotion
//
//  Created by imac on 15/9/24.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "PasswordManagerController.h"

@interface PasswordManagerController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *refinePassword;
@property (nonatomic) BOOL judgeUpBtn;
@property (nonatomic)BOOL judgeDownBtn;
- (IBAction)upEyeBtn:(id)sender;
- (IBAction)downEyeBtn:(id)sender;
@property (nonatomic,strong)UIAlertView *alert;
@end

@implementation PasswordManagerController

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
    [self initWithBackItem];
    [self initWithSet];
       // Do any additional setup after loading the view from its nib.
}
-(void)saveToServer:(NSString *)password{
    NSArray *viewArr = self.navigationController.viewControllers;
    [self.navigationController popToViewController:viewArr[1] animated:YES];
}
-(void)initWithBackItem
{
    self.title =@"设置支付密码";
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
-(void)initWithSet
{
    [TDApplicationUtil setWhiteNavigation:self.navigationController];
    [self.password becomeFirstResponder];
    [self.upBtn setImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateNormal];
    self.password.secureTextEntry = YES;
    [self.downBtn setImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateNormal];
    self.refinePassword.secureTextEntry =YES;
    self.judgeUpBtn = YES;
    self.judgeDownBtn = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -IBActions
- (IBAction)upEyeBtn:(id)sender {
    if (_judgeUpBtn == NO) {
        [self.upBtn setImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateNormal];
        self.password.secureTextEntry = YES;
        _judgeUpBtn = YES;
    }else{
        [self.upBtn setImage:[UIImage imageNamed:@"zhengyan"] forState:UIControlStateNormal];
        self.password.secureTextEntry = NO;
        _judgeUpBtn = NO;
    }
}

- (IBAction)downEyeBtn:(id)sender {
    if (_judgeDownBtn == NO) {
        [self.downBtn setImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateNormal];
        self.refinePassword.secureTextEntry = YES;
        _judgeDownBtn = YES;
    }else{
        [self.downBtn setImage:[UIImage imageNamed:@"zhengyan"] forState:UIControlStateNormal];
        self.refinePassword.secureTextEntry = NO;
        _judgeDownBtn = NO;
    }
}
- (IBAction)ensureAction:(id)sender {
    if ([self.password.text isEqualToString:self.refinePassword.text]) {
        [self saveToServer:self.password.text];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"两次密码不同" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark -- delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.alert) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}
@end
