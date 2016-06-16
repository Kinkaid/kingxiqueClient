//
//  OwnerShopCouponCardCell.m
//  infoPromotionClient
//
//  Created by imac on 15/12/21.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "OwnerShopCouponCardCell.h"
#import "CouponCircleSubCell.h"
#import "ShopVipCardCell.h"
extern CGFloat SCREEN_HEIGHT;
extern CGFloat SCREEN_WIDTH;
@implementation OwnerShopCouponCardCell{
    
    __weak IBOutlet UILabel *_dayLabel;

    __weak IBOutlet UITableView *_cardTableView;
    
    __weak IBOutlet UIImageView *_likeImageView;
    
    __weak IBOutlet UILabel *_likeCountLabel;
    
    __weak IBOutlet UIImageView *_hateImageView;
    
    __weak IBOutlet UILabel *_hateCountLabel;
    __weak IBOutlet UIImageView *_commentImageView;
    __weak IBOutlet UILabel *_commentCountLabel;
    
    __weak IBOutlet UIImageView *_triangleImageView;
    
    __weak IBOutlet UITableView *_commentTableView;
    
    __weak IBOutlet NSLayoutConstraint *_cardHeight;
    
}

- (void)awakeFromNib {
    // Initialization code
    _cardHeight.constant = (SCREEN_WIDTH-64.0)*163.0/292.0+16.0;
    [self initWithTableView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showCellWithCommentData:(NSArray *)commentArr AndLike:(int)like AndHate:(int)hate;
{
    if (commentArr.count == 0) {
        _triangleImageView.hidden = YES;
    }else{
        _triangleImageView.hidden = NO;
    }
    _commentArr = commentArr;
    _likeCountLabel.text = [NSString stringWithFormat:@"%d",like];
    _hateCountLabel.text = [NSString stringWithFormat:@"%d",hate];
    [_commentTableView reloadData];
}
-(void)showDataWithDic:(NSDictionary *)dic
{
    _commentArr = dic[@"comment"];
    if (_commentArr.count) {
        _triangleImageView.hidden = NO;
    }else{
        _triangleImageView.hidden = YES;
    }
    _likeCountLabel.text = [NSString stringWithFormat:@"%d",[dic[@"likeCount"] intValue]];
    _hateCountLabel.text = [NSString stringWithFormat:@"%d",[dic[@"hateCount"] intValue]];
    if ([dic[@"haveLike"] boolValue]==YES) {
        _likeImageView.image = [UIImage imageNamed:@"d-zan"];
    }else{
        _likeImageView.image = [UIImage imageNamed:@"zan"];
    }
    if ([dic[@"haveHate"] boolValue]==NO) {
        _hateImageView.image = [UIImage imageNamed:@"cai"];
    }else{
        _hateImageView.image = [UIImage imageNamed:@"d-daozan"];
    }
    [_commentTableView reloadData];
}
-(void)initWithTableView
{
    [_commentTableView registerNib:[UINib nibWithNibName:@"CouponCircleSubCell" bundle:nil] forCellReuseIdentifier:@"CouponCircleSubCell"];
    [_cardTableView registerNibByCellId:@"ShopVipCardCell"];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.scrollEnabled = NO;
    _cardTableView.delegate = self;
    _cardTableView.dataSource = self;
    _cardTableView.scrollEnabled = NO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _commentTableView) {
        return [LJKHelper textHeightFromTextString:_commentArr[indexPath.row] width:SCREEN_WIDTH-76.0 fontSize:12]*1.5;
    }else{
        return (SCREEN_WIDTH-64.0)*163.0/292.0+16.0;
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _commentTableView) {
        CouponCircleSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponCircleSubCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        lpgr.minimumPressDuration = 1;
        [cell addGestureRecognizer:lpgr];
        [cell showDataWithText:_commentArr[indexPath.row]];
        return cell;
    }else{
        ShopVipCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopVipCardCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _cardTableView) {
        [_delegate cardDidWithIndex:_cellRow];//点击会员卡
    }else{
        [_delegate cardAddCommentActionWithCellIndex:_cellRow AndCommentListCellRow:indexPath.row];
    }
}
-(void)longPress:(UILongPressGestureRecognizer*)lpgr
{
    [self.delegate cardDeleteComment:lpgr WithTableView:_commentTableView WithIndex:self.cellRow];
}
//赞
- (IBAction)likeAction:(id)sender {
    [_delegate cardLikeActionWithCellIndex:self.cellRow AndLikeImageView:_likeImageView];
}
//踩
- (IBAction)cai:(id)sender {
    [_delegate cardHateActionWithCellIndex:self.cellRow AndHateImageView:_hateImageView];
}
//评论
- (IBAction)commentAction:(id)sender {
    [_delegate cardCommentActionWithCellIndex:self.cellRow];
}

@end
