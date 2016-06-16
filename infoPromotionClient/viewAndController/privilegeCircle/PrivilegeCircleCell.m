//
//  PrivilegeCircleCell.m
//  infoPromotionClient
//
//  Created by imac on 16/1/4.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "PrivilegeCircleCell.h"
#import "PrivilegeCommentCell.h"
@implementation PrivilegeCircleCell{
    __weak IBOutlet UIImageView *_headerImageView;//头像
    __weak IBOutlet UILabel *_shopNameLabel;//店名
    __weak IBOutlet UILabel *_addressLabel;//地址
    __weak IBOutlet UILabel *_dateLabel;//时间日期
    __weak IBOutlet UILabel *_distanceLabel;//距离
    __weak IBOutlet UIImageView *_starImageView;//星级
    __weak IBOutlet UILabel *_ifCollectionLabel;//是否收藏
    __weak IBOutlet UILabel *_ifConsumeLabel;//是否消费
    __weak IBOutlet UIImageView *_articleImageView;//贴文图片
    __weak IBOutlet UILabel *_articleTitleLabel;//贴文标题
    __weak IBOutlet UIImageView *_likeImageView;//赞
    __weak IBOutlet UILabel *_likeCountLabel;//赞数量
    __weak IBOutlet UIImageView *_hateImageView;//踩
    __weak IBOutlet UILabel *_hateCountLabel;//踩数量
    __weak IBOutlet UIImageView *_commentImageView;//评论
    __weak IBOutlet UILabel *_commentCountLabel;//评论数量
    __weak IBOutlet UIImageView *_sanjiaoImageView;//三角符号
    __weak IBOutlet UITableView *_commentTableView;
    
}

- (void)awakeFromNib {
    // Initialization code
    [self initWithTableView];
}
-(void)initWithTableView
{
    [_commentTableView registerNibByCellId:@"PrivilegeCommentCell"];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.scrollEnabled = NO;
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

#pragma mark --tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrivilegeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrivilegeCommentCell" forIndexPath:indexPath];
    [cell showDataWithText:_commentArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    lpgr.minimumPressDuration = 1;
    [cell addGestureRecognizer:lpgr];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LJKHelper textHeightFromTextString:_commentArr[indexPath.row] width:self.frame.size.width-79 fontSize:12]*1.5;;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return _commentArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate circleAddCommentActionWithCellIndex:_cellRow AndCommentListCellRow:indexPath.row];
}
-(void)longPress:(UILongPressGestureRecognizer *)lgpr
{
    [_delegate circleDeleteComment:lgpr WithTableView:_commentTableView WithIndex:_cellRow];
    [_commentTableView reloadData];
}
//赞
- (IBAction)likeAction:(id)sender {
    [_delegate circleLikeActionWithCellIndex:_cellRow AndLikeImageView:_likeImageView];
}
//踩
- (IBAction)hateAction:(id)sender {
    [_delegate circleHateActionWithCellIndex:_cellRow AndHateImageView:_hateImageView];
}
//评论
- (IBAction)commentAction:(id)sender {
    [_delegate circleCommentActionWithCellIndex:_cellRow];
}
//点击文章内容
- (IBAction)circleDidAction:(id)sender {
    [_delegate circleDidWithIndex:_cellRow];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
