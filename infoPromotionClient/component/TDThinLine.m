//
//  DTThinLine.m
//  infoPromotion
//
//  Created by chenkaiwei  on 15-3-4.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "TDThinLine.h"

@implementation TDThinLine

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CALayer *mobileLine = [[CALayer alloc] init];
    mobileLine.frame = CGRectMake(0, 0,self.frame.size.width, 0.5);
//    mobileLine.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    mobileLine.backgroundColor = [TDColorUtil parse:@"#d8d8d8"].CGColor;
    [self.layer addSublayer:mobileLine];
}
@end
