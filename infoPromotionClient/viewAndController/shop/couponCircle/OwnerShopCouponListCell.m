//
//  OwnerShopCouponListCell.m
//  infoPromotionClient
//
//  Created by imac on 15/12/21.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "OwnerShopCouponListCell.h"
#import "CouponCircleSubCell.h"
extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
@implementation OwnerShopCouponListCell{

    __weak IBOutlet UILabel *_dayLabel;

    __weak IBOutlet UITableView *_couponTableView;
    __weak IBOutlet NSLayoutConstraint *_couponHeight;
    
    __weak IBOutlet UIImageView *_likeImageView;
    
    __weak IBOutlet UILabel *_likeCountLabel;
    
    __weak IBOutlet UIImageView *_hateImageView;
    
    __weak IBOutlet UILabel *_hateCountLabel;
    
    __weak IBOutlet UIImageView *_commentImageView;
    __weak IBOutlet UILabel *_commentCountLabel;
    
    __weak IBOutlet UIImageView *_triangleImageView;
    __weak IBOutlet UITableView *_commentTableView;
}

- (void)awakeFromNib {
    // Initialization code
    [self initWithTableView];
}
-(void)showCellWithCommentData:(NSArray *)commentArr AndLike:(int)like AndHate:(int)hate
{
    if (commentArr.count) {
        _triangleImageView.hidden = NO;
    }else{
        _triangleImageView.hidden = YES;
    }
    _likeCountLabel.text = [NSString stringWithFormat:@"%d",like];
    _hateCountLabel.text  = [NSString stringWithFormat:@"%d",hate];
    self.commentArr = commentArr;
    [_commentTableView reloadData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    if (tableView == _commentTableView) {
        return [LJKHelper textHeightFromTextString:self.commentArr[indexPath.row] width:SCREEN_WIDTH-76 fontSize:12]*1.5;
    }else{
        return 88;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _commentTableView) {
        return self.commentArr.count;
    }else{
        return 1;
    }
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
    [self.delegate listAddCommentActionWithCellIndex:self.indexPath];
}
-(void)longPress:(UILongPressGestureRecognizer *)lpgr
{
    [self.delegate listDeleteComment:lpgr WithTabelView:_commentTableView WithIndex:self.indexPath];
}
- (IBAction)likeAction:(id)sender {
    
    [self.delegate listLikeActionWithCellIndex:self.indexPath WithImage:_likeImageView];
}
- (IBAction)hateAction:(id)sender {
    [self.delegate listHateActionWithCellIndex:self.indexPath WithImage:_hateImageView];
}
- (IBAction)commentAction:(id)sender {
    [self.delegate listCommentActionWithCellIndex:self.indexPath];
}
@end
