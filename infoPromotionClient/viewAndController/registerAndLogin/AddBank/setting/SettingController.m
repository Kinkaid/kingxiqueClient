//
//  SettingController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/20.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "SettingController.h"
#import "LoginAndRegiterPrefaceController.h"
@interface SettingController ()

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.navigationController.navigationBar.translucent = YES;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
- (IBAction)switchAction:(id)sender {
    
}

- (IBAction)settingAction:(id)sender {
    UIButton *button = sender;
    if (button.tag == 1) {
        
    }else if (button.tag == 2){
        //清除图片缓存
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
            [[SDImageCache sharedImageCache]clearMemory];
            [TDApplicationUtil alertHud:[NSString stringWithFormat:@"已为您清除%.2fM缓存",[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0] afterDelay:1];
        }];
    }else if (button.tag == 3){
    
    }else if (button.tag == 4){
//        NSDictionary *paramas = @{@"customer_id":[TDUserDefaultsUtil getCustomerId],@"token":[TDUserDefaultsUtil getToken]};
//        ServiceManager *manager = [ServiceManager sharedInstance];
//        [manager postFunction:@"/customer/logout" params:paramas attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
//            [TDUserDefaultsUtil deleteUserDefaults];
//            LoginAndRegiterPrefaceController *vc = [[LoginAndRegiterPrefaceController alloc]init];
//            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//            [nav addChildViewController:vc];
//            [self presentViewController:nav animated:YES completion:nil];
//        } failActions:nil serviceFail:nil];
        LoginAndRegiterPrefaceController *vc = [[LoginAndRegiterPrefaceController alloc]init];
                    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
                    [nav addChildViewController:vc];
                    [self presentViewController:nav animated:YES completion:nil];
        
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
