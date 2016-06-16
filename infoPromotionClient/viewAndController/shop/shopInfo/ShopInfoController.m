//
//  ShopInfoController.m
//  infoPromotionClient
//
//  Created by zhujingci on 16/3/2.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "ShopInfoController.h"
#import "SpecialProductCommentController.h"
#import "MemberCardOfShopController.h"
#import "SpecialProductListController.h"
@interface ShopInfoController ()

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessHoursLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@end

@implementation ShopInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)callAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"拨打电话" message:self.phoneNumLabel.text delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *numStr = [self.phoneNumLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",numStr]]];
    }
}
//商家证照
- (IBAction)shopLicenseAction:(id)sender {
    
}
//店铺评价
- (IBAction)shopCommentAction:(id)sender {
    SpecialProductCommentController *vc = [[SpecialProductCommentController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)discountActivityAction:(id)sender {
}
- (IBAction)memberCardAction:(id)sender {
    MemberCardOfShopController *vc = [[MemberCardOfShopController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)discountCommodityAction:(id)sender {
    SpecialProductListController *vc = [[SpecialProductListController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
