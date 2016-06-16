//
//  ESEditViewController.m
//  EaseReco
//
//  Created by wangchen on 4/2/15.
//  Copyright (c) 2015 wangchen. All rights reserved.
//

#import "ESEditViewController.h"

@interface ESEditViewController ()
@property (nonatomic, strong) NSMutableArray *fieldArray;
@end

@implementation ESEditViewController
@synthesize delegate;
@synthesize str;
@synthesize img;

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
//    self.navigationController.navigationBarHidden = YES;
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
}


-(CGFloat)getFontSize:(CGSize)size ofString:(NSString*)testString
{
    
    CGFloat fontSize;
    
    UIFont *font = [UIFont systemFontOfSize:500];
    
    [testString sizeWithFont:font
     
                 minFontSize:10.0f
     
              actualFontSize:&fontSize
     
                    forWidth:(size.width)
     
               lineBreakMode:NSLineBreakByWordWrapping];
    
    return fontSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
    // Do any additional setup after loading the view from its nib.
    self.fieldArray = [NSMutableArray array];
    

    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_info"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
//    textField1.text = self.str;//[array objectAtIndex:0];
//    [textField1 becomeFirstResponder];
//    textField2.text = [array objectAtIndex:1];
//    textField3.text = [array objectAtIndex:2];
//    textField4.text = [array objectAtIndex:3];
//    imgView.contentMode = 
    imgView.image = img;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    NSArray *array = [self.str componentsSeparatedByString:@" "];
    NSInteger len = str.length;
    
    float x = 0;
    float w = 0;
    float h = textView.frame.size.height;
    float minFontSize = 100;
    for(int i=0; i<array.count; ++i)
    {
        NSString *tmp = [array objectAtIndex:i];
        w = textView.frame.size.width * tmp.length / len;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, w, h)];
        [textView addSubview:textField];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.text = tmp;
        float f = [self getFontSize:CGSizeMake(w, h) ofString:tmp];
        if(f < minFontSize)minFontSize = f;
        
        [self.fieldArray addObject:textField];
        x += w;
        x += textView.frame.size.width / len;
    }
    if(minFontSize > 15) minFontSize = minFontSize * 4 / 5;
    for(UITextField *textField1 in self.fieldArray)
    {
        textField1.font = [UIFont systemFontOfSize:minFontSize];
    }
    if(self.fieldArray.count > 0)
    {
        UITextField *textField1 = self.fieldArray.firstObject;
        [textField1 becomeFirstResponder];
    }
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

-(void)cancel:(id)sender
{
    [delegate didBackfrom:self];
}

-(IBAction)nextStep:(id)sender
{
    NSMutableString *str1 = [NSMutableString string];
//    [str1 appendFormat:@"%@ ", textField1.text];
//    [str1 appendFormat:@"%@ ", textField2.text];
//    [str1 appendFormat:@"%@ ", textField3.text];
//    [str1 appendFormat:@"%@", textField4.text];
    
    for(int i=0; i<self.fieldArray.count-1; ++i)
    {
        UITextField *textField1 = [self.fieldArray objectAtIndex:i];
        [str1 appendFormat:@"%@ ", textField1.text];
    }
    if(self.fieldArray.count > 0)
    {
        UITextField *textField1 = self.fieldArray.lastObject;
        [str1 appendFormat:@"%@", textField1.text];
    }
    [delegate didEndEdit:str1 from:self];
}

@end
