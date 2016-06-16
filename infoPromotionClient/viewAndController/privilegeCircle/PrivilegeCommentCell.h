//
//  PrivilegeCommentCell.h
//  infoPromotionClient
//
//  Created by imac on 16/1/4.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivilegeCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
-(void)showDataWithText:(NSString *)comment;
@end
