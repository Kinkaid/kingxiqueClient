//
//  CommentImageCollectionViewCell.h
//  infoPromotionClient
//
//  Created by imac on 16/2/23.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;

-(void)showImage:(NSString *)urlStr;
@end
