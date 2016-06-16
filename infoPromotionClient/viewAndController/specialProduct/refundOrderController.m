//
//  refundOrderController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/23.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "refundOrderController.h"
#import "refundOrderCodeCell.h"
#import "RefundOrderReasonCell.h"
#define codeId @"refundOrderCodeCell"
#define reasonId @"RefundOrderReasonCell"
@interface refundOrderController ()<UITableViewDataSource,UITableViewDelegate,RefundCodeOrReasonDelegate,OtherReasonTextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *refundMoneyLabel;

@property (nonatomic,strong)NSMutableArray *codeArr;
@property (nonatomic,strong)NSMutableArray *reasonArr;

//判断是否选中
@property (nonatomic,strong)NSMutableArray *ifSelectedArr;
@property (nonatomic,strong)NSString *otherReasonStr;
@end

@implementation refundOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithTableView];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initWithTableView
{
    self.title = @"申请退单";
    [self.tableView registerNib:[UINib nibWithNibName:codeId bundle:nil] forCellReuseIdentifier:codeId];
    [self.tableView registerNibByCellId:reasonId];
}
-(void)loadData
{
    self.codeArr = [[NSMutableArray alloc]initWithObjects:@"1102 2103 210",@"1102 2103 211",@"1102 2103 212", nil];
    self.reasonArr = [[NSMutableArray alloc]initWithObjects:@"与商家协商一致退款",@"买多了/买错了",@"预约不上",@"计划有变,没时间消费",@"拍错了,不想要了", nil];
    self.ifSelectedArr = [[NSMutableArray alloc]initWithObjects:@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO), nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.codeArr.count;
    }else if(section == 1){
        return self.reasonArr.count;
    }else{
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [self addHeaderView:@"    验证码"];
    }else if(section == 1){
        return [self addHeaderView:@"    退款原因"];
    }else{
        return [self addHeaderView:@"    退款说明"];
    }
}
-(UIView *)addHeaderView:(NSString *)headerName
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    headerView.backgroundColor = [TDColorUtil parse:@"#F5F5F5"];
    UILabel *reasonLabel = [[UILabel alloc]initWithFrame:headerView.frame];
    reasonLabel.textColor = [TDColorUtil parse:@"#808080"];
    reasonLabel.text =headerName;
    reasonLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:reasonLabel];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 46;
    }else if(indexPath.section == 1){
        return 40;
    }else{
        return 148;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section !=2) {
        refundOrderCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:codeId forIndexPath:indexPath];
        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            cell.codeOrReasonLabel.text = self.codeArr[indexPath.row];
            if ([self.ifSelectedArr[indexPath.row] boolValue]==YES) {
                [cell.selectedBtn setImage:[UIImage imageNamed:@"refundOrder_selected"] forState:UIControlStateNormal];
            }else{
               [cell.selectedBtn setImage:[UIImage imageNamed:@"refundOrder_unselected"] forState:UIControlStateNormal];
            }
        }else{
            cell.codeOrReasonLabel.text = self.reasonArr[indexPath.row];
            if ([self.ifSelectedArr[indexPath.row+3] boolValue]==YES) {
                [cell.selectedBtn setImage:[UIImage imageNamed:@"refundOrder_selected"] forState:UIControlStateNormal];
            }else{
                [cell.selectedBtn setImage:[UIImage imageNamed:@"refundOrder_unselected"] forState:UIControlStateNormal];
            }

        }
        return cell;
    }else{
        RefundOrderReasonCell *reasonCell = [tableView dequeueReusableCellWithIdentifier:reasonId forIndexPath:indexPath];
        reasonCell.selectionStyle = UITableViewCellSelectionStyleNone;
        reasonCell.delegate = self;
        return reasonCell;
    }
}
-(void)codeOrReasonSelectedWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.ifSelectedArr[indexPath.row] boolValue] ==YES) {
            [self.ifSelectedArr replaceObjectAtIndex:indexPath.row withObject:@(NO)];
        }else{
         [self.ifSelectedArr replaceObjectAtIndex:indexPath.row withObject:@(YES)];
        }
    }else if(indexPath.section == 1){
        if ([self.ifSelectedArr[indexPath.row+3] boolValue] ==YES) {
//            [self.ifSelectedArr replaceObjectAtIndex:indexPath.row+3 withObject:@(NO)];
        }else{
            for (int i=3; i<8; i++) {
                if (i==indexPath.row+3) {
                    [self.ifSelectedArr replaceObjectAtIndex:i withObject:@(YES)];
                }else{
                    [self.ifSelectedArr replaceObjectAtIndex:i withObject:@(NO)];
                }
            }
        }
    }
    [self.tableView reloadData];
}
//申请退款
- (IBAction)refundAction:(id)sender {
    
    
}

-(void)otherReasonTextView:(UITextView *)textView
{
    self.otherReasonStr = textView.text;
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
