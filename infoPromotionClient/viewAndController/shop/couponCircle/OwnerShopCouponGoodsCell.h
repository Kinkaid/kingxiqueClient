//
//  OwnerShopCouponGoodsCell.h
//  infoPromotionClient
//
//  Created by imac on 15/12/21.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CouponGoodsDelegate <NSObject>

-(void)goodsLikeActionWithCellIndex:(NSInteger)cellRow AndLikeImageView:(UIImageView *)likeImageView;
-(void)goodsHateActionWithCellIndex:(NSInteger)cellRow AndHateImageView:(UIImageView *)hateImageView;
-(void)goodsCommentActionWithCellIndex:(NSInteger)cellRow;
-(void)goodsAddCommentActionWithCellIndex:(NSInteger)cellRow AndCommentListCellRow:(NSInteger)commentListRow;
-(void)goodsDeleteComment:(UILongPressGestureRecognizer *)lpgr WithTableView:(UITableView *)tableView WithIndex:(NSInteger)cellRow;
-(void)goodsDidWithIndex:(NSInteger)cellRow;


@end

@interface OwnerShopCouponGoodsCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic)NSInteger cellRow;

@property (nonatomic,strong)NSArray *commentArr;
@property (nonatomic,strong)id<CouponGoodsDelegate>delegate;
-(void)showCellWithCommentData:(NSArray *)commentArr AndLike:(int)like AndHate:(int)hate;
-(void)showDataWithDic:(NSDictionary *)dic;
@end
