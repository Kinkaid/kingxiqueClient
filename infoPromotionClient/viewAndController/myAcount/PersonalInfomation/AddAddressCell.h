//
//  AddAddressCell.h
//  infoPromotionClient
//
//  Created by imac on 16/3/1.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressEditorDelegate <NSObject>

@required
-(void)editAddressWithCellId:(NSInteger)cellRow;

@end

@interface AddAddressCell : UITableViewCell
@property (nonatomic,strong)id<AddressEditorDelegate>delegate;
@property (nonatomic)NSInteger cellRow;
-(void)showAddressMessageWithDic:(NSDictionary *)dicMessage;
@end
