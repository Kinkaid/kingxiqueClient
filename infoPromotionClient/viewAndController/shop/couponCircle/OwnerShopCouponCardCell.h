//
//  OwnerShopCouponCardCell.h
//  infoPromotionClient
//
//  Created by imac on 15/12/21.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CouponCardDelegate <NSObject>

-(void)cardLikeActionWithCellIndex:(NSInteger)cellRow AndLikeImageView:(UIImageView *)likeImageView;
-(void)cardHateActionWithCellIndex:(NSInteger)cellRow AndHateImageView:(UIImageView *)hateImageView;
-(void)cardCommentActionWithCellIndex:(NSInteger)cellRow;
-(void)cardAddCommentActionWithCellIndex:(NSInteger)cellRow AndCommentListCellRow:(NSInteger)commentListRow;
-(void)cardDeleteComment:(UILongPressGestureRecognizer *)lpgr WithTableView:(UITableView *)tableView WithIndex:(NSInteger)cellRow;
-(void)cardDidWithIndex:(NSInteger)cellRow;

@end

@interface OwnerShopCouponCardCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic)NSInteger cellRow;

@property (nonatomic,strong)id<CouponCardDelegate>delegate;

@property (nonatomic,strong)NSArray *commentArr;

-(void)showCellWithCommentData:(NSArray *)commentArr AndLike:(int)like AndHate:(int)hate;
-(void)showDataWithDic:(NSDictionary *)dic;

@end
