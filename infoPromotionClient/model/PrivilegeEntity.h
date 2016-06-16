//
//  PrivilegeEntity.h
//  infoPromotionClient
//
//  Created by imac on 16/1/5.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrivilegeEntity : NSObject
//店名店名 
@property (nonatomic,strong)NSString *shopName;
//店铺照片
@property (nonatomic,strong)UIImageView *shopImageView;
//地址
@property (nonatomic,strong)NSString *address;
//时间
@property (nonatomic)long dateTime;
//星级
@property (nonatomic) int starGrade;
//收藏
@property (nonatomic) BOOL isCollect;
//距离
@property (nonatomic) int distance;
//贴文图片
@property (nonatomic,strong)UIImageView *articleImageView;
//贴文主题
@property (nonatomic,strong)NSString *articleTitle;
//赞数量
@property (nonatomic) int likeCount;
//踩数量
@property (nonatomic) int hateCount;
//充值金额
@property (nonatomic)int recharge;
//赠送金额
@property (nonatomic)int present;
//会员卡总张数
@property (nonatomic) int allCardCount;
//会员卡剩余张数
@property (nonatomic) int surplusCardCount;
//会员卡期限
@property (nonatomic) int continueDays;
//原价
@property (nonatomic) CGFloat originalPrice;
//现价
@property (nonatomic) CGFloat currentPrice;
//商品图片
@property (nonatomic,strong) UIImageView *goodsImageView;
//商品介绍
@property (nonatomic,strong) NSString *goodsDescribe;
@end
