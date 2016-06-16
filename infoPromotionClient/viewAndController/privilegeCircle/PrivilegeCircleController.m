//
//  PrivilegeCircleController.m
//  infoPromotionClient
//
//  Created by imac on 16/1/4.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "PrivilegeCircleController.h"
#import "PrivilegeCircleCell.h"
#import "PrivilegeCardCell.h"
#import "PrivilegeGoodsCell.h"
#import "PrivilegeListCell.h"
#import "PrivilegeCircleMenuCell.h"
#define circleId @"PrivilegeCircleCell"
#define cardId @"PrivilegeCardCell"
#define goodsId @"PrivilegeGoodsCell"
#define listId @"PrivilegeListCell"
@interface PrivilegeCircleController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,PrivilegeCircleDelegate,PrivilegeCardDelegate,PrivilegeGoodsDelegate,UIAlertViewDelegate,UITextFieldDelegate>
//点击菜单栏弹出的覆盖层
@property (strong, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UIView *popContentView;
@property (weak, nonatomic) IBOutlet UITableView *popTableView;
//是否显示筛选框
@property (nonatomic)BOOL isShow;
@property (nonatomic,strong)NSMutableArray *menuArr;//存放菜单
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewLendingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewRightingConstraint;
@property (nonatomic)NSInteger cellRow;
@property (nonatomic)NSInteger commentListRow;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage1;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage2;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage3;
@property (weak, nonatomic) IBOutlet UILabel *noopsycheLabel;//只能排序
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//时间排序
@property (weak, nonatomic) IBOutlet UILabel *rangeLabel;//距离排序
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *commentArr;//存放后台读取优惠圈一切信息
@property (nonatomic,strong)NSMutableArray *commentHeightArr;//存放根据后台读取的信息计算每一个cell的高度
//键盘弹出控件
@property (nonatomic,strong)UIView *CommentView;
@property (nonatomic)BOOL isAppear;
@property (strong,nonatomic)UITextView *commentTextView;
@end
extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
@implementation PrivilegeCircleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNotification];
    [self initWithData];
    [self initWithTableView];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    self.viewLendingConstraint.constant =self.viewRightingConstraint.constant = SCREEN_WIDTH/3.0;
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton setImage:[UIImage imageNamed:@"mo-caidan"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.popView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.popView.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:self.popView];
    self.popView.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardAppearance:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector (textViewChange:)name:UITextViewTextDidChangeNotification object:_commentTextView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)rightClick:(UIButton *)button
{
    if (self.isShow == NO) {
        self.popView.hidden = NO;
        [button setImage:[UIImage imageNamed:@"caidan"] forState:UIControlStateNormal];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        CGPoint center;
        center.x = SCREEN_WIDTH/2;
        center.y = 175;
        self.popContentView.center =center;
        self.popTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 350);
        self.isShow  = YES;
        [UIView commitAnimations];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            self.popTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        } completion:^(BOOL finished) {
            self.popView.hidden = YES;
            self.isShow  = NO;
            [button setImage:[UIImage imageNamed:@"mo-caidan"] forState:UIControlStateNormal];
        }];
    }
}

