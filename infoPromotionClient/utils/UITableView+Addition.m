//
//  UITableView.m
//  infoPromotion
//
//  Created by chenkaiwei  on 15/4/24.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "UITableView+Addition.h"

@implementation UITableView(Addition)


-(void)registerNibByCellId:(NSString*)cellId{
    UINib *cellNib = [UINib nibWithNibName:cellId bundle:nil];
    [self registerNib:cellNib forCellReuseIdentifier:cellId];
}

@end
