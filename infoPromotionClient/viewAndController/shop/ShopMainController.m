//
//  ShopMainController.m
//  infoPromotionClient
//
//  Created by zhujingci on 16/3/2.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "ShopMainController.h"
#import "shopSettingController.h"
@interface ShopMainController ()

@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;

static CGFloat contentViewMarginTop = 114.0f;//内容View 到 屏幕顶部的距离

@implementation ShopMainController{
    UIViewController *currentViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNav];
    [self initSegmentControl];
    [self initChildViewControllers];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)initWithNav
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shezhi"] style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
}
-(void)rightClick
{
    shopSettingController *vc = [[shopSettingController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -private
-(void)initSegmentControl{
    self.segmentControl.sectionTitles = @[@"买单",@"本店优惠圈",@"店铺"];
    self.segmentControl.font = [UIFont systemFontOfSize:18.0];
    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentControl.selectedTextColor = [TDColorUtil parse:@"#EC5413"];
    self.segmentControl.selectionIndicatorColor = [TDColorUtil parse:@"#EC5413"];
    self.segmentControl.selectionIndicatorHeight = 2.0f;
}
-(void)initChildViewControllers{
    PayMainController *payCtrl = [[PayMainController alloc] init];
    payCtrl.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-contentViewMarginTop);
    [self addChildViewController:payCtrl];
    
    ShopCouponCircleController *circleCtrl = [[ShopCouponCircleController alloc] init];
    circleCtrl.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-contentViewMarginTop);
    [self addChildViewController:circleCtrl];
    
    ShopInfoController *shopInfoCtrl = [[ShopInfoController alloc] init];
    shopInfoCtrl.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-contentViewMarginTop);
    [self addChildViewController:shopInfoCtrl];
    
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-contentViewMarginTop);
    if (self.checkShopInfo == YES) {
        [self.contentView addSubview:shopInfoCtrl.view];
        currentViewController = shopInfoCtrl;
        self.segmentControl.selectedSegmentIndex = 2;
    }else{
        [self.contentView addSubview:payCtrl.view];
        currentViewController = payCtrl;
    }
}

#pragma mark -IBActions
//切换“买单”,“本店优惠圈”,"店铺"
- (IBAction)segmentAction:(id)sender {
    NSInteger selectIndex = self.segmentControl.selectedSegmentIndex;
    PayMainController *payCtrl = [self.childViewControllers objectAtIndex:0];
    ShopCouponCircleController *circleCtrl = [self.childViewControllers objectAtIndex:1];
    ShopInfoController *shopInfoCtrl = [self.childViewControllers objectAtIndex:2];
    
    UIViewController *oldViewController = currentViewController;
    
    switch (selectIndex) {
        case 0:{
            [self transitionFromViewController:currentViewController toViewController:payCtrl duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                if (finished) {
                    currentViewController = payCtrl;
                }else{
                    currentViewController = oldViewController;
                }
            }];
             break;
        }
        case 1:{
            [self transitionFromViewController:currentViewController toViewController:circleCtrl duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                if (finished) {
                    currentViewController = circleCtrl;
                }else{
                    currentViewController = oldViewController;
                }
            }];
            break;
        }
        case 2:{
            [self transitionFromViewController:currentViewController toViewController:shopInfoCtrl duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                if (finished) {
                    currentViewController = shopInfoCtrl;
                }else{
                    currentViewController = oldViewController;
                }
                
            }];
            break;
        }
        default:
            break;
    }
    
    
}


@end
