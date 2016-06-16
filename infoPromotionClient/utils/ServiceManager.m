//
//  ServiceManager.m
//  citylife
//
//  Created by chenkaiwei  on 15-1-8.
//  Copyright (c) 2015年 tgram. All rights reserved.
//

#import "ServiceManager.h"
#import "TDParamUtil.h"
#import "MBProgressHUD.h"
#import "MMMaterialDesignSpinner.h"



static int const POST = 0;
static int const GET = 1;
static int const PUT = 2;
static int const DELETE = 3;
extern CGFloat SCREEN_HEIGHT;
extern CGFloat SCREEN_WIDTH;

@interface ServiceManager()
-(id)initialize;
@end

@implementation ServiceManager{
    AFHTTPRequestOperationManager *_manager;
    int  secondsCountDown;//计时器倒计时秒数
    NSTimer *countDownTimer;
    BOOL canHideLoading;//是否能消除加载状态
    BOOL existLoadingView;//加载是否存在
}
+(ServiceManager*)sharedInstance{
    static ServiceManager *singleton=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton=[[self alloc]initialize];
    });
    return singleton;
}

-(id)initialize{
    if(self==[super init]){
        NSURL *baseURL = [NSURL URLWithString:@"www.kingxique.com"];
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    }
    return  self;
}


//对外-第一组
-(void)postToMethod:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic successAlert:(NSString*)sucAlertMsg failureAlert:(NSString*)failAlertMsg{
    
    NSDictionary *attrDic = @{@"showHud":@YES};
    [self requestType:POST serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:nil successAlert:sucAlertMsg failureAlert:failAlertMsg];
}

-(void)getToMethod:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic successAlert:(NSString*)sucAlertMsg failureAlert:(NSString*)failAlertMsg{
    
    NSDictionary *attrDic = @{@"showHud":@YES};
    [self requestType:GET serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:nil successAlert:sucAlertMsg failureAlert:failAlertMsg];
}

-(void)putToMethod:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic successAlert:(NSString*)sucAlertMsg failureAlert:(NSString*)failAlertMsg{
    
    NSDictionary *attrDic = @{@"showHud":@YES};
    [self requestType:PUT serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:nil successAlert:sucAlertMsg failureAlert:failAlertMsg];
}

-(void)deleteToMethod:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic successAlert:(NSString*)sucAlertMsg failureAlert:(NSString*)failAlertMsg{
    
    NSDictionary *attrDic = @{@"showHud":@YES};
    [self requestType:DELETE serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:nil successAlert:sucAlertMsg failureAlert:failAlertMsg];
}

//对外-第二组
-(void)postAction:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    
    NSDictionary *attrDic = @{@"showHud":@YES};
    [self requestType:POST serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}

-(void)getAction:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    NSDictionary *attrDic = @{@"showHud":@YES};
    [self requestType:GET serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}

-(void)putAction:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    NSDictionary *attrDic = @{@"showHud":@YES};
    [self requestType:PUT serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}
-(void)deleteAction:(NSString*)methodUrl params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    NSDictionary *attrDic = @{@"showHud":@YES};
    [self requestType:DELETE serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}
//对外-第三组
-(void)postFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *resData))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    
    [self requestType:POST serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}

-(void)getFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *resData))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    
    [self requestType:GET serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}

-(void)putFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *resData))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    
    [self requestType:PUT serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}

-(void)deleteFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *resData))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    [self requestType:DELETE serviceUrl:SERVICEURL method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}
//对外-第四组
-(void)postNewFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *resData))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    
    [self requestType:POST serviceUrl:SERVICEURL_NEW method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}

-(void)getNewFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *resData))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    
    [self requestType:GET serviceUrl:SERVICEURL_NEW method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}

-(void)putNewFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *resData))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    
    [self requestType:PUT serviceUrl:SERVICEURL_NEW method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}

