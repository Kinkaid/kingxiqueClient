//
//  VIPCardUseMessageController.m
//  infoPromotionClient
//
//  Created by imac on 15/12/31.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "VIPCardUseMessageController.h"
#import "ConsumeRecoderController.h"
#import "WithdrawCardController.h"
#import "SelectShopController.h"
#import "VipcardOpenController.h"
#import "ShopMainController.h"

extern CGFloat SCREEN_WIDTH;
@interface VIPCardUseMessageController ()<UIAlertViewDelegate>
//卡内余额多少元
@property (weak, nonatomic) IBOutlet UILabel *cardBalanceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

//满多少充多少
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
//有效期
@property (weak, nonatomic) IBOutlet UILabel *validityLabel;
//开卡商铺
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
//联系电话
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
//适用门店
@property (weak, nonatomic) IBOutlet UILabel *availableShopCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *useRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *useSceneLabel;
@property (weak, nonatomic) IBOutlet UILabel *useLimitLabel;
@property (weak, nonatomic) IBOutlet UILabel *consumeLimitLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherStateLabel;


@end

@implementation VIPCardUseMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithItem];
    [self initWithBackItem];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)initWithBackItem
{
    self.title = self.titleStr;
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
-(void)initWithItem
{
    NSMutableArray *useNoticeArr = [[NSMutableArray alloc]initWithObjects:self.useRangeLabel.text,self.useSceneLabel.text,self.useLimitLabel.text,self.consumeLimitLabel.text,self.otherStateLabel.text,nil];
    CGFloat useNoticeHeight = 0;
    for (int i=0; i<useNoticeArr.count; i++) {
        useNoticeHeight +=[LJKHelper textHeightFromTextString:useNoticeArr[i] width:SCREEN_WIDTH-92 fontSize:13]>=16?[LJKHelper textHeightFromTextString:useNoticeArr[i] width:SCREEN_WIDTH-92 fontSize:13]:16;
    }
    self.contentViewHeight.constant = useNoticeHeight+571;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"jilu"] style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:@"余额 330.28 元"];
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:19],[TDColorUtil parse:@"#333333"],nil];
    [attributeStr setAttributes:attributeDict range:NSMakeRange(0, 2)];
    [attributeStr setAttributes:attributeDict range:NSMakeRange(attributeStr.length-1, 1)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(2, attributeStr.length-3)];
    self.cardBalanceLabel.attributedText = attributeStr;

}
-(void)rightClick
{
    ConsumeRecoderController *vc = [[ConsumeRecoderController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//再办一张
- (IBAction)activateCardAgainAction:(id)sender {
    VipcardOpenController *vc = [[VipcardOpenController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//买单
- (IBAction)payTheBillAction:(id)sender {
    ShopMainController *vc = [[ShopMainController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//开卡商铺
- (IBAction)activateCardShop:(id)sender {
}
//联系电话
- (IBAction)callAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"联系商家:%@",self.phoneNumLabel.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
//适用门店
- (IBAction)availableShopAction:(id)sender {
    SelectShopController *vc = [[SelectShopController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneNumLabel.text]]];
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
