//
//  PrivilegeCardCell.h
//  infoPromotionClient
//
//  Created by imac on 16/1/4.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PrivilegeCardDelegate <NSObject>

-(void)cardLikeActionWithCellIndex:(NSInteger)cellRow AndLikeImageView:(UIImageView *)likeImageView;
-(void)cardHateActionWithCellIndex:(NSInteger)cellRow AndHateImageView:(UIImageView *)hateImageView;
-(void)cardCommentActionWithCellIndex:(NSInteger)cellRow;
-(void)cardAddCommentActionWithCellIndex:(NSInteger)cellRow AndCommentListCellRow:(NSInteger)commentListRow;
-(void)cardDeleteComment:(UILongPressGestureRecognizer *)lpgr WithTableView:(UITableView *)tableView WithIndex:(NSInteger)cellRow;
-(void)cardDidWithIndex:(NSInteger)cellRow;

@end

@interface PrivilegeCardCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *commentArr;
@property (nonatomic)NSInteger cellRow;
@property (nonatomic,strong)id<PrivilegeCardDelegate>delegate;

-(void)showDataWithDic:(NSDictionary *)dic;
@end
