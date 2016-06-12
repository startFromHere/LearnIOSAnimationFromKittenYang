//
//  CircleLayer.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/12/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "CircleLayer.h"

/*
typedef enum MovingPoint{
    POINT_D,
    POINT_B,
}MovingPoint;
*/
#define outsizeRectSize 90

typedef NS_ENUM(NSInteger,MovingPoint){
    POINT_D,
    POINT_B,
};

@interface CircleLayer()

@property (nonatomic,assign)CGRect outsideRect;
@property (nonatomic,assign)CGFloat lastProgress;
@property (nonatomic,assign)MovingPoint movePoint;

@end

@implementation CircleLayer

-(instancetype)init{
    self = [super init];
    if (self) {
        self.lastProgress = 0.5;
    }
    return self;
}

-(id)initWithLayer:(CircleLayer *)layer{
    self=[super initWithLayer:layer];
    if (self) {
        self.progress = layer.progress;
        self.outsideRect = layer.outsideRect;
        self.lastProgress = layer.lastProgress;
    }
    return self;
}

-(void)drawInContext:(CGContextRef)ctx{
    CGFloat offset = self.outsideRect.size.width / 3.6;
    CGFloat movedDistance = (self.outsideRect.size.width * 1/6)*fabs(self.progress-0.5)*2;
    
    CGPoint rectCenter = CGPointMake(self.outsideRect.origin.x + self.outsideRect.size.width/2, self.outsideRect.origin.y +self.outsideRect.size.height/2);
    
    CGPoint pointA = CGPointMake(rectCenter.x, self.outsideRect.origin.y + movedDistance);
    CGPoint pointB = CGPointMake(self.movePoint == POINT_D?rectCenter.x + self.outsideRect.size.width/2 : rectCenter.x + self.outsideRect.size.width/2 + movedDistance*2, rectCenter.y);
    CGPoint pointC = CGPointMake(rectCenter.x, rectCenter.y + self.outsideRect.size.height/2-movedDistance);
    CGPoint pointD = CGPointMake(self.movePoint == POINT_D?rectCenter.x -self.outsideRect.size.width/2 - movedDistance*2 : self.outsideRect.origin.x,rectCenter.y);

    CGPoint c1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, self.movePoint == POINT_D ? pointB.y - offset : pointB.y - offset + movedDistance);

    CGPoint c3 = CGPointMake(pointB.x, self.movePoint == POINT_D ? pointB.y + offset : pointB.y + offset - movedDistance);
    CGPoint c4 = CGPointMake(pointC.x + offset, pointC.y );
    
    CGPoint c5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, self.movePoint == POINT_D ? pointD.y + offset - movedDistance : pointD.y + offset);

    CGPoint c7 = CGPointMake(pointD.x, self.movePoint == POINT_D ? pointD.y - offset + movedDistance : pointD.y - offset);
    CGPoint c8 = CGPointMake(pointA.x - offset, pointA.y);
    
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.outsideRect];
    CGContextAddPath(ctx, rectPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextSetLineWidth(ctx, 1.0);
    CGFloat dash[] = {5.0,5.0};
    CGContextSetLineDash(ctx, 0.0, dash, 2);
    CGContextStrokePath(ctx);
    
    UIBezierPath *ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint:pointA];
    [ovalPath addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [ovalPath addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [ovalPath addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [ovalPath addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [ovalPath closePath];
    
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineDash(ctx, 0, NULL, 0);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    NSArray *points = @[[NSValue valueWithCGPoint:pointA],[NSValue valueWithCGPoint:pointB],[NSValue valueWithCGPoint:pointC],[NSValue valueWithCGPoint:pointD],[NSValue valueWithCGPoint:c1],[NSValue valueWithCGPoint:c2],[NSValue valueWithCGPoint:c3],[NSValue valueWithCGPoint:c4],[NSValue valueWithCGPoint:c5],[NSValue valueWithCGPoint:c6],[NSValue valueWithCGPoint:c7],[NSValue valueWithCGPoint:c8]];
    [self drawPoint:points withContex:ctx];
    
    UIBezierPath *helperline = [UIBezierPath bezierPath];
    [helperline moveToPoint:pointA];
    [helperline addLineToPoint:c1];
    [helperline addLineToPoint:c2];
    [helperline addLineToPoint:pointB];
    [helperline addLineToPoint:c3];
    [helperline addLineToPoint:c4];
    [helperline addLineToPoint:pointC];
    [helperline addLineToPoint:c5];
    [helperline addLineToPoint:c6];
    [helperline addLineToPoint:pointD];
    [helperline addLineToPoint:c7];
    [helperline addLineToPoint:c8];
    [helperline closePath];
    
    CGContextAddPath(ctx, helperline.CGPath);
    
    CGFloat dash2[] = {2.2,2.2};
    CGContextSetLineDash(ctx, 0.0, dash2, 2);
    CGContextStrokePath(ctx);

}

-(void)drawPoint:(NSArray *)points withContex:(CGContextRef)ctx{
    for (NSValue *pointValue in points) {
        CGPoint point = [pointValue CGPointValue];
        CGContextFillRect(ctx, CGRectMake(point.x - 2, point.y - 2, 4, 4));
    }
}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    if (progress <= 0.5) {
        self.movePoint = POINT_B;
    } else {
        self.movePoint = POINT_D;
    }
    
    self.lastProgress = progress;
    
    CGFloat origin_x = self.position.x - outsizeRectSize/2 + (progress - 0.5)*(self.frame.size.width - outsizeRectSize);
    CGFloat origin_y = self.position.y - outsizeRectSize/2;
    self.outsideRect = CGRectMake(origin_x, origin_y, outsizeRectSize, outsizeRectSize);
    
    [self setNeedsDisplay];
}


@end
