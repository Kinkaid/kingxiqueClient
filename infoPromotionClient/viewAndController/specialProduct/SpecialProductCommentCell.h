//
//  SpecialProductCommentCell.h
//  infoPromotionClient
//
//  Created by imac on 16/2/23.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol largeImageDelegate <NSObject>
-(void)largeImageWithIndexPath:(NSIndexPath *)indexPath AndItem:(NSInteger)item;
@end

@interface SpecialProductCommentCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)NSMutableArray *imageListArr;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (nonatomic,strong)id<largeImageDelegate>delegate;
-(void)showDataWithDic:(NSDictionary *)dic;

@end
