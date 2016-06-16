//
//  CommentLargeImageController.h
//  infoPromotionClient
//  查看大图
//  Created by zhujingci on 15/12/25.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommentImageEntity.h"

@protocol CommentLargeImageControllerDelegate <NSObject>

-(void)deleteCommentLargeImage:(NSUInteger)arrayIndex;

@end

@interface CommentLargeImageController : UIViewController

@property(strong,nonatomic) CommentImageEntity *commentImage;

@property(strong,nonatomic) NSIndexPath *indexPath;

@property(weak,nonatomic) id<CommentLargeImageControllerDelegate> delegate;

@end
