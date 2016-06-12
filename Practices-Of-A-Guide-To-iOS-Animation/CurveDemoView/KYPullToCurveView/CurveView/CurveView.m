//
//  CurveView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/21/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "CurveView.h"
#import "CurveLayer.h"

@interface CurveView()

@property (nonatomic,strong)CurveLayer *curveLayer;

@end

@implementation CurveView

+(Class)layerClass{
    return [CurveLayer class];
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setProgress:(CGFloat)progress{
    self.curveLayer.progress = progress;
    [self.curveLayer setNeedsDisplay];
    
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    
    self.curveLayer = [CurveLayer layer];
    self.curveLayer.frame = self.bounds;
    self.curveLayer.contentsScale = [UIScreen mainScreen].scale;
    self.curveLayer.progress = 0.0f;
    [self.curveLayer setNeedsDisplay];
    [self.layer addSublayer:self.curveLayer];
    
}


@end
