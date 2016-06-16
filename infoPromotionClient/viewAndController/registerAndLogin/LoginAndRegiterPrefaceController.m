//
//  LoginAndRegiterPrefaceController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/22.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "LoginAndRegiterPrefaceController.h"
#import "BindOnAccountController.h"
#import "LoginController.h"
#import "RegisterController.h"
#import "TDWeixinUtil.h"
@interface LoginAndRegiterPrefaceController (){
    void(^_loginComplete)();
}

@end

@implementation LoginAndRegiterPrefaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加微信登录成功的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinLoginSuccess:) name:WEIXIN_AUTH_LOGIN_SUCCESS object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //临时
    [[NSUserDefaults standardUserDefaults]setObject:@"18530640571" forKey:@"mobile"];
    [[NSUserDefaults standardUserDefaults]setObject:@"刘金凯" forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//微信登陆
- (IBAction)weChatLoginAction:(id)sender {
    [TDWeixinUtil sendAuthLoginRequest];
}
#pragma mark -private
//微信登录成功回调
-(void)weixinLoginSuccess:(NSNotification *)notification{
    //    //移除通知
    //    [[NSNotificationCenter defaultCenter]removeObserver:self name:WEIXIN_AUTH_LOGIN_SUCCESS object:nil];
    NSDictionary *weixinData = notification.object;//通过微信登录后 返回的相关微信账号信息
    [self loginByWechat:weixinData];
}

//用微信登陆
-(void)loginByWechat:(NSDictionary *)weixinData
{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *paramas = @{@"user_name":weixinData[@"unionid"],@"reg_type":@(2),@"client_id":[[UIDevice currentDevice].identifierForVendor UUIDString],@"client_type":@(1),@"client_version":[UIDevice currentDevice].systemVersion,@"app_version":[NSString stringWithFormat:@"v%@",currentVersion]};
    ServiceManager *manager = [ServiceManager sharedInstance];
    [manager postFunction:@"/customer/login" params:paramas attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {//如果没有绑定手机号就先去绑定手机号
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",data[@"customer_id"]] forKey:@"customer_id"];
        [[NSUserDefaults standardUserDefaults]setObject:data[@"key"] forKey:@"key"];
        [[NSUserDefaults standardUserDefaults]setObject:data[@"mobile"] forKey:@"mobile"];
        [[NSUserDefaults standardUserDefaults]setObject:data[@"token"] forKey:@"token"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        if (data[@"mobile"]  == NULL ||[data[@"mobile"] length]==0) {
            NSLog(@"登陆成功未绑定手机号");
            BindOnAccountController *vc = [[BindOnAccountController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{//如果绑定过手机号那就离开此页面
            NSLog(@"登陆成功且已经绑定手机号");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failActions:@{@"-1":^(NSDictionary *responseObject, NSDictionary *data, NSString *msg){
    },@"-2":^(NSDictionary *responseObject, NSDictionary *data, NSString *msg){//如果登陆过程中检测到没有注册 那就去注册
        NSLog(@"未注册,去注册");
        [self registerByWechat:weixinData];
    }} serviceFail:nil];
}
-(void)registerByWechat:(NSDictionary *)weixinData
{
    ServiceManager *manager = [ServiceManager sharedInstance];
    NSDictionary *paramas1 =@{@"wechat_id":weixinData[@"unionid"],@"alias":weixinData[@"nickname"],@"avatar":weixinData[@"headimgurl"],@"province":weixinData[@"province"],@"country":weixinData[@"country"],@"city":weixinData[@"city"],@"gendor":@([weixinData[@"sex"] intValue]),@"app_openid":weixinData[@"openid"]};
    [manager postFunction:@"/customer/registByWechat" params:paramas1 attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {//注册成功之后紧接着就去登陆
        [[NSUserDefaults standardUserDefaults] setObject:data[@"customer_id"] forKey:@"customer_id"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        NSLog(@"注册成功,去登陆");
        [self loginByWechat:weixinData];
    } failActions:nil serviceFail:nil];
}
//手机号登陆
- (IBAction)phoneLoginAction:(id)sender {
    LoginController *vc = [[LoginController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//手机号注册
- (IBAction)phoneRegisterAction:(id)sender {
    RegisterController *vc = [[RegisterController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -private
-(void)loginComplete:(void(^)())complete{
    _loginComplete=complete;
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
