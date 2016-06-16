//
//  EditorAddressController.m
//  infoPromotionClient
//
//  Created by imac on 16/3/1.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "EditorAddressController.h"
@interface EditorAddressController ()<UITextFieldDelegate>
//<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
//姓名
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
//手机号
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
//街道
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
//邮编
@property (weak, nonatomic) IBOutlet UITextField *postCodeTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *regionPickerView;
//省市区
@property (weak, nonatomic) IBOutlet UITextField *regionInput;
@property (nonatomic,strong)NSMutableArray *regionList;

@end

@implementation EditorAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBackItem];
    [self setPickerView];
        // Do any additional setup after loading the view from its nib.
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
    if (self.isEditor == YES) {
        [self initWithAddressMessage];
        self.title = @"编辑地址";
    }else {
        self.title = @"新增地址";
    }
}
-(void)initWithAddressMessage
{
    self.nameTextField.text = self.addressDic[@"name"];
    self.phoneTextField.text = self.addressDic[@"phone"];
    self.regionInput.text = self.addressDic[@"region"];
    self.streetTextField.text = self.addressDic[@"street"];
}
-(void)setPickerView
{
    [self.regionPickerView removeFromSuperview];
//    self.regionInput.inputView = self.regionPickerView;
    self.regionList = [[NSMutableArray alloc]init];
//    [self loadData];
}
-(void)loadData
{
    ServiceManager *manager = [ServiceManager sharedInstance];
    [manager getFunction:@"/system/xzqh" params:nil attributes:nil success:^(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) {
        _regionList = data[@"xzqh"];
        
    } failActions:nil serviceFail:nil];

}
#pragma mark -UIPickerViewDataSource
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerVie
//{
//    return 2;
//}
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    NSInteger rowsNum = 0;
//    if (pickerView == _regionPickerView) {
//        if (component==0) {
//            rowsNum =  _regionList.count;
//        }else{
//            NSInteger provinceRow = [_regionPickerView selectedRowInComponent:0];
//            NSArray *citys = _regionList[provinceRow][@"children"];
//            rowsNum = citys.count;
//        }
//    }
//    return rowsNum;
//}
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSString *str = @"";
//    if (pickerView == _regionPickerView) {
//        if (component==0) {
//            str =  _regionList[row][@"short_name"];
//        }else{
//            NSInteger provinceRow = [_regionPickerView selectedRowInComponent:0];
//            NSArray *citys = _regionList[provinceRow][@"children"];
//            str =  citys[row][@"short_name"];
//        }
//    }
//    return str;
//}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    if (component==0) {
//        [pickerView reloadComponent:1];
//        [pickerView selectRow:0 inComponent:1 animated:YES];
//    }
//}
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if (_regionList.count==0) {
//        return NO;
//    }
//    return YES;
//}
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField==_regionInput) {
//        NSInteger provinceRow = [_regionPickerView selectedRowInComponent:0];
//        NSInteger cityRow = [_regionPickerView selectedRowInComponent:1];
//        NSArray *citys = _regionList[provinceRow][@"children"];
//        textField.text = [NSString stringWithFormat:@"%@ %@",_regionList[provinceRow][@"short_name"],citys[cityRow][@"short_name"]];
//    }
//}

- (IBAction)saveAddressAction:(id)sender {
    if (self.nameTextField.text.length&&self.phoneTextField.text.length&&self.regionInput.text.length&&self.streetTextField.text.length) {
        BOOL isDefault=NO;
        if (self.isEditor == YES) {
            if ([self.addressDic[@"selected"] boolValue]==YES) {
                isDefault = YES;
            }else{
                isDefault = NO;
            }
        }
        NSMutableDictionary *address = [[NSMutableDictionary alloc]initWithObjects:@[self.nameTextField.text,self.phoneTextField.text,self.regionInput.text,self.streetTextField.text,@(isDefault)] forKeys:@[@"name",@"phone",@"region",@"street",@"selected"]];
        self.myBlock(address);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [TDApplicationUtil alertHud:@"保存失败" afterDelay:1];
    }
}
-(void)carryBlock:(addressBlock)block
{
    self.myBlock = block;
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
