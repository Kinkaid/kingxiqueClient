//
//  RefundOrderReasonCell.h
//  infoPromotionClient
//
//  Created by imac on 16/2/23.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OtherReasonTextViewDelegate <NSObject>

-(void)otherReasonTextView:(UITextView *)textView;

@end

@interface RefundOrderReasonCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *otherReasonTextView;
@property (weak, nonatomic) IBOutlet UILabel *reasonLabel;
@property (nonatomic,strong)id<OtherReasonTextViewDelegate>delegate;
@end
