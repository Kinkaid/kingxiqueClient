//
//  AddAddressCell.m
//  infoPromotionClient
//
//  Created by imac on 16/3/1.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "AddAddressCell.h"

@implementation AddAddressCell{

    __weak IBOutlet UIImageView *_selectedImage;
    __weak IBOutlet UILabel *_nameLabel;
    
    __weak IBOutlet UILabel *_phoneNumLabel;
    __weak IBOutlet UILabel *_addressLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showAddressMessageWithDic:(NSDictionary *)dicMessage
{
    if ([dicMessage[@"selected"] boolValue]==YES) {
        _selectedImage.image = [UIImage imageNamed:@"address-sel"];
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"[默认]收货地址:%@%@",dicMessage[@"region"],dicMessage[@"street"]]];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:[TDColorUtil parse:@"#EA5525"] range:NSMakeRange(0, 4)];
        _addressLabel.attributedText = attributeStr;
        
    }else {
        _selectedImage.image = [UIImage imageNamed:@"address-nosel"];
        _addressLabel.text = [NSString stringWithFormat:@"收货地址:%@%@",dicMessage[@"region"],dicMessage[@"street"]];
    }
    _nameLabel.text = dicMessage[@"name"];
    _phoneNumLabel.text = dicMessage[@"phone"];
}
- (IBAction)editorAddressAction:(id)sender {
    
    [self.delegate editAddressWithCellId:self.cellRow];
}

@end
