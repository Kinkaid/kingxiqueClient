//
//  PrivilegeGoodsCell.h
//  infoPromotionClient
//
//  Created by imac on 16/1/4.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PrivilegeGoodsDelegate <NSObject>

-(void)goodsLikeActionWithCellIndex:(NSInteger)cellRow AndLikeImageView:(UIImageView *)likeImageView;
-(void)goodsHateActionWithCellIndex:(NSInteger)cellRow AndHateImageView:(UIImageView *)hateImageView;
-(void)goodsCommentActionWithCellIndex:(NSInteger)cellRow;
-(void)goodsAddCommentActionWithCellIndex:(NSInteger)cellRow AndCommentListCellRow:(NSInteger)commentListRow;
-(void)goodsDeleteComment:(UILongPressGestureRecognizer *)lpgr WithTableView:(UITableView *)tableView WithIndex:(NSInteger)cellRow;
-(void)goodsDidWithIndex:(NSInteger)cellRow;

@end

@interface PrivilegeGoodsCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *commentArr;
@property (nonatomic)NSInteger cellRow;
@property (nonatomic,strong)id<PrivilegeGoodsDelegate>delegate;

-(void)showDataWithDic:(NSDictionary *)dic;
@end
