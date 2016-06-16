//
//  OwnerShopCouponGoodsCell.m
//  infoPromotionClient
//
//  Created by imac on 15/12/21.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "OwnerShopCouponGoodsCell.h"
#import "CouponCircleSubCell.h"
@implementation OwnerShopCouponGoodsCell{

    __weak IBOutlet UILabel *_dayLabel;//日期
    
    __weak IBOutlet UIImageView *_goodsImageView;
    __weak IBOutlet UILabel *_goodsNameLabel;
    
    __weak IBOutlet UILabel *_currentPriceLabel;

    __weak IBOutlet UILabel *_originalPriceLabel;
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
-(void)showCellWithCommentData:(NSArray *)commentArr AndLike:(int)like AndHate:(int)hate
{
    if (commentArr.count == 0) {
        _triangleImageView.hidden = YES;
    }else{
        _triangleImageView.hidden = NO;
    }
    self.commentArr = commentArr;
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
    return [LJKHelper textHeightFromTextString:self.commentArr[indexPath.row] width:self.frame.size.width-76 fontSize:12]*1.5;;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponCircleSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponCircleSubCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    lpgr.minimumPressDuration = 1;
    [cell addGestureRecognizer:lpgr];
    [cell showDataWithText:self.commentArr[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate goodsAddCommentActionWithCellIndex:self.cellRow AndCommentListCellRow:indexPath.row];
}
-(void)longPress:(UILongPressGestureRecognizer *)lpgr
{
    [self.delegate goodsDeleteComment:lpgr WithTableView:_commentTableView WithIndex:self.cellRow];
}
- (IBAction)likeAction:(id)sender {
    
    [self.delegate goodsLikeActionWithCellIndex:self.cellRow AndLikeImageView:_likeImageView];
}
- (IBAction)hateAction:(id)sender {
    [self.delegate goodsHateActionWithCellIndex:self.cellRow AndHateImageView:_hateImageView];
}
- (IBAction)commentAction:(id)sender {
    [self.delegate goodsCommentActionWithCellIndex:self.cellRow];
}
- (IBAction)goodsDidSelectedAction:(id)sender {
    [self.delegate goodsDidWithIndex:self.cellRow];
}

@end
