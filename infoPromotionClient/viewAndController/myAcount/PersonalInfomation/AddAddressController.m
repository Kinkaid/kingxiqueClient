//
//  AddAddressController.m
//  infoPromotionClient
//
//  Created by imac on 16/3/1.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "AddAddressController.h"
#import "AddAddressCell.h"
#import "EditorAddressController.h"
#define addAddressCellId @"AddAddressCell"
#define marginHeight @"48"
@interface AddAddressController ()<UITableViewDataSource,UITableViewDelegate,AddressEditorDelegate>
@property (weak, nonatomic) IBOutlet UITableView *addressTableView;
@property (nonatomic,strong)NSMutableArray *addressMessageArr;
@end

@implementation AddAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBackItem];
    // Do any additional setup after loading the view from its nib.
    [self loadAddressData];
    [self initWithTableView];
}
-(void)initWithBackItem
{
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
}

-(void)loadAddressData
{
    NSMutableDictionary *address1 = [[NSMutableDictionary alloc]initWithObjects:@[@"朱三峡",@"150 5812 4935",@"浙江省杭州市西湖区",@"莲花街莲花商务中心A座5楼七巧板",@(YES)] forKeys:@[@"name",@"phone",@"region",@"street",@"selected"]];
     NSMutableDictionary *address2 = [[NSMutableDictionary alloc]initWithObjects:@[@"朱四峡",@"150 5812 4935",@"浙江省杭州市西湖区",@"莲花街莲花商务中心A座6楼八巧板",@(NO)] forKeys:@[@"name",@"phone",@"region",@"street",@"selected"]];
    NSMutableDictionary *address3 = [[NSMutableDictionary alloc]initWithObjects:@[@"朱五峡",@"150 5812 4935",@"浙江省杭州市西湖区",@"莲花街莲花商务中心A座7楼九巧板",@(NO)] forKeys:@[@"name",@"phone",@"region",@"street",@"selected"]];
    self.addressMessageArr = [[NSMutableArray alloc]initWithObjects:address1,address2,address3,nil];
    [self.addressTableView reloadData];
}
-(void)initWithTableView
{
    self.title = @"新增地址";
    [self.addressTableView registerNibByCellId:addAddressCellId];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressMessageArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.addressMessageArr[indexPath.row][@"selected"]boolValue]==YES) {
        return [LJKHelper textHeightFromTextString:[NSString stringWithFormat:@"[默认]收货地址:%@%@",self.addressMessageArr[indexPath.row][@"region"],self.addressMessageArr[indexPath.row][@"street"]] width:self.view.frame.size.width-92 fontSize:11]+[marginHeight floatValue];
        
    }else{
        return [LJKHelper textHeightFromTextString:[NSString stringWithFormat:@"收货地址:%@%@",self.addressMessageArr[indexPath.row][@"region"],self.addressMessageArr[indexPath.row][@"street"]] width:self.view.frame.size.width-92 fontSize:11]+[marginHeight floatValue];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addAddressCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell showAddressMessageWithDic:self.addressMessageArr[indexPath.row]];
    cell.cellRow = indexPath.row;
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i=0; i<self.addressMessageArr.count; i++) {
        if (i==indexPath.row) {
           [self.addressMessageArr[i] setObject:@(YES) forKey:@"selected"];
        }else {
          [self.addressMessageArr[i] setObject:@(NO) forKey:@"selected"];
        }
    }
    [self.addressTableView reloadData];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([self.addressMessageArr[indexPath.row][@"selected"] boolValue]==YES) {
            [self.addressMessageArr removeObjectAtIndex:indexPath.row];
            if (self.addressMessageArr.count) {
            [self.addressMessageArr[0] setObject:@(YES) forKey:@"selected"];
            }
        }else {
           [self.addressMessageArr removeObjectAtIndex:indexPath.row];
        }
        
    }
    [self.addressTableView reloadData];
}

- (IBAction)addAddressAction:(id)sender {
    EditorAddressController *vc = [[EditorAddressController alloc]init];
    vc.isEditor = NO;
    [vc carryBlock:^(NSMutableDictionary *dic) {
        [self.addressMessageArr addObject:dic];
        if (self.addressMessageArr.count == 1) {
            [self.addressMessageArr[0] setObject:@(YES) forKey:@"selected"];
        }
        [self.addressTableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)editAddressWithCellId:(NSInteger)cellRow
{
    EditorAddressController*vc = [[EditorAddressController alloc]init];
    vc.isEditor = YES;
    vc.addressDic = self.addressMessageArr[cellRow];
    [vc carryBlock:^(NSMutableDictionary *dic) {
        [self.addressMessageArr replaceObjectAtIndex:cellRow withObject:dic];
        [self.addressTableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
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
