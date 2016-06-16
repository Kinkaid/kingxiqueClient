//
//  SelectShopController.m
//  infoPromotionClient
//
//  Created by imac on 15/12/31.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "SelectShopController.h"
#import "SelectShopCell.h"
#define cellId @"SelectShopCell"
@interface SelectShopController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SelectShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择店铺";
    [self initWithTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)initWithTableView
{
    [self.tableView registerNibByCellId:cellId];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
