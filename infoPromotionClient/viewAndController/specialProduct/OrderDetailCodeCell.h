//
//  OrderDetailCodeCell.h
//  infoPromotionClient
//
//  Created by imac on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
-(void)showDataWithDic:(NSDictionary *)orderCodeDic;
@end
