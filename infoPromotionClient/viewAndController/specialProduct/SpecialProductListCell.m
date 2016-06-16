//
//  SpecialProductListCell.m
//  infoPromotionClient
//
//  Created by imac on 16/1/12.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "SpecialProductListCell.h"

@implementation SpecialProductListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showDataWithDic:(NSDictionary *)productDic
{

}
-(void)drawRect:(CGRect)rect
{
    if (!_gradient) {
        _gradient = [CAGradientLayer layer];
        CGRect topicImageFrame = self.productImageView.frame;
        _gradient.frame = CGRectMake(0, 0, CGRectGetWidth(topicImageFrame), CGRectGetHeight(topicImageFrame));
        _gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0.0f alpha:0.4f].CGColor, (id)[UIColor colorWithWhite:0.0f alpha:0.0f].CGColor, nil];
        _gradient.startPoint = CGPointMake(0, 0.5f);
        _gradient.endPoint = CGPointMake(1.0f, 0.5f);
        [self.productImageView.layer addSublayer:_gradient];
    }
}
@end
