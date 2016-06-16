//
//  OwnerShopCouponListCell.h
//  infoPromotionClient
//
//  Created by imac on 15/12/21.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CouponListDelegate <NSObject>

-(void)listLikeActionWithCellIndex:(NSIndexPath*)indexPath WithImage:(UIImageView*)likeImageView;;
-(void)listHateActionWithCellIndex:(NSIndexPath *)indexPath WithImage:(UIImageView*)hateImageView;;
-(void)listCommentActionWithCellIndex:(NSIndexPath *)indexPath;
-(void)listAddCommentActionWithCellIndex:(NSIndexPath *)indexPath;
-(void)listDeleteComment:(UILongPressGestureRecognizer*)lpgr WithTabelView:(UITableView *)tableView WithIndex:(NSIndexPath *)indexPath;
@end
@interface OwnerShopCouponListCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *commentArr;
@property (nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic,strong)id<CouponListDelegate>delegate;
-(void)showCellWithCommentData:(NSArray *)commentArr AndLike:(int)like AndHate:(int)hate;
@end
