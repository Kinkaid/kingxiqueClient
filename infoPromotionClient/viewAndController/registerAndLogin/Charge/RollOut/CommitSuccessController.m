//
//  CommitSuccessController.m
//  infoPromotion
//
//  Created by imac on 15/10/29.
//  Copyright © 2015年 com.tgram.ios. All rights reserved.
//

#import "CommitSuccessController.h"
#import <KLCPopup/KLCPopup.h>
#import "DateChooseCell.h"
@interface CommitSuccessController ()<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *dateChooseView;
@property (weak, nonatomic) IBOutlet UITableView *dateChooseTableView;
@property KLCPopup *curPop;
@property int date;
@property (nonatomic,strong)UIImageView *dateAffirmImageView1;
@property (nonatomic,strong)UIImageView *dateAffirmImageView2;
@property (nonatomic,strong)UIImageView *dateAffirmImageView3;
@property (nonatomic,strong)UILabel *chooseLabel1;
@property (nonatomic,strong)UILabel *chooseLabel2;
@property (nonatomic,strong)UILabel *chooseLabel3;
@end

@implementation CommitSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dateChooseTableView registerNib:[UINib nibWithNibName:@"DateChooseCell" bundle:nil] forCellReuseIdentifier:@"DateChooseCell"];
    [TDApplicationUtil setWhiteNavigation:self.navigationController];
    self.title = @"转出";
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    self.date = 5;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openBtnAction:(id)sender {
    [self.dateChooseTableView registerNib:[UINib nibWithNibName:@"DateChooseCell" bundle:nil] forCellReuseIdentifier:@"DateChooseCell"];
    [self showDateChoosePop];
}
- (IBAction)ensureAutoRollout:(id)sender {
    ServiceManager *manager = [ServiceManager sharedInstance];
    NSDictionary *dict = @{@"shop_id":@"6736579794329406417",@"bankcard_id":@"5540262394748198644",@"day":@(self.date)};
    [manager postFunction:@"/account/withdraw/auto" params:dict attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"提示" message:@"定时自动转出功能已开启" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.delegate = self;
        [alert show];
        NSDictionary *dic = @{@"state":@(true),@"date":@(self.date),@"num":self.lastFourNum};
        [self.delegate carryDic:dic];
    } failActions:nil serviceFail:nil];
    [self hideDateChoosePop];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSArray *ary = self.navigationController.viewControllers;
    [self.navigationController popToViewController:ary[1] animated:YES];
}
- (IBAction)realizeBtnAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)showDateChoosePop{
    self.curPop = [KLCPopup popupWithContentView:self.dateChooseView];
    [self.curPop show];
}
-(void)hideDateChoosePop{
    [self.curPop dismiss:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DateChooseCell *cell = [self.dateChooseTableView dequeueReusableCellWithIdentifier:@"DateChooseCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dateAffirmImageView.image = [UIImage imageNamed:@"bain"];
    if (indexPath.row == 0) {
        cell.dateAffirmImageView.image = [UIImage imageNamed:@"dagou"];
        cell.dateLabel.textColor = [TDColorUtil parse:@"#333333"];
        cell.dateLabel.text = @"每月5日";
        self.dateAffirmImageView1 = cell.dateAffirmImageView;
        self.chooseLabel1 = cell.dateLabel;
    }else if(indexPath.row == 1){
        cell.dateLabel.text = @"每月15日";
        self.dateAffirmImageView2 = cell.dateAffirmImageView;
        self.chooseLabel2 = cell.dateLabel;
    }else{
        cell.dateLabel.text = @"每月25日";
        self.dateAffirmImageView3 = cell.dateAffirmImageView;
        self.chooseLabel3 = cell.dateLabel;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        self.dateAffirmImageView1.image = [UIImage imageNamed:@"dagou"];
        self.dateAffirmImageView2.image = [UIImage imageNamed:@"bain"];
        self.dateAffirmImageView3.image = [UIImage imageNamed:@"bain"];

        self.chooseLabel1.textColor = [TDColorUtil parse:@"#333333"];
        self.chooseLabel2.textColor = [TDColorUtil parse:@"#A7A7A7"];
        self.chooseLabel3.textColor = [TDColorUtil parse:@"#A7A7A7"];
        self.date = 5;
    }else if (indexPath.row == 1){
        self.dateAffirmImageView2.image = [UIImage imageNamed:@"dagou"];
        self.dateAffirmImageView1.image = [UIImage imageNamed:@"bain"];
        self.dateAffirmImageView3.image = [UIImage imageNamed:@"bain"];
        self.chooseLabel2.textColor = [TDColorUtil parse:@"#333333"];
        self.chooseLabel1.textColor = [TDColorUtil parse:@"#A7A7A7"];
        self.chooseLabel3.textColor = [TDColorUtil parse:@"#A7A7A7"];
        self.date = 15;
    }else{
        self.dateAffirmImageView3.image = [UIImage imageNamed:@"dagou"];
        self.dateAffirmImageView2.image = [UIImage imageNamed:@"bain"];
        self.dateAffirmImageView1.image = [UIImage imageNamed:@"bain"];
        self.chooseLabel3.textColor = [TDColorUtil parse:@"#333333"];
        self.chooseLabel2.textColor = [TDColorUtil parse:@"#A7A7A7"];
        self.chooseLabel1.textColor = [TDColorUtil parse:@"#A7A7A7"];
        self.date = 25;
    }
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
