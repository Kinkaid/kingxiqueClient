//
//  ESEditViewController.h
//  EaseReco
//
//  Created by wangchen on 4/2/15.
//  Copyright (c) 2015 wangchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ESEditDelegate <NSObject>
-(void)didEndEdit:(NSString*)str from:(id)sender;
-(void)didBackfrom:(id)sender;
@end

@interface ESEditViewController : UIViewController
{
//    IBOutlet UITextField *textField1;
    IBOutlet UIView *textView;
    IBOutlet UIImageView *imgView;
    
}
@property (nonatomic, assign) id<ESEditDelegate> delegate;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, retain) UIImage *img;

-(IBAction)nextStep:(id)sender;

@end
