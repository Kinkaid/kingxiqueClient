//
//  ServiceController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/29.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "ServiceController.h"

@interface ServiceController ()
@end

@implementation ServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务页面";
    [self initWithItem];
}

-(void)initWithItem
{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
