//
//  PayMainController.m
//  infoPromotionClient
//
//  Created by zhujingci on 16/3/3.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "PayMainController.h"

@interface PayMainController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
//点单按钮
@property (weak, nonatomic) IBOutlet UIButton *selectProductButton;
//直接买单按钮
@property (weak, nonatomic) IBOutlet UIButton *directPayButton;

@end

static CGFloat contentViewMarginTop = 164.0f;//内容View 到 屏幕顶部的距离

extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;

@implementation PayMainController{
    UIViewController *currentViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initChildViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Private
//初始化子页面
-(void)initChildViewController{
    SelectProductsController *selectProductCtrl = [[SelectProductsController alloc] init];
    selectProductCtrl.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-contentViewMarginTop);
    [self addChildViewController:selectProductCtrl];
    
    DirectPayController *directPayCtrl = [[DirectPayController alloc] init];
    directPayCtrl.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-contentViewMarginTop);
    [self addChildViewController:directPayCtrl];
    
    currentViewController = selectProductCtrl;
    
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-contentViewMarginTop);
    [self.contentView addSubview:selectProductCtrl.view];
    
}
//设置选中Button样式
-(void)setButtonSelectStyle:(UIButton *)selectButton{
    switch (selectButton.tag) {
        case 0:{
            [selectButton setImage:[UIImage imageNamed:@"selectproduct"] forState:UIControlStateNormal];
            [selectButton setTitleColor:[TDColorUtil parse:@"#EC5413"] forState:UIControlStateNormal];
            [self.directPayButton setImage:[UIImage imageNamed:@"mo-fukuan"] forState:UIControlStateNormal];
            [self.directPayButton setTitleColor:[TDColorUtil parse:@"#707070"] forState:UIControlStateNormal];
            break;
        }
        case 1:{
            [selectButton setImage:[UIImage imageNamed:@"fukuan"] forState:UIControlStateNormal];
            [selectButton setTitleColor:[TDColorUtil parse:@"#EC5413"] forState:UIControlStateNormal];
            [self.selectProductButton setImage:[UIImage imageNamed:@"mo-selectproduct"] forState:UIControlStateNormal];
            [self.selectProductButton setTitleColor:[TDColorUtil parse:@"#707070"] forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}
#pragma mark -IBActions
//选择"点单"还是"直接买单"
- (IBAction)selectTradeTypeAction:(id)sender {
    UIButton *selectButton = (UIButton *)sender;
    [self setButtonSelectStyle:selectButton];
    
    SelectProductsController *selectProductCtrl = [self.childViewControllers objectAtIndex:0];
    DirectPayController *directPayCtrl = [self.childViewControllers objectAtIndex:1];
    
    //选择当前页 则终止
    if ((currentViewController == selectProductCtrl&&selectButton.tag == 0)||
        (currentViewController == directPayCtrl&&selectButton.tag==1)) {
        return;
    }
    
    UIViewController *oldViewController = currentViewController;
    switch (selectButton.tag) {
        case 0:{
            [self transitionFromViewController:currentViewController toViewController:selectProductCtrl duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                if (finished) {
                    currentViewController = selectProductCtrl;
                }else{
                    currentViewController = oldViewController;
                }
            }];
            break;
        }
        case 1:{
            [self transitionFromViewController:currentViewController toViewController:directPayCtrl duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                if (finished) {
                    currentViewController = directPayCtrl;
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
