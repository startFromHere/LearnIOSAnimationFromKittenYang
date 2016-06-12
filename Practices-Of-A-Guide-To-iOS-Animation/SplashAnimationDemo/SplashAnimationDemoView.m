//
//  SplashAnimationDemo.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/15/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "SplashAnimationDemoView.h"
#import "LTDisplayVC.h"
@implementation SplashAnimationDemoView{
    UIWindow *window;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)config{
    self.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    UIView *maskBackgroundView = [[UIView alloc]initWithFrame:self.bounds];
    maskBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:maskBackgroundView];
    [self bringSubviewToFront:maskBackgroundView];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    maskLayer.position = self.center;
    maskLayer.bounds = CGRectMake(0, 0, 60, 60);
    maskBackgroundView.layer.mask = maskLayer;

    
    CAKeyframeAnimation *logoMaskAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    logoMaskAnimation.duration = 1.0f;
    logoMaskAnimation.beginTime = CACurrentMediaTime() + 1.0f;
    
    CGRect initalBounds = maskLayer.bounds;
    CGRect secondBounds = CGRectMake(0, 0, 50, 50);
    CGRect finalBounds = CGRectMake(0, 0, 2000, 2000);
    logoMaskAnimation.values = @[[NSValue valueWithCGRect:initalBounds],[NSValue valueWithCGRect:secondBounds],[NSValue valueWithCGRect:finalBounds]];
    logoMaskAnimation.keyTimes = @[@(0),@(0.5),@(1)];
    logoMaskAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    logoMaskAnimation.removedOnCompletion = NO;
    logoMaskAnimation.fillMode = kCAFillModeForwards;
    [maskLayer addAnimation:logoMaskAnimation forKey:@"logoMaskAnimation"];
    
    
    /*
    [UIView animateWithDuration:0.1 delay:1.35 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
//        UIImageView *iv = [[UIImageView alloc]initWithFrame:self.bounds];
//        iv.image = [UIImage imageNamed:@"home_demo"];
//        [self addSubview:iv];
//        
//        maskBackgroundView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        //[maskBackgroundView removeFromSuperview];
        //maskBackgroundView.layer.mask = nil;
        //maskBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_demo"]];
    }];
    */
    /*
    [UIView animateWithDuration:0.25 delay:0.5 options:UIViewAnimationCurveEaseInOut animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        maskLayer = nil;
    }];
    */
    [UIView animateWithDuration:0.25 delay:1.3 options:UIViewAnimationOptionTransitionNone animations:^{
        
        maskBackgroundView.transform = CGAffineTransformMakeScale(1.05, 1.05);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            maskBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_demo"]];
            
            maskBackgroundView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            maskBackgroundView.layer.mask = nil;
            
        }];
    }];
    
}

@end
