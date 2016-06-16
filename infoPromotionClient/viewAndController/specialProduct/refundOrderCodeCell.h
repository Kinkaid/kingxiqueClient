//
//  refundOrderCodeCell.h
//  infoPromotionClient
//
//  Created by imac on 16/2/23.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RefundCodeOrReasonDelegate <NSObject>

-(void)codeOrReasonSelectedWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface refundOrderCodeCell : UITableViewCell
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UILabel *codeOrReasonLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (nonatomic,strong)id<RefundCodeOrReasonDelegate>delegate;
@end
