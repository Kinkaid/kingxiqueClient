//
//  BillController.m
//  infoPromotion
//
//  Created by zhujingci on 15/6/12.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "BillController.h"
#import "HMSegmentedControl.h"
#import "BillCell.h"

@interface BillController ()<UITableViewDelegate,UITableViewDataSource>

@end
static NSString *cellId = @"BillCell";
static int billPage = 1;//页码，从1开始
static int limit = 20;
@implementation BillController{
    
    __weak IBOutlet HMSegmentedControl *_tabBar;
    
    __weak IBOutlet UITableView *_billTable;
    
    NSMutableArray *_operations;
    NSMutableArray *_monthlyOperations;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    
    self.title = @"账单";
    
    _tabBar.sectionTitles=@[@"全部",@"充值",@"转出",@"消费",@"补贴",@"推广撤单"];
    _tabBar.segmentEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tabBar.textColor=[UIColor darkGrayColor];
    _tabBar.font = [UIFont systemFontOfSize:15.0];
    _tabBar.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _tabBar.selectionIndicatorHeight = 3.0f;
    _tabBar.selectionIndicatorColor=[UIColor orangeColor];
    
    _billTable.delegate = self;
    _billTable.dataSource = self;
    [_billTable registerNibByCellId:cellId];
    
    _operations = [[NSMutableArray alloc]init];
    _monthlyOperations = [[NSMutableArray alloc]init];
    
    billPage = 1;
//    [self loadTableData];
    //下拉刷新
    [_billTable addLegendHeaderWithRefreshingBlock:^{
        billPage = 1;
        [weakSelf loadTableData];
    }];
    //上拉加载
    [_billTable addLegendFooterWithRefreshingBlock:^{
        billPage++;
        [weakSelf loadTableData];
    }];
}

- (IBAction)tabbarValueChangedAction:(HMSegmentedControl *)sender {
//    [_billTable.legendHeader beginRefreshing];
//    [self loadTableData];
}
-(void)loadTableData{
    ServiceManager *manager = [ServiceManager sharedInstance];
    NSDictionary *params = @{@"shop_id":[TDUserDefaultsUtil getShopId],@"limit":[[NSNumber alloc]initWithInt:limit],@"page":[[NSNumber alloc]initWithInt:billPage],@"opt_type":[[NSNumber alloc]initWithInt:[self getBilltype]]};
    [manager getFunction:@"/account/opts" params:params attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        NSArray *dataArray = data[@"opts"];
        
        if (billPage>1) {
            [_operations addObjectsFromArray:dataArray];
        }else{
            _operations =[[NSMutableArray alloc] initWithArray:dataArray];
        }
        [self getMonthlyOperations];
        [_billTable reloadData];
        [_billTable.header endRefreshing];
        [_billTable.footer endRefreshing];
        if (dataArray.count==0) {//已全部加载完毕
            _billTable.footer.state = MJRefreshFooterStateNoMoreData;
        }
    } failActions:nil serviceFail:nil];
}
-(int)getBilltype{
    int billType = 0;
    switch (_tabBar.selectedSegmentIndex) {
        case 1:
            billType = CsBillTypeIsChongzhi;
            break;
        case 2:
            billType = CsBillTypeIsTixian;
            break;
        case 3:
            billType = CsBillTypeIsFuwuxiaofei;
            break;
        case 4:
            billType = CsBillTypeIsJiangli;
            break;
        case 5:
            billType = CsBillTypeIsFuwutuikuan;
            break;
        default:
            break;
    }
    return billType;
}
- (void)getMonthlyOperations{
    _monthlyOperations = [[NSMutableArray alloc]init];
    NSMutableArray *monthArray = [[NSMutableArray alloc]init];//记录单月账单的array
    NSString *lastMonth = @"";//记录上一条数据的月份信息
    for (NSDictionary *operation in _operations) {
        NSString *month =[TDDataUtil parseRemoteDataToDateString:operation[@"create_time"] withFormatterString:@"MM"];
        if ([month isEqualToString:lastMonth]) {//与上条数据的月份相等，与上条数据归并
            [monthArray addObject:operation];
        }else{//否则将之前的array装入totalArray
            if (monthArray.count>0) {
                NSMutableDictionary *totalDic = [[NSMutableDictionary alloc]init];
                [totalDic setValue:lastMonth forKey:@"month"];
                [totalDic setObject:monthArray forKey:@"monthOperations"];
                [_monthlyOperations addObject:totalDic];
            }
            monthArray = [[NSMutableArray alloc]init];
            [monthArray addObject:operation];
        }
        
        lastMonth = month;//重置上一条数据的月份信息
    }
    if (monthArray.count>0) {
        NSMutableDictionary *totalDic = [[NSMutableDictionary alloc]init];
        [totalDic setValue:lastMonth forKey:@"month"];
        [totalDic setObject:monthArray forKey:@"monthOperations"];
        [_monthlyOperations addObject:totalDic];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *_monthOperations = _monthlyOperations[section][@"monthOperations"];
    return _monthOperations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BillCell *cell = [_billTable dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    NSDictionary *dic = _monthlyOperations[indexPath.section][@"monthOperations"][indexPath.row];
    cell.data = dic;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _monthlyOperations.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 25.0)];
    customView.backgroundColor = [TDColorUtil parse:@"#F2F2F6"];
    
    UILabel * headerLabel = [[UILabel alloc]init];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor darkGrayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 25.0);
    
    NSString *month = _monthlyOperations[section][@"month"];
    headerLabel.text =  [NSString stringWithFormat:@"%@月",month];
    
    [customView addSubview:headerLabel];
    
    return customView;
}
//设置SectionHeader高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0;
}

@end
