//
//  OwnerShopCouponCircleCell.m
//  infoPromotionClient
//
//  Created by imac on 15/12/21.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "OwnerShopCouponCircleCell.h"
#import "CouponCircleSubCell.h"
@implementation OwnerShopCouponCircleCell{

    __weak IBOutlet UILabel *_dayLabel;

    __weak IBOutlet UILabel *_lastTimeLabel;

    __weak IBOutlet UIImageView *_circleImageView;
    
    __weak IBOutlet UILabel *_circleTitleLabel;
    
    __weak IBOutlet UIImageView *_likeImageView;
    
    __weak IBOutlet UILabel *_likeCountLabel;
    
    __weak IBOutlet UIImageView *_hateImageView;
    
    __weak IBOutlet UILabel *_hateCountLabel;
    
    __weak IBOutlet UIImageView *_commentImageView;
    
    __weak IBOutlet UILabel *_commentCountLabel;
    
    __weak IBOutlet UITableView *_commentTableView;
    
    __weak IBOutlet UIImageView *_triangleImageView;
}

- (void)awakeFromNib {
    // Initialization code
   [self initWithTableView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)showCellWithCommentData:(NSMutableArray *)commentArr AndLike:(int)like AndHate:(int)hate
{
    self.commentArr = commentArr;
    if (commentArr.count == 0) {
        _triangleImageView.hidden = YES;
    }else{
        _triangleImageView.hidden = NO;
    }
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
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.scrollEnabled = NO;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LJKHelper textHeightFromTextString:self.commentArr[indexPath.row] width:self.frame.size.width-76 fontSize:12]*1.5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponCircleSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponCircleSubCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showDataWithText:self.commentArr[indexPath.row]];
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    lpgr.minimumPressDuration = 1;
    [cell addGestureRecognizer:lpgr];
    return cell;
}
-(void)longPress:(UILongPressGestureRecognizer *)lpgr
{
    [self.delegate circleDeleteComment:lpgr WithTableView:_commentTableView WithIndex:self.cellRow];
    [_commentTableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //增加评论
    [self.delegate circleAddCommentActionWithCellIndex:self.cellRow AndCommentListCellRow:indexPath.row];
}
//赞
- (IBAction)likeAction:(id)sender {
    [self.delegate circleLikeActionWithCellIndex:self.cellRow AndLikeImageView:_likeImageView];

}
//踩
- (IBAction)hateAction:(id)sender {
    [self.delegate circleHateActionWithCellIndex:self.cellRow AndHateImageView:_hateImageView];
}
//评论
- (IBAction)commentAction:(id)sender {
    [self.delegate circleCommentActionWithCellIndex:self.cellRow];
}
- (IBAction)articleDidSelectedAction:(id)sender {
    [self.delegate circleDidWithIndex:self.cellRow];
}

@end
