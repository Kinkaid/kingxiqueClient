//
//  CollectionController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/29.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "CollectionController.h"

@interface CollectionController ()

@end

@implementation CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏页面";
    // Do any additional setup after loading the view from its nib.
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
