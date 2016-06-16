//
//  CALayer+Addition.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/17.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "CALayer+Addition.h"

@implementation CALayer (Addition)

-(void)setBorderColorFromUIColor:(UIColor *)color{
    self.borderColor=color.CGColor;
}
-(void)setTopBorderColor:(UIColor *)color{
    CALayer *mobileLine = [[CALayer alloc] init];
    mobileLine.frame = CGRectMake(0, 0,self.frame.size.width, 0.5);
    mobileLine.backgroundColor = color.CGColor;
    [self addSublayer:mobileLine];
}

-(void)setBottomBorderColor:(UIColor *)color{
    CALayer *mobileLine = [[CALayer alloc] init];
    mobileLine.frame = CGRectMake(0, self.bounds.size.height-0.5,self.bounds.size.width, 0.5);
    mobileLine.backgroundColor = color.CGColor;
    [self addSublayer:mobileLine];
}


-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    [super drawLayer:layer inContext:ctx];
}

@end
