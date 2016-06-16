//
//  PrivilegeCardCell.m
//  infoPromotionClient
//
//  Created by imac on 16/1/4.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "PrivilegeCardCell.h"
#import "ShopVipCardCell.h"
#import "PrivilegeCommentCell.h"
extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
@implementation PrivilegeCardCell{
    __weak IBOutlet UIImageView *_headerImageView;//头像
    __weak IBOutlet UILabel *_shopNameLabel;//店名
    __weak IBOutlet UILabel *_addressLabel;//地址
    __weak IBOutlet UILabel *_dateLabel;//时间日期
    __weak IBOutlet UILabel *_distanceLabel;//距离
    __weak IBOutlet UIImageView *_starImageView;//星级
    __weak IBOutlet UILabel *_ifCollectionLabel;//是否收藏
    __weak IBOutlet UILabel *_ifConsumeLabel;//是否消费
    __weak IBOutlet UIImageView *_likeImageView;//赞
    __weak IBOutlet UILabel *_likeCountLabel;//赞数量
    __weak IBOutlet UIImageView *_hateImageView;//踩
    __weak IBOutlet UILabel *_hateCountLabel;//踩数量
    __weak IBOutlet UIImageView *_commentImageView;//评论
    __weak IBOutlet UILabel *_commentCountLabel;//评论数量
    __weak IBOutlet UIImageView *_sanjiaoImageView;//三角符号
    __weak IBOutlet UITableView *_cardTableView;
    __weak IBOutlet UITableView *_commentTableView;
    __weak IBOutlet NSLayoutConstraint *_cardTableViewHeight;
}

- (void)awakeFromNib {
    // Initialization code
    [self initWithTableView];
}
-(void)showDataWithDic:(NSDictionary *)dic
{
    _commentArr = dic[@"comment"];
    if (_commentArr.count) {
        _sanjiaoImageView.hidden = NO;
    }else{
        _sanjiaoImageView.hidden = YES;
    }
    _likeCountLabel.text = [NSString stringWithFormat:@"%d",[dic[@"likeCount"] intValue]];
    _hateCountLabel.text = [NSString stringWithFormat:@"%d",[dic[@"hateCount"] intValue]];
    if ([dic[@"haveLike"] boolValue]==NO) {
        _likeImageView.image = [UIImage imageNamed:@"zan"];
    }else{
        _likeImageView.image = [UIImage imageNamed:@"d-zan"];
    }
    if ([dic[@"haveHate"] boolValue]==NO) {
        _hateImageView.image = [UIImage imageNamed:@"cai"];
    }else{
        _hateImageView.image = [UIImage imageNamed:@"d-daozan"];
    }
    [_commentTableView reloadData];

}
- (void)initWithTableView
{
    [_cardTableView registerNibByCellId:@"ShopVipCardCell"];
    [_commentTableView registerNibByCellId:@"PrivilegeCommentCell"];
    _cardTableViewHeight.constant =(SCREEN_WIDTH-74.0)*163.0/292.0+16.0;
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _cardTableView.delegate = self;
    _cardTableView.dataSource = self;
    _commentTableView.scrollEnabled = NO;
    _cardTableView.scrollEnabled = NO;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _commentTableView) {
        PrivilegeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrivilegeCommentCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        lpgr.minimumPressDuration = 1;
        [cell addGestureRecognizer:lpgr];
        [cell showDataWithText:_commentArr[indexPath.row]];
        return cell;
    }else{
        ShopVipCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopVipCardCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _commentTableView) {
        return [LJKHelper textHeightFromTextString:_commentArr[indexPath.row] width:SCREEN_WIDTH-79 fontSize:12]*1.5;
    }else{
        return (SCREEN_WIDTH-74.0)*163.0/292.0+16.0;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _cardTableView) {
        [_delegate cardDidWithIndex:_cellRow];//点击会员卡
    }else{
        [_delegate cardAddCommentActionWithCellIndex:_cellRow AndCommentListCellRow:(NSInteger)indexPath.row];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _commentTableView) {
        return _commentArr.count;
    }else{
        return 1;
    }
}
-(void)longPress:(UILongPressGestureRecognizer *)lpgr
{
    [_delegate cardDeleteComment:lpgr WithTableView:_commentTableView WithIndex:_cellRow];
}
//赞
- (IBAction)likeAction:(id)sender {
    [_delegate cardLikeActionWithCellIndex:_cellRow AndLikeImageView:_likeImageView];
}
//踩
- (IBAction)hateAction:(id)sender {
    [_delegate cardHateActionWithCellIndex:_cellRow AndHateImageView:_hateImageView];
}
//评论
- (IBAction)commentAction:(id)sender {
    [_delegate cardCommentActionWithCellIndex:_cellRow];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
