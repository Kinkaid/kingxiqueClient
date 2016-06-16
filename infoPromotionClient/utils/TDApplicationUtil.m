//
//  TDApplicationUtil.m
//  infoPromotion
//
//  Created by 朱靓慈 on 15/3/4.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "TDApplicationUtil.h"
#import "LoginAndRegiterPrefaceController.h"
#import <AVFoundation/AVFoundation.h>

extern CGFloat SCREEN_HEIGHT;
extern CGFloat SCREEN_WIDTH;
#define LAST_RUN_VERSION_KEY        @"last_run_version_of_application"
@implementation TDApplicationUtil{ 
}

+(TDApplicationUtil*)sharedInstance{
    static TDApplicationUtil *singleton=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton=[[self alloc]init];
    });
    return singleton;
}


+(void)makeSureLoginThen:(void (^)())complete controller:(UIViewController*)controller{
    if(![TDUserDefaultsUtil havePhoneNum]){//检测到无登录信息则跳转登录界面
        LoginAndRegiterPrefaceController *loginController = [[LoginAndRegiterPrefaceController alloc] init];
//        loginController.viewDisplayMode = CsViewControllerDisplayModePresent;
//        loginController.editorMode = CsEditorModeIsCreate;
        [loginController loginComplete:^{
            complete();
        }];
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginController];
        [loginNav addChildViewController:loginController];
        [controller presentViewController:loginNav animated:YES completion:nil];
    }else{
        complete();
    }
}

+(void)alertHud:(NSString *)text afterDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.labelText = [NSString stringWithFormat:@"%@",text];
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:delay];
}
+(void)alertHud:(NSString *)text withLabelFont:(UIFont *)labelFont afterDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.labelText = [NSString stringWithFormat:@"%@",text];
    if (labelFont) {
        hud.labelFont = labelFont;
    }
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:delay];
}


+(void)button:(UIButton *)button setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [button setBackgroundImage:[self imageWithColor:backgroundColor] forState:state];
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(void)showPop:(UIView *)popView toFrame:(CGRect)endFrame{
    POPSpringAnimation *viewFrameAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    viewFrameAnim.toValue = [NSValue valueWithCGRect:endFrame];
    [popView pop_addAnimation:viewFrameAnim forKey:@"viewFrameAnim"];
}
+(void)hidePop:(UIView *)popView toFrame:(CGRect)initFrame{
    POPSpringAnimation *viewFrameAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    viewFrameAnim.toValue = [NSValue valueWithCGRect:initFrame];
    [popView pop_addAnimation:viewFrameAnim forKey:@"viewFrameAnim"];
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"注册Alias  rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
+ (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}

+(BOOL)hasAVAuthorization{
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return false;
        
    }
    return true;
}
+(void)setMainNavigation:(UINavigationController *)navCtrl{
    navCtrl.navigationBar.barTintColor = [TDColorUtil parse:@"#F7F7F7"];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
    //导航栏title设为黑色
    navCtrl.navigationBar.titleTextAttributes  = textAttributes;
    //导航栏左右button设为灰色
    navCtrl.navigationBar.tintColor = [UIColor darkGrayColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
+(void)setWhiteNavigation:(UINavigationController *)navCtrl{
    navCtrl.navigationBar.barTintColor = [TDColorUtil parse:@"#F7F7F7"];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
    //导航栏title设为黑色
    navCtrl.navigationBar.titleTextAttributes  = textAttributes;
    //导航栏左右button设为灰色
    navCtrl.navigationBar.tintColor = [UIColor darkGrayColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
+(void)setTopicNavigation:(UINavigationController *)navCtrl{
    navCtrl.navigationBar.barTintColor = [TDColorUtil parse:@"#4CBDCD"];
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    navCtrl.navigationBar.titleTextAttributes  = textAttributes;
    navCtrl.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

+(CGFloat)getLabelHeightWithFontSize:(CGFloat)fontSize withWordsContent:(NSString *)wordsContent andMarginHorizon:(CGFloat)marginHorizon{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:wordsContent];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [wordsContent length])];
    NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize],
                                  NSParagraphStyleAttributeName : paragraphStyle};
    CGSize contentSize = [wordsContent boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-marginHorizon, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    return contentSize.height;
}
//根据图片名称 生成背景
+(UIColor *)getBackgroundColorWithImageNameStr:(NSString *)imageNameStr{
    UIImage *imagePattern = [UIImage imageNamed:imageNameStr];
    UIColor *colorPattern = [[UIColor alloc] initWithPatternImage:imagePattern];
    return colorPattern;
}
+(UIColor *)getBackgroundColorWithImageNameStr:(NSString *)imageNameStr andBackgroundSize:(CGSize)backgroundSize{
    UIImage *imagePattern = [UIImage imageNamed:imageNameStr];
    UIColor *colorPattern = [UIColor colorWithPatternImage:[self imageResize :imagePattern andResizeTo:backgroundSize]];
    return colorPattern;
}
+(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//判断decimalTextField是否允许输入，比如价格只允许输入一个小数点和小数点后两位数，折扣只允许输入一个小数点和小数点后一位数
+(BOOL)judgeDecimalTextFieldAllowInput:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalLimit:(int)limit{
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString  insertString:string atIndex:range.location];
    
    NSInteger flag=0;
    const NSInteger limited = limit;
    //自定义折扣只允许小数点后一位
    for (int i = (int)futureString.length-1; i>=0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            
            if (flag > limited) {
                return NO;
            }
            
            break;
        }
        flag++;
    }
    //只允许一个小数点
    if ([string isEqualToString:@"."]&&[textField.text rangeOfString:@"."].location !=NSNotFound) {
        return NO;
    }
    
    return YES;
}
//标识app是否是第一次启动
+ (BOOL) isAppFirstLoad{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
        // App is being run for first time
    }
    else if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
        // App has been updated since last run
    }
    return NO;
}

@end
