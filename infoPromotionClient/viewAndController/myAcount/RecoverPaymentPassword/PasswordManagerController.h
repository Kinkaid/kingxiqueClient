//
//  PasswordManagerController.h
//  infoPromotion
//
//  Created by imac on 15/9/24.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    pswManagePageTypeIsProduct,
    pswManagePageTypeIsAccount
}pswManagePageType;

@interface PasswordManagerController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *upBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;


@end
