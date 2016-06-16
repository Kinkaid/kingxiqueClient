//
//  NickNameController.m
//  infoPromotionClient
//
//  Created by imac on 16/3/1.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "NickNameController.h"

@interface NickNameController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@end

@implementation NickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithBackItem];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    self.nickNameTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"];
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
    self.title = @"编辑昵称";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//保存
- (IBAction)saveToServer:(id)sender {
    if (self.nickNameTextField.text.length<4) {
        [TDApplicationUtil alertHud:@"您的用户名输入太短了" afterDelay:1];
        }else if (self.nickNameTextField.text.length>16){
        [TDApplicationUtil alertHud:@"您的用户名输入太长了" afterDelay:1];
    }else{
        for (int i=0; i<[self.nickNameTextField.text length]; i++) {
            NSString *regex = @"[a-zA-Z0-9\u4E00-\u9FA5]";
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            if ([predicate evaluateWithObject:[self.nickNameTextField.text substringWithRange:NSMakeRange(i, 1)]] == YES||[[self.nickNameTextField.text substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"_"]) {
                if (i==self.nickNameTextField.text.length-1) {
                    //调接口
                    [TDApplicationUtil alertHud:@"保存成功" afterDelay:1];
                    [[NSUserDefaults standardUserDefaults]setObject:self.nickNameTextField.text forKey:@"nickName"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
            }else {
                [TDApplicationUtil alertHud:@"仅支持中文、英文、数字和下划线哦" withLabelFont:[UIFont systemFontOfSize:13] afterDelay:1];
                break;
            }
        }
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
