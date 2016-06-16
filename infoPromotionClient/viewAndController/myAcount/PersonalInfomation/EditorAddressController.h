//
//  EditorAddressController.h
//  infoPromotionClient
//
//  Created by imac on 16/3/1.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^addressBlock)(NSMutableDictionary *dic);
@interface EditorAddressController : UIViewController

@property (nonatomic)BOOL isEditor;
@property (nonatomic,strong)NSDictionary *addressDic;

@property (nonatomic,strong)addressBlock myBlock;
-(void)carryBlock:(addressBlock)block;
@end
