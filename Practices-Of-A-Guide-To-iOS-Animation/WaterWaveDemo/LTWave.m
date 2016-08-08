//
//  LTWave.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 8/7/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "LTWave.h"

@interface LTWave()

@property (nonatomic,assign) CGRect frame;
@property (nonatomic,assign) BOOL waveUp;
@property (nonatomic,assign) CGFloat waveCurve;
@property (nonatomic,assign) CGFloat waveSpeed;

@end

@implementation LTWave

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super init]) {
        [self settingWithFrame:frame];
    }
    
    return self;
}


- (void)settingWithFrame:(CGRect)frame{
    self.frame = frame;
    self.waveCurve = 1.5;
    self.waveSpeed = 0;
    self.waveUp = NO;
    
    [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(waving) userInfo:nil repeats:YES];
}

- (void)waving{
    self.waveCurve += self.waveUp? 0.01f :-0.01f;
    NSLog(@"self.waveCurve:%f\n",self.waveCurve);
    if (self.waveCurve <= 1.f) {
        self.waveUp = YES;
    } else if(self.waveCurve >= 1.5f) {
        self.waveUp = NO;
    }
    self.waveSpeed += 0.1f;
    [self creatPath];
}

- (void)creatPath{
    UIBezierPath *path = [[UIBezierPath alloc]init];
    CGFloat waterDepthY = (1 - self.waterDepth > 1.f? 1.f : self.waterDepth) * self.frame.size.height;
    CGFloat y = waterDepthY;
    [path  moveToPoint:CGPointMake(0, y)];
    
    path.lineWidth = 1;
    
    static int count = 0;
//    NSLog(@"\n\n\n\n\n\n\n%d\n",count);
    for (CGFloat x = 0; x <= self.frame.size.width; x++) {
//        NSLog(@"%d\n",count);
        y = self.waveCurve * sin(x/180*M_PI + 4*self.waveSpeed/M_PI) * 5 + waterDepthY;
        [path addLineToPoint:CGPointMake(x, y)];
    }
    
    [path addLineToPoint:CGPointMake(self.frame.size.width, y)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path closePath];
    
    if ([self.delegate respondsToSelector:@selector(waterWave:path:)]) {
        [self.delegate waterWave:self path:path];
    }
    
}
@end
