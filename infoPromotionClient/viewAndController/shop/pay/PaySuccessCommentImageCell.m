//
//  PaySuccessCommentImageCell.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/24.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "PaySuccessCommentImageCell.h"

@implementation PaySuccessCommentImageCell{
    
    __weak IBOutlet UIImageView *_commentImageView;
}

- (void)awakeFromNib {
    // Initialization code
}
-(void)showCellWithImageEntity:(CommentImageEntity *)commentImage{
    if (commentImage.isCamera) {
        _commentImageView.image = [UIImage imageNamed:@"xiangji"];
    }else{
        [_commentImageView sd_setImageWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/%@",IMAGEURL,commentImage.imageStr]]];
    }
}
@end
