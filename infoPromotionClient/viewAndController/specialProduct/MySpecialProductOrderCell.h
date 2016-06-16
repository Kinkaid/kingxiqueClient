//
//  MySpecialProductOrderCell.h
//  infoPromotionClient
//
//  Created by imac on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MySpecialProductOrderDelegate <NSObject>

-(void)leftBtnActionWithCellRow:(NSInteger)cellRow withBtn:(UIButton *)leftBtn;
-(void)rightBtnActionWithCellRow:(NSInteger)cellRow withBtn:(UIButton *)rightBtn;
@end
@interface MySpecialProductOrderCell : UITableViewCell
@property (nonatomic)NSInteger cellRow;
@property (nonatomic,strong)id<MySpecialProductOrderDelegate>delegate;
//店铺名称
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
//订单状态
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
//商品标题
@property (weak, nonatomic) IBOutlet UILabel *productDescriptionLabel;
//商品价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//有效期
@property (weak, nonatomic) IBOutlet UILabel *validityLabel;
//订单生成时间
@property (weak, nonatomic) IBOutlet UILabel *createOrderTimeLabel;
//左边button
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
//右边button
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
-(void)showDataWithDic:(NSDictionary *)productDic;
@end
