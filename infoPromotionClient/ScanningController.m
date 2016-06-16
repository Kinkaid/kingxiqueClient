//
//  ScanningController.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/15.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "ScanningController.h"
#import "ShopMainController.h"

@interface ScanningController ()<UIScrollViewDelegate>

@end

@implementation ScanningController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫码页面";
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scancodeAction:(id)sender {
    ShopMainController *ctrl = [[ShopMainController alloc] init];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
}


@end
