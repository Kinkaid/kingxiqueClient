//
//  PersonalInfomationController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/29.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "PersonalInfomationController.h"
#import "NickNameController.h"
#import "AddAddressController.h"
#import "PasswordManagerController.h"//登陆密码更改
@interface PersonalInfomationController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;


@end

@implementation PersonalInfomationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.translucent = YES;
    self.nickNameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"];
    self.phoneNumLabel.text = [TDUserDefaultsUtil getMobile];
}

#pragma mark - IBActions
- (IBAction)touchUpAction:(id)sender {
    UIButton *button = sender;
    switch (button.tag) {
        case 1://头像
        {
            [self takePhoto];
        }
            break;
        case 2://昵称
        {
            NickNameController *vc = [[NickNameController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3://性别
        {
            [self selectSex];
        }
            break;
        case 4://新增地址
        {
            AddAddressController *vc = [[AddAddressController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5://修改密码
        {
            PasswordManagerController *vc = [[PasswordManagerController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
-(void)takePhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"更改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    actionSheet.tag  = 100;
    [actionSheet showInView:self.view];
}
-(void)selectSex
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"更改性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    actionSheet.tag  = 101;
    [actionSheet showInView:self.view];
}
#pragma mark - actionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 100) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        switch (buttonIndex) {
            case 0:
            {
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.sourceType = sourceType;
                [self presentViewController:picker animated:YES completion:nil];
            }
                break;
            case 1:
            {
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"此设备不支持拍照" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }else{
                    picker.sourceType = sourceType;
                    [self presentViewController:picker animated:YES completion:nil];
                }
            }
                break;
            default:
                break;
        }
    }else if (actionSheet.tag == 101){
        switch (buttonIndex) {
            case 0:
            {
               self.sexLabel.text = @"男";
            }
                break;
            case 1:
            {
                self.sexLabel.text = @"女";
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark - UIImagePickerViewDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = info[UIImagePickerControllerMediaType];
    if ([type isEqualToString:(NSString *)kUTTypeImage]) {
        self.headerImageView.image = info[UIImagePickerControllerEditedImage];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
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
