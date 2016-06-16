//
//  PrivilegeListCell.h
//  infoPromotionClient
//
//  Created by imac on 16/1/4.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivilegeListCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
//店名
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
//地址
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
//时间日期
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//距离
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
//星级
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
//是否消费
@property (weak, nonatomic) IBOutlet UILabel *ifConsumeLabel;
//是否已收藏
@property (weak, nonatomic) IBOutlet UILabel *ifCollectionLabel;
//赞
@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;
//踩
@property (weak, nonatomic) IBOutlet UIImageView *hateImageView;
//评论
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
//赞数量
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
//踩数量
@property (weak, nonatomic) IBOutlet UILabel *hateCountLabel;
//评论奖50分
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sanjiaoImageView;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet UITableView *privilegeListTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *privilegeListTableViewHeight;

@property (nonatomic,strong)NSArray *commentArr;
@property (nonatomic,strong)NSIndexPath *indexPath;
@end
