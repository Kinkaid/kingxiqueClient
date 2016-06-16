//
//  ConsumeRecoderController.m
//  infoPromotionClient
//
//  Created by imac on 15/12/31.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "ConsumeRecoderController.h"
#import "ConsumeRecoderCell.h"
#define cellId @"ConsumeRecoderCell"
@interface ConsumeRecoderController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ConsumeRecoderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBackItem];
    [self initWithTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)initWithTableView
{
    [self.tableView registerNibByCellId:cellId];
    
}
-(void)initWithBackItem
{
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"消费记录";
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsumeRecoderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
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
