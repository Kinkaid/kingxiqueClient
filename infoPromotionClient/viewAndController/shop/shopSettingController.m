//
//  shopSettingController.m
//  infoPromotionClient
//
//  Created by imac on 15/12/24.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "shopSettingController.h"
#import <AudioToolbox/AudioToolbox.h>
@interface shopSettingController ()
@property (weak, nonatomic) IBOutlet UISwitch *messageSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *voiceSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *shakeSwitch;
@end

@implementation shopSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)swithchAction:(id)sender {
    UISwitch *settingSwitch = (UISwitch *)sender;
    switch (settingSwitch.tag) {
        case 1://是否接受消息
        {
           
        }
            break;
        case 2://声音提示
        {
            if (settingSwitch.on == YES) {
            }
        }
            break;
        case 3://震动提示
        {
            if (settingSwitch.on == YES) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
  
            }
        }
            break;
        default:
            break;
    }
}

//取消收藏按钮
- (IBAction)cancelCollectionAction:(id)sender {
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
