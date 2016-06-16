//
//  MainTabBarController.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/15.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "MainTabBarController.h"
#import "VIPController.h"
#import "ServiceController.h"
#import "ScanningController.h"
#import "CollectionController.h"
#import "MyAccountController.h"
#import "LoginController.h"
@interface MainTabBarController ()
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong)UIImageView *tabBarImageView;
@property (nonatomic, strong) UIButton *lastSelectButton;
@property (nonatomic, strong) UILabel *lastHightlightedLabel;
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar removeFromSuperview];
    VIPController *vc1 = [[VIPController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    [TDApplicationUtil setMainNavigation:nav1];
    
    ServiceController *vc2 = [[ServiceController alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    [TDApplicationUtil setMainNavigation:nav2];
    
    ScanningController *vc3 = [[ScanningController alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    [TDApplicationUtil setMainNavigation:nav3];
    
    CollectionController *vc4 = [[CollectionController alloc]init];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:vc4];
    [TDApplicationUtil setMainNavigation:nav4];
    
    MyAccountController *vc5 = [[MyAccountController alloc]init];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:vc5];
    [TDApplicationUtil setMainNavigation:nav5];
    
    self.viewControllers = @[nav1,nav3,nav5];
    [self addCustomTabBar];
    self.lastSelectButton = (UIButton *)[self.view viewWithTag:101];
    self.lastHightlightedLabel = (UILabel *)[self.view viewWithTag:201];
}

- (void)setLastHightlightedLabel:(UILabel *)lastHightlightedLabel
{
    if (_lastHightlightedLabel == lastHightlightedLabel) {
        return;
    }
    _lastHightlightedLabel.textColor = [UIColor darkGrayColor];
    _lastHightlightedLabel = lastHightlightedLabel;
}
- (void)setLastSelectButton:(UIButton *)lastSelectButton {
    if (_lastSelectButton == lastSelectButton) {
        return;
    }
    _lastSelectButton.selected = NO;
    _lastSelectButton = lastSelectButton;
    _lastSelectButton.selected = YES;
}
-(void)addCustomTabBar
{
    _tabBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    _tabBarImageView.userInteractionEnabled = YES;
    _tabBarImageView.image = [UIImage imageNamed:@"tabBarBackground"];
    NSArray *imageNames = @[@"icon-tabbar-1", @"icon-tabbar-3", @"icon-tabbar-5"];
    NSArray *selectedNames = @[@"icon-tabbar-1-sel", @"icon-tabbar-3", @"icon-tabbar-5-sel"];
    NSArray *titles = @[@"精选",@"",@"我"];
    CGFloat width = _tabBarImageView.frame.size.width/3.0;
    for (int i = 0; i<3; i++) {
        if (i==1) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-25,-19, 50, 45)];
            imageView.userInteractionEnabled = YES;
            imageView.image = [UIImage imageNamed:imageNames[i]];
            UIControl *button = [[UIControl alloc]initWithFrame:CGRectMake(0,0, 50, 45)];
            [imageView addSubview:button];
            button.tag = 101+i;
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame = CGRectMake(self.view.frame.size.width/2-20,-18, 50, 45);
//            [button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal]; // 普通图片
//            [button setBackgroundImage:[UIImage imageNamed:selectedNames[i]] forState:UIControlStateSelected]; // 选中时图片
//            [button setBackgroundImage:[UIImage imageNamed:selectedNames[i]] forState:UIControlStateHighlighted];
            [_tabBarImageView addSubview:imageView];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(i*width, 0,width, 40);
            [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];//普通图片
            [button setImage:[UIImage imageNamed:selectedNames[i]] forState:UIControlStateSelected];//选中时的图片
            [_tabBarImageView addSubview:button];
            button.tag = 101+i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            CGRect frame = button.frame;
            frame.origin.y = CGRectGetMaxY(frame)-6;
            frame.size.height = 49 - frame.size.height ;
            UILabel *label = [[UILabel alloc] initWithFrame:frame];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:12.0];
            label.textColor = [UIColor darkGrayColor];
            if (i==0) {
                label.textColor = [TDColorUtil parse:@"#E85524"];
            }
            label.tag = 201 + i;
            [_tabBarImageView addSubview:label];
            label.text = titles[i];
        }
    }
    [self.view addSubview:_tabBarImageView];
}
-(void)buttonClick:(UIButton *)button
{
    self.lastSelectButton = button;
    self.lastHightlightedLabel = (UILabel *)[self.view viewWithTag:button.tag + 100];
    self.lastHightlightedLabel.textColor = [TDColorUtil parse:@"#E85524"];
    // 切换到相应的视图控制器
    self.selectedIndex = button.tag - 101;
}
-(void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed{
    
    _tabBarImageView.hidden = hidesBottomBarWhenPushed;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
