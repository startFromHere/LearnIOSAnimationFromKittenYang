//
//  Cross.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/12/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "Cross.h"

@implementation Cross

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat lineWidth = 9.0f;
    CGFloat inset  = lineWidth/2;
    
    CGPathMoveToPoint(path, nil, rect.size.width/2, inset);
    CGPathAddLineToPoint(path, nil, rect.size.width/2, rect.size.height-inset);
    CGPathMoveToPoint(path, nil, inset, rect.size.height/2);
    CGPathAddLineToPoint(path, nil, rect.size.width-inset, rect.size.height/2);
    
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    
}

@end
