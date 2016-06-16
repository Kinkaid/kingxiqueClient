//
//  OwnerShopCouponCircleCell.h
//  infoPromotionClient
//
//  Created by imac on 15/12/21.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CouponCircleDelegate <NSObject>

-(void)circleLikeActionWithCellIndex:(NSInteger)cellRow AndLikeImageView:(UIImageView *)likeImageView;
-(void)circleHateActionWithCellIndex:(NSInteger)cellRow AndHateImageView:(UIImageView *)hateImageView;
-(void)circleCommentActionWithCellIndex:(NSInteger)cellRow;
-(void)circleAddCommentActionWithCellIndex:(NSInteger)cellRow AndCommentListCellRow:(NSInteger)commentListRow;
-(void)circleDeleteComment:(UILongPressGestureRecognizer *)lpgr WithTableView:(UITableView *)tableView WithIndex:(NSInteger)cellRow;
-(void)circleDidWithIndex:(NSInteger)cellRow;
@end

@interface OwnerShopCouponCircleCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic)NSInteger cellRow;
@property (nonatomic,strong)NSMutableArray *commentArr;
@property (nonatomic,strong)id<CouponCircleDelegate>delegate;

-(void)showCellWithCommentData:(NSArray *)commentArr AndLike:(int)like AndHate:(int)hate;
-(void)showDataWithDic:(NSDictionary *)dic;
@end