-(void)deleteNewFunction:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *resData))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail {
    [self requestType:DELETE serviceUrl:SERVICEURL_NEW method:methodUrl params:params attributes:attrDic success:success failActions:failDic serviceFail:serviceFail successAlert:nil failureAlert:nil];
}
//核心方法
-(void)requestType:(int)requestType serviceUrl:(NSString *)serviceUrl method:(NSString*)methodUrl params:(NSDictionary*)params attributes:(NSDictionary*)attrDic success:(void (^)(AFHTTPRequestOperation *operation, id responseObject,NSDictionary *data))success failActions:(NSDictionary*)failDic serviceFail:(void(^)(AFHTTPRequestOperation *operation, NSError *error))serviceFail successAlert:(NSString*)sucAlertMsg failureAlert:(NSString*)failAlertMsg {
    
    bool showHud=YES;
    bool showServerErrMsg = NO;
    if (attrDic!=nil) {
        if ([[attrDic allKeys] containsObject:@"showHud"]) {
            showHud = [[attrDic objectForKey:@"showHud"] boolValue];//控制是否显示hud
        };
        if ([[attrDic allKeys] containsObject:@"showServerErrMsg"]) {
            showServerErrMsg = [[attrDic objectForKey:@"showServerErrMsg"] boolValue];//控制是否alert服务器返回的错误信息
        };
    }
    
    MMMaterialDesignSpinner *spinnerView = [[MMMaterialDesignSpinner alloc] initWithFrame:CGRectZero];
    UIControl *shadeView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (showHud) {
        spinnerView.bounds = CGRectMake(0, 0, 50, 50);
        spinnerView.lineWidth = 3.0f;
        spinnerView.hidesWhenStopped=YES;
        spinnerView.tintColor = [UIColor colorWithRed:71.f/255 green:196.f/255 blue:70.f/255 alpha:1];
        CGRect screenBounds = [[UIScreen mainScreen]bounds];
        spinnerView.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
        spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
        [[[UIApplication sharedApplication] keyWindow] addSubview:shadeView];
        [shadeView addTarget:self action:@selector(hideLoadingByTouchShade:) forControlEvents:UIControlEventTouchUpInside];
        [shadeView addSubview:spinnerView];
        [spinnerView startAnimating];
        canHideLoading = NO;
        existLoadingView = YES;
        secondsCountDown = 3;
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    }
    NSString *serviceMethodUrl = [NSString stringWithFormat:@"%@%@",serviceUrl, methodUrl];
    NSDictionary *serviceParams = [TDParamUtil formatServiceParam:params];
    //通信返回正常
    void(^successBlock)(AFHTTPRequestOperation *operation, id responseObject)=^(AFHTTPRequestOperation *operation, id responseObject ) {
        
        [spinnerView stopAnimating];
        shadeView.hidden = YES;
        
        NSDictionary *obj = responseObject;
        id code = [obj valueForKey:@"code"];
        if([[NSString stringWithFormat:@"%@",code] isEqualToString:@"1"]){
            //业务处理正常，编码为1
            if (sucAlertMsg) {
                [TDApplicationUtil alertHud:sucAlertMsg afterDelay:0.5];
            }
            
            success(operation,responseObject,obj[@"data"]);
        }else{
            NSString *serverMsg = [obj valueForKey:@"msg"];//服务器传回的错误提示
            //业务处理异常，编码不为1
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failDic) {
                    if (failDic[FAIL]){//无论返回什么错误code均执行
                        void(^failBlock)(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) =failDic[FAIL];
                        if (failBlock) {
                            failBlock(operation,responseObject,[obj valueForKey:@"msg"]);
                        }
                    }else{//返回特定错误code执行
                        void(^codeFailBlock)(AFHTTPRequestOperation *operation, id responseObject, NSDictionary *data) =[failDic objectForKey:[[obj objectForKey:@"code"] stringValue]];
                        if (codeFailBlock) {
                            codeFailBlock(operation,responseObject,[obj valueForKey:@"msg"]);
                        }
                    }
                }else if (failAlertMsg) {
                    [TDApplicationUtil alertHud:failAlertMsg afterDelay:0.5];
                }else if(serverMsg){
                    if ([serverMsg isEqualToString:@""]) {
                        NSLog(@"未注册的业务处理异常 code = %@",[obj valueForKey:@"code"]);
                        [TDApplicationUtil alertHud:@"业务处理异常" afterDelay:1];
                    } else {
                        [TDApplicationUtil alertHud:serverMsg afterDelay:1];
                    }
                    
                }
            });
        }
    };
    ////服务异常
    void(^failureBlock)(AFHTTPRequestOperation *operation, NSError *error);
    if (serviceFail) {
        failureBlock=^(AFHTTPRequestOperation *operation, NSError *error) {
            serviceFail(operation,error);
            [spinnerView stopAnimating];
            shadeView.hidden = YES;
        };
    }else{
        failureBlock=^(AFHTTPRequestOperation *operation, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *alertMsg = [NSString stringWithFormat:@"%@",[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
                if(existLoadingView){//加载状态存在时才弹出
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:alertMsg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alertView show];
                }
                
                
                NSLog(@"%@",alertMsg);
                
                [spinnerView stopAnimating];
                shadeView.hidden = YES;
                
            });
        };
    }
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [_manager.requestSerializer setValue:[TDUserDefaultsUtil getToken] forHTTPHeaderField:@"token"];
    NSString *authorization = [TDParamUtil formatAuthorization:params];
    [_manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
    
    //提交请求
    switch (requestType) {
        case POST:
        {
            [_manager POST:serviceMethodUrl parameters:serviceParams success:successBlock failure:failureBlock];
        }
            break;
        case GET:{
            [_manager GET:serviceMethodUrl parameters:serviceParams success:successBlock failure:failureBlock];
        }
            break;
        case PUT:{
            [_manager PUT:serviceMethodUrl parameters:serviceParams success:successBlock failure:failureBlock];
        }
            break;
        case DELETE:{
            [_manager DELETE:serviceMethodUrl parameters:serviceParams success:successBlock failure:failureBlock];
        }
            break;
            
        default:
            break;
    }
}
-(void)timeFireMethod{//到达一定时间才能点击遮罩 消除加载状态
    secondsCountDown--;
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        canHideLoading = YES;
    }
}
-(void)hideLoadingByTouchShade:(id)sender{//通过点击遮罩 消除加载状态
    if (canHideLoading) {
        UIControl *shadeView = (UIControl *)sender;
        shadeView.hidden = YES;
        existLoadingView = NO;
    }
    
}
@end
