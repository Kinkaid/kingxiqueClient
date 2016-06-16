//
//  CommentImageCollectionViewCell.m
//  infoPromotionClient
//
//  Created by imac on 16/2/23.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "CommentImageCollectionViewCell.h"

@implementation CommentImageCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)showImage:(NSString *)urlStr
{
   [self.commentImage sd_setImageWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/%@",IMAGEURL,urlStr]]];
}
@end