-(void)initWithTableView
{
    self.title = @"优惠圈";
    [self.tableView registerNibByCellId:circleId];
    [self.tableView registerNibByCellId:cardId];
    [self.tableView registerNibByCellId:goodsId];
    [self.tableView registerNibByCellId:listId];
    [self.popTableView registerNibByCellId:@"PrivilegeCircleMenuCell"];
}
-(void)initWithData
{
    NSMutableArray *menuArr = [[NSMutableArray alloc]initWithObjects:@"全部",@"我消消费过得店",@"我收藏过得店",@"仅显示会员卡",@"仅显示优惠券",@"仅显示特价单品",@"仅显示贴文",nil];
    self.menuArr = [[NSMutableArray alloc]init];
    for (int i=0; i<menuArr.count; i++) {
        if (i==0) {
           NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithObjects:@[menuArr[i],@(YES)] forKeys:@[@"menu",@"isSel"]];
            [self.menuArr addObject:mDic];
        }else{
           NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithObjects:@[menuArr[i],@(NO)] forKeys:@[@"menu",@"isSel"]];
            [self.menuArr addObject:mDic];
        }
    }
    NSMutableArray *circleArr = [[NSMutableArray alloc]initWithObjects:@"Ada:深度好文值得共享",@"Kobe:楼上说的对,好文章多多分享",nil];
    NSMutableArray *cardArr = [[NSMutableArray alloc]initWithObjects:@"Jack:会员卡真优惠",@"James:有了会员卡,吃饭停车不担忧", nil];
    NSMutableArray *goodsArr = [[NSMutableArray alloc]initWithObjects:@"Mike:单品很便宜很实惠很好吃",@"Curry:色香味俱全,mark", nil];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]initWithObjects:@[circleArr,@(431),@(24),@(YES),@(NO),@(1)] forKeys:@[@"comment",@"likeCount",@"hateCount",@"haveLike",@"haveHate",@"category"]];
     NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]initWithObjects:@[cardArr,@(663),@(12),@(NO),@(YES),@(2)] forKeys:@[@"comment",@"likeCount",@"hateCount",@"haveLike",@"haveHate",@"category"]];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]initWithObjects:@[goodsArr,@(583),@(46),@(NO),@(NO),@(3)] forKeys:@[@"comment",@"likeCount",@"hateCount",@"haveLike",@"haveHate",@"category"]];
    self.commentArr = [[NSMutableArray alloc]initWithObjects:dic1,dic2,dic3, dic1,dic2,dic3,nil];
    self.commentHeightArr = [[NSMutableArray alloc]init];
    for (int i=0; i<self.commentArr.count; i++) {
       CGFloat contentHeight = 0;
        for (int j=0; j<[self.commentArr[i][@"comment"] count]; j++) {
            contentHeight +=[LJKHelper textHeightFromTextString:self.commentArr[i][@"comment"][j] width:self.view.frame.size.width-79 fontSize:12]*1.5;
        }
        [self.commentHeightArr addObject:@(contentHeight)];
    }
}
//智能排序
- (IBAction)noopsycheRankAction:(id)sender {
    [self initWithLableColorAndImage];
    self.noopsycheLabel.textColor = [TDColorUtil parse:@"#EC5413"];
    self.selectedImage1.image = [UIImage imageNamed:@"xiasanjiao"];
}
//时间排序
- (IBAction)timeRankAction:(id)sender {
    [self initWithLableColorAndImage];
    self.timeLabel.textColor = [TDColorUtil parse:@"#EC5413"];
    self.selectedImage2.image = [UIImage imageNamed:@"xiasanjiao"];
}
//距离排序
- (IBAction)rangeRankAction:(id)sender {
    [self initWithLableColorAndImage];
    self.rangeLabel.textColor = [TDColorUtil parse:@"#EC5413"];
    self.selectedImage3.image = [UIImage imageNamed:@"xiasanjiao"];
}
//初始化排序按钮图片和颜色
-(void)initWithLableColorAndImage
{
    self.noopsycheLabel.textColor = [TDColorUtil parse:@"#4D4D4D"];
    self.selectedImage1.image = [UIImage imageNamed:@"suisanjiao"];
    self.timeLabel.textColor = [TDColorUtil parse:@"#4D4D4D"];
    self.selectedImage2.image = [UIImage imageNamed:@"suisanjiao"];
    self.rangeLabel.textColor = [TDColorUtil parse:@"#4D4D4D"];
    self.selectedImage3.image = [UIImage imageNamed:@"suisanjiao"];
}
-(void)initWithTextField
{
    _commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(8,8, [UIScreen mainScreen].bounds.size.width-16, 60)];
    
    _commentTextView.backgroundColor = [UIColor whiteColor];
    _commentTextView.delegate = self;
    self.CommentView =[[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 80)];
    _commentTextView.layer.borderWidth = 1;
    _commentTextView.layer.cornerRadius = 8;
    _commentTextView.layer.borderColor = [TDColorUtil parse:@"#D8D8D8"].CGColor;
    _commentTextView.font = [UIFont systemFontOfSize:14];
    self.CommentView.backgroundColor = [TDColorUtil parse:@"#F5F5F5"];
    [self.CommentView addSubview:_commentTextView];
    [self.view addSubview:self.CommentView];
}
-(void)keyboardAppearance:(NSNotification *)notification
{
    self.isAppear = YES;
    self.CommentView.hidden = NO;
}
-(void)textViewChange:(NSNotification *)notification
{
    UITextField *textField=[notification object];
    [textField.textInputMode primaryLanguage];
}
-(void)keyboardWasChange:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    if ([[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y != [UIScreen mainScreen].bounds.size.height) {
        self.CommentView.frame =CGRectMake(0, [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y-60, [UIScreen mainScreen].bounds.size.width, 80);
    }else {
        self.CommentView.frame =CGRectMake(0,-80, 0, 0);
    }
}

#pragma mark -- textViewDelegate
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.isAppear = NO;
    if (self.commentTextView.text.length == 0) {
        self.CommentView.hidden = YES;
        [self.CommentView resignFirstResponder];
        return;
    }else{
        if (self.commentListRow == 0) {
            [self.commentArr[self.cellRow][@"comment"] addObject:[NSString stringWithFormat:@"%@:%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"],textView.text]];
            CGFloat contentHeight = 0;
            for (int i=0; i<[self.commentArr[self.cellRow][@"comment"] count]; i++) {
                contentHeight +=[LJKHelper textHeightFromTextString:self.commentArr[self.cellRow][@"comment"][i] width:self.view.frame.size.width-76 fontSize:12]*1.5;
            }
            [self.commentHeightArr replaceObjectAtIndex:self.cellRow withObject:@(contentHeight)
             ];
            [self.tableView reloadData];
            self.commentTextView.text = nil;
            [self.CommentView removeFromSuperview];
        }else{
            int i;
            for (i=0; i<[self.commentArr[self.cellRow][@"comment"][self.commentListRow-1] length]; i++) {
                if ([[self.commentArr[self.cellRow][@"comment"][self.commentListRow-1] substringWithRange:NSMakeRange(i, 1)] isEqualToString:@":"]) {
                    break;
                }
            }
            [self.commentArr[self.cellRow][@"comment"] addObject:[NSString stringWithFormat:@"%@ 回复 %@:%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"],[self.commentArr[self.cellRow][@"comment"][self.commentListRow-1] substringToIndex:i] ,textView.text]];
           CGFloat contentHeight = 0;
            for (int i=0; i<[self.commentArr[self.cellRow][@"comment"] count]; i++) {
                contentHeight +=[LJKHelper textHeightFromTextString:self.commentArr[self.cellRow][@"comment"][i] width:self.view.frame.size.width-76 fontSize:12]*1.5;
            }
            [self.commentHeightArr replaceObjectAtIndex:self.cellRow withObject:@(contentHeight)
             ];
            self.commentListRow = 0;
            [self.tableView reloadData];
            self.commentTextView.text = nil;
            [self.CommentView removeFromSuperview];
        }
    }
}
#pragma mark -- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return self.commentArr.count;
    }else {
        return 7;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        if ([self.commentArr[indexPath.row][@"category"] intValue]==1) {
            PrivilegeCircleCell *circleCell = [tableView dequeueReusableCellWithIdentifier:circleId forIndexPath:indexPath];
            circleCell.delegate = self;
            circleCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [circleCell showDataWithDic:self.commentArr[indexPath.row]];
            circleCell.cellRow = indexPath.row;
            return circleCell;
        }else if([self.commentArr[indexPath.row][@"category"] intValue]==2){
            PrivilegeCardCell *cardCell = [tableView dequeueReusableCellWithIdentifier:cardId forIndexPath:indexPath];
            cardCell.selectionStyle = UITableViewCellSelectionStyleNone;
            cardCell.cellRow = indexPath.row;
            cardCell.delegate = self;
            [cardCell showDataWithDic:self.commentArr[indexPath.row]];
            return cardCell;
        }else if ([self.commentArr[indexPath.row][@"category"] intValue]==3){
            PrivilegeGoodsCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:goodsId forIndexPath:indexPath];
            goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
            goodsCell.delegate = self;
            [goodsCell showDataWithDic:self.commentArr[indexPath.row]];
            goodsCell.cellRow = indexPath.row;
            return goodsCell;
        }else{
            PrivilegeListCell *listCell = [tableView dequeueReusableCellWithIdentifier:listId forIndexPath:indexPath];
            listCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return listCell;
        }
    }else {
        PrivilegeCircleMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrivilegeCircleMenuCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell showDataWithArr:self.menuArr[indexPath.row]];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        if ([self.commentArr[indexPath.row][@"category"] intValue]==1) {
            return 171+[self.commentHeightArr[indexPath.row] floatValue];//深度好文
        }else if([self.commentArr[indexPath.row][@"category"] intValue]==2){
            return [self.commentHeightArr[indexPath.row] floatValue]+109+(SCREEN_WIDTH-74.0)*163.0/292.0+16.0;//会员卡
        }else if([self.commentArr[indexPath.row][@"category"] intValue]==3){
            return 181+[self.commentHeightArr[indexPath.row] floatValue];//特价商品
        }else {
            return 202;
        }
    }else{
        return 50;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.popTableView) {
        for (int i=0; i<self.menuArr.count; i++) {
            if (i==indexPath.row) {
                [self.menuArr[indexPath.row] setObject:@(YES) forKey:@"isSel"];
            }else{
                [self.menuArr[i] setObject:@(NO) forKey:@"isSel"];
            }
        }
        [self.popTableView reloadData];
    }
}
#pragma mark -- privilegeCircleDelegate
-(void)circleLikeActionWithCellIndex:(NSInteger)cellRow AndLikeImageView:(UIImageView *)likeImageView
{
    [self likeWithIndexPath:cellRow AndLikeImageView:likeImageView];
}
-(void)circleHateActionWithCellIndex:(NSInteger)cellRow AndHateImageView:(UIImageView *)hateImageView
{
    [self hateWithIndexPath:cellRow AndLikeImageView:hateImageView];
}
-(void)circleCommentActionWithCellIndex:(NSInteger)cellRow
{
    [self commentWithIndexPath:cellRow];
}
-(void)circleAddCommentActionWithCellIndex:(NSInteger)cellRow AndCommentListCellRow:(NSInteger)commentListRow
{
    if (self.isAppear == YES) {
        return;
    }else if([[self.commentArr[cellRow][@"comment"][commentListRow] substringToIndex:[[[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"] length]] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"]]){
        return;
    }else{
        self.cellRow = cellRow;
        self.commentListRow = commentListRow+1;
        [self initWithTextField];
        [self.commentTextView becomeFirstResponder];
    }
}
-(void)circleDeleteComment:(UILongPressGestureRecognizer *)lpgr WithTableView:(UITableView *)tableView WithIndex:(NSInteger)cellRow
{
    [self DeleteComment:lpgr WithTableView:tableView WithIndex:cellRow];
}
-(void)circleDidWithIndex:(NSInteger)cellRow
{
    [TDApplicationUtil alertHud:[NSString stringWithFormat:@"第%ld个好文被点击",cellRow] afterDelay:0.8];
}
#pragma mark -- privilegeCardDelegate
-(void)cardLikeActionWithCellIndex:(NSInteger)cellRow AndLikeImageView:(UIImageView *)likeImageView
{
    [self likeWithIndexPath:cellRow AndLikeImageView:likeImageView];
}
-(void)cardHateActionWithCellIndex:(NSInteger)cellRow AndHateImageView:(UIImageView *)hateImageView
{
    [self hateWithIndexPath:cellRow AndLikeImageView:hateImageView];

}
-(void)cardCommentActionWithCellIndex:(NSInteger)cellRow
{
    [self commentWithIndexPath:cellRow];
}
-(void)cardAddCommentActionWithCellIndex:(NSInteger)cellRow AndCommentListCellRow:(NSInteger)commentListRow
{
    if (self.isAppear == YES) {
        return;
    }else if([[self.commentArr[cellRow][@"comment"][commentListRow] substringToIndex:[[[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"] length]] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"]]){
        return;
    }else{
        self.cellRow = cellRow;
        self.commentListRow = commentListRow+1;
        [self initWithTextField];
        [self.commentTextView becomeFirstResponder];
    }
}
-(void)cardDeleteComment:(UILongPressGestureRecognizer *)lpgr WithTableView:(UITableView *)tableView WithIndex:(NSInteger)cellRow
{
    [self DeleteComment:lpgr WithTableView:tableView WithIndex:cellRow];
}
-(void)cardDidWithIndex:(NSInteger)cellRow
{
   [TDApplicationUtil alertHud:[NSString stringWithFormat:@"第%ld个会员卡被点击",cellRow] afterDelay:0.8];
}
#pragma mark -- privilegeGoodsDelegate
-(void)goodsLikeActionWithCellIndex:(NSInteger)cellRow AndLikeImageView:(UIImageView *)likeImageView
{
   [self likeWithIndexPath:cellRow AndLikeImageView:likeImageView];
}
-(void)goodsHateActionWithCellIndex:(NSInteger)cellRow AndHateImageView:(UIImageView *)hateImageView
{
    [self hateWithIndexPath:cellRow AndLikeImageView:hateImageView];
}
-(void)goodsCommentActionWithCellIndex:(NSInteger)cellRow
{
    [self commentWithIndexPath:cellRow];
}
-(void)goodsAddCommentActionWithCellIndex:(NSInteger)cellRow AndCommentListCellRow:(NSInteger)commentListRow
{
    if (self.isAppear == YES) {
        return;
    }else if([[self.commentArr[cellRow][@"comment"][commentListRow] substringToIndex:[[[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"] length]] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"]]){
        return;
    }else{
        self.cellRow = cellRow;
        self.commentListRow = commentListRow+1;
        [self initWithTextField];
        [self.commentTextView becomeFirstResponder];
    }

}
-(void)goodsDeleteComment:(UILongPressGestureRecognizer *)lpgr WithTableView:(UITableView *)tableView WithIndex:(NSInteger)cellRow
{
    [self DeleteComment:lpgr WithTableView:tableView WithIndex:cellRow];
}
-(void)goodsDidWithIndex:(NSInteger)cellRow
{
   [TDApplicationUtil alertHud:[NSString stringWithFormat:@"第%ld个商品被点击",cellRow] afterDelay:0.8];
}
#pragma mark -- 赞/踩/评论/追加评论/删除 封装的方法
//赞方法
-(void)likeWithIndexPath:(NSInteger)cellRow AndLikeImageView:(UIImageView *)likeImageView
{
    if ([self.commentArr[cellRow][@"haveLike"] boolValue]==YES) {
        [TDApplicationUtil alertHud:@"已经赞过了,不能再赞了" afterDelay:0.5];
        return;
    }else if([self.commentArr[cellRow][@"haveHate"] boolValue]==YES){
        [TDApplicationUtil alertHud:@"已经踩过了,不能再赞了" afterDelay:0.5];
        return;
    }else{
        [self.commentArr[cellRow] setObject:@([self.commentArr[cellRow][@"likeCount"] intValue]+1) forKey:@"likeCount"];
        [self.commentArr[cellRow] setObject:@(YES) forKey:@"haveLike"];
        likeImageView.image = [UIImage imageNamed:@"d-zan"];
        [self.tableView reloadData];
    }
}
//踩方法
-(void)hateWithIndexPath:(NSInteger)cellRow AndLikeImageView:(UIImageView *)hateImageView
{
    if ([self.commentArr[cellRow][@"haveHate"] boolValue]==YES) {
        [TDApplicationUtil alertHud:@"已经踩过了,不能再踩了" afterDelay:0.5];
        return;
    }else if([self.commentArr[cellRow][@"haveLike"] boolValue]==YES){
        [TDApplicationUtil alertHud:@"已经赞过了,不能再踩了" afterDelay:0.5];
        return;
    }else{
        [self.commentArr[cellRow] setObject:@([self.commentArr[cellRow][@"hateCount"] intValue]+1) forKey:@"hateCount"];
        [self.commentArr[cellRow] setObject:@(YES) forKey:@"haveHate"];
        hateImageView.image = [UIImage imageNamed:@"d-daozan"];
        [self.tableView reloadData];
    }
}
//评论方法
-(void)commentWithIndexPath:(NSInteger)cellRow
{
    if (self.isAppear == YES) {
        return;
    }else{
        self.cellRow = cellRow;
        [self initWithTextField];
        [self.commentTextView becomeFirstResponder];
    }
}

//删除方法
-(void)DeleteComment:(UILongPressGestureRecognizer *)lpgr WithTableView:(UITableView *)tableView WithIndex:(NSInteger)cellRow
{
       if (lpgr.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [lpgr locationInView:tableView];
        NSIndexPath *indexPath_ = [tableView indexPathForRowAtPoint:point];
        if ([self.commentArr[cellRow][@"comment"][indexPath_.row] hasPrefix:[[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"]]) {
            [self.commentArr[cellRow][@"comment"] removeObjectAtIndex:indexPath_.row];
            CGFloat contentHeight = 0;
            for (int i=0; i<[self.commentArr[cellRow] count]; i++) {
                contentHeight +=[LJKHelper textHeightFromTextString:self.commentArr[cellRow][@"comment"][i] width:SCREEN_WIDTH-76 fontSize:12]*1.5;
            }
            [self.commentHeightArr replaceObjectAtIndex:cellRow withObject:@(contentHeight)];
            [self.tableView reloadData];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
