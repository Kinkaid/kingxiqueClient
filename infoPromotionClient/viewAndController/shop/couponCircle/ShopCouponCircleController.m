//
//  ShopCouponCircleController.m
//  infoPromotionClient
//
//  Created by zhujingci on 16/3/2.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "ShopCouponCircleController.h"
#import "OwnerShopCouponCircleCell.h"
#import "OwnerShopCouponCardCell.h"
#import "OwnerShopCouponGoodsCell.h"
#import "OwnerShopCouponListCell.h"
extern CGFloat SCREEN_HEIGHT;
extern CGFloat SCREEN_WIDTH;
@interface ShopCouponCircleController ()<UITableViewDataSource,UITableViewDelegate,CouponCircleDelegate,CouponCardDelegate,CouponGoodsDelegate,UITextViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UIView *CommentView;
@property (nonatomic)BOOL isAppear;

@property (strong,nonatomic)UITextView *commentTextView;
@property (nonatomic,strong)NSMutableArray *commentArr;
@property (nonatomic,strong)NSMutableArray *likeArr;
@property (nonatomic,strong)NSMutableArray *haveLikeArr;
@property (nonatomic,strong)NSMutableArray *hateArr;
@property (nonatomic,strong)NSMutableArray *haveHateArr;
@property (nonatomic)NSInteger cellRow;
@property (nonatomic)NSInteger commentListRow;
@property (nonatomic,strong)NSMutableArray *commentHeightArr;
@end

@implementation ShopCouponCircleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNotification];
    [self initWithTableView];
    [self loadData];
   
    // Do any additional setup after loading the view from its nib.
}
-(void)registerNotification//注册通知
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardAppearance:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector (textViewChange:)name:UITextViewTextDidChangeNotification object:_commentTextView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)initWithTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"OwnerShopCouponCircleCell" bundle:nil] forCellReuseIdentifier:@"OwnerShopCouponCircleCell"];//文章cell
    [self.tableView registerNib:[UINib nibWithNibName:@"OwnerShopCouponGoodsCell" bundle:nil] forCellReuseIdentifier:@"OwnerShopCouponGoodsCell"];//商品cell
    [self.tableView registerNib:[UINib nibWithNibName:@"OwnerShopCouponCardCell" bundle:nil] forCellReuseIdentifier:@"OwnerShopCouponCardCell"];//会员卡cell
    [self.tableView registerNib:[UINib nibWithNibName:@"OwnerShopCouponListCell" bundle:nil] forCellReuseIdentifier:@"OwnerShopCouponListCell"];//优惠券cell
    
}
-(void)loadData//下载数据
{
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
-(void)initWithTextField
{
   
    //实例化输入框
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.commentArr[indexPath.row][@"category"] intValue]==1) {
        return 124+[self.commentHeightArr[indexPath.row] floatValue];
    }else if([self.commentArr[indexPath.row][@"category"] intValue]==2){
        return [self.commentHeightArr[indexPath.row] floatValue]+39+(SCREEN_WIDTH-64)*163.0/292.0+16.0;
    }else if([self.commentArr[indexPath.row][@"category"] intValue]==3){
        return 119+[self.commentHeightArr[indexPath.row] floatValue];
    }else{
        return 132+[self.commentHeightArr[indexPath.row] floatValue];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.commentArr[indexPath.row][@"category"] intValue]==1) {
        OwnerShopCouponCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OwnerShopCouponCircleCell" forIndexPath:indexPath];
         cell.delegate = self;
         cell.cellRow = indexPath.row;
        [cell showDataWithDic:self.commentArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if([self.commentArr[indexPath.row][@"category"] intValue]==2){
        OwnerShopCouponCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OwnerShopCouponCardCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.cellRow = indexPath.row;
        [cell showDataWithDic:self.commentArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        OwnerShopCouponGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OwnerShopCouponGoodsCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.cellRow = indexPath.row;
        [cell showDataWithDic:self.commentArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
        [TDApplicationUtil alertHud:@"你已经赞过了,不能再赞了" afterDelay:0.5];
        return;
    }else if([self.commentArr[cellRow][@"haveHate"] boolValue]==YES){
        [TDApplicationUtil alertHud:@"你已经踩过了,不能再赞了" afterDelay:0.5];
        return;
    }else{
        [self.commentArr[cellRow] setObject:@([self.commentArr[cellRow][@"likeCount"] intValue]+1) forKey:@"likeCount"];
        [self.commentArr[cellRow] setObject:@(YES) forKey:@"haveLike"];
        [self.haveLikeArr replaceObjectAtIndex:cellRow withObject:@(YES)];
        likeImageView.image = [UIImage imageNamed:@"d-zan"];
        [self.tableView reloadData];
    }
}
//踩方法
-(void)hateWithIndexPath:(NSInteger)cellRow AndLikeImageView:(UIImageView *)hateImageView
{
    if ([self.commentArr[cellRow][@"haveLike"] boolValue]==YES) {
        [TDApplicationUtil alertHud:@"你已经赞过了,不能再踩了" afterDelay:0.5];
        return;
    }else if([self.commentArr[cellRow][@"haveHate"] boolValue]==YES){
        [TDApplicationUtil  alertHud:@"你已经踩过了,不能再踩了" afterDelay:0.5];
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
            for (int i=0; i<[self.commentArr[cellRow][@"comment"] count]; i++) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
