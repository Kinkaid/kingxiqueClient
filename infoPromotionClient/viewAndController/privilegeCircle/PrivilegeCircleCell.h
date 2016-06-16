//
//  PrivilegeCircleCell.h
//  infoPromotionClient
//
//  Created by imac on 16/1/4.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PrivilegeCircleDelegate <NSObject>

-(void)circleLikeActionWithCellIndex:(NSInteger)cellRow AndLikeImageView:(UIImageView *)likeImageView;
-(void)circleHateActionWithCellIndex:(NSInteger)cellRow AndHateImageView:(UIImageView *)hateImageView;
-(void)circleCommentActionWithCellIndex:(NSInteger)cellRow;
-(void)circleAddCommentActionWithCellIndex:(NSInteger)cellRow AndCommentListCellRow:(NSInteger)commentListRow;
-(void)circleDeleteComment:(UILongPressGestureRecognizer *)lpgr WithTableView:(UITableView *)tableView WithIndex:(NSInteger)cellRow;
-(void)circleDidWithIndex:(NSInteger)cellRow;
@end

@interface PrivilegeCircleCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *commentArr;
@property (nonatomic)NSInteger cellRow;
@property (nonatomic,strong)id<PrivilegeCircleDelegate>delegate;

-(void)showDataWithDic:(NSDictionary *)dic;
@end
