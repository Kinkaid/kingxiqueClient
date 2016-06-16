//
//  UICollectionView+Addition.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/24.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "UICollectionView+Addition.h"

@implementation UICollectionView (Addition)

-(void)registerNibByCellId:(NSString*)cellId{
    UINib *cellNib = [UINib nibWithNibName:cellId bundle:nil];
    [self registerNib:cellNib forCellWithReuseIdentifier:cellId];
}

@end
