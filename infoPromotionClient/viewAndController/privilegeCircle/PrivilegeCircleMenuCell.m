//
//  PrivilegeCircleMenuCell.h
//  infoPromotionClient
//
//  Created by imac on 16/3/3.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "PrivilegeCircleMenuCell.h"

@implementation PrivilegeCircleMenuCell{

    __weak IBOutlet UILabel *_menuLabel;
    __weak IBOutlet UIImageView *_selectImageView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showDataWithArr:(NSMutableDictionary *)mDic
{
    _menuLabel.text = mDic[@"menu"];
    if ([mDic[@"isSel"] boolValue]==YES) {
        _menuLabel.textColor = [TDColorUtil parse:@"#EA5525"];
        _selectImageView.image = [UIImage imageNamed:@"gou_"];
    }else{
        _menuLabel.textColor = [TDColorUtil parse:@"#333333"];
        _selectImageView.image = [UIImage imageNamed:@""];
    }
}
@end
