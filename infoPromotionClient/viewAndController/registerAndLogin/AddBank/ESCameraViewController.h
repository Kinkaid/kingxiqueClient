//
//  ESCameraViewController.h
//  EaseReco
//
//  Created by wangchen on 4/2/15.
//  Copyright (c) 2015 wangchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESCameraDelegate <NSObject>

-(void)didEndRecWithResult:(NSString*)strResult image:(UIImage*)img from:(id)sender;

@end

@interface ESCameraViewController : UIViewController
{
    IBOutlet UIButton *lightBtn;
//    IBOutlet UILabel *errorLabel;
}

@property (nonatomic, assign) id<ESCameraDelegate> delegate;

-(IBAction)back:(id)sender;
-(IBAction)light:(id)sender;

@end
