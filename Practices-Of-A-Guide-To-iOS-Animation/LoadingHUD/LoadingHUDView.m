//
//  LoadingHUd.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 5/26/16.
//  Copyright © 2016 LT. All rights reserved.
//

#define ORIGIN_X self.frame.origin.x
#define ORIGIN_Y self.frame.origin.y
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#define BALL_DIAMETER 20

#import "LoadingHUDView.h"

@implementation LoadingHUDView{
    UIView *ball_1;
    UIView *ball_2;
    UIView *ball_3;
}

static int count = 0;

-(void)config{
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = WIDTH/2;
    self.clipsToBounds = YES;
}

-(void)showHUD{
    ball_2 = [[UIView alloc]initWithFrame:CGRectMake(WIDTH/2 - BALL_DIAMETER/2, HEIGHT/2 - BALL_DIAMETER/2, BALL_DIAMETER, BALL_DIAMETER)];
    ball_2.backgroundColor = [UIColor redColor];
    ball_2.layer.cornerRadius = BALL_DIAMETER/2;
    
    ball_1 = [[UIView alloc]initWithFrame:CGRectMake(ball_2.frame.origin.x - BALL_DIAMETER, HEIGHT/2 - BALL_DIAMETER/2, BALL_DIAMETER, BALL_DIAMETER)];
    ball_1.backgroundColor = [UIColor redColor];
    ball_1.layer.cornerRadius = BALL_DIAMETER/2;
    
    ball_3 = [[UIView alloc]initWithFrame:CGRectMake(ball_2.frame.origin.x + BALL_DIAMETER, HEIGHT/2 - BALL_DIAMETER/2, BALL_DIAMETER, BALL_DIAMETER)];
    ball_3.backgroundColor = [UIColor redColor];
    ball_3.layer.cornerRadius = BALL_DIAMETER/2;
    
    [self addSubview:ball_1];
    [self addSubview:ball_2];
    [self addSubview:ball_3];
    [self startLoadingAnimation];
}


-(void)startLoadingAnimation{
    UIBezierPath *circlePath_1 = [UIBezierPath bezierPath];
    [circlePath_1 moveToPoint:CGPointMake(WIDTH/2-BALL_DIAMETER, HEIGHT/2)];
    [circlePath_1 addArcWithCenter:CGPointMake(WIDTH/2, HEIGHT/2) radius:BALL_DIAMETER startAngle:M_PI endAngle:M_PI*2 clockwise:NO];
    
    UIBezierPath *circlePath_1_2 = [UIBezierPath bezierPath];
    [circlePath_1_2 addArcWithCenter:CGPointMake(WIDTH/2, HEIGHT/2) radius:BALL_DIAMETER startAngle:0 endAngle:M_PI    clockwise:NO];
    [circlePath_1 appendPath:circlePath_1_2];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = circlePath_1.CGPath;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationCubic;
    animation.repeatCount = 1;
    animation.duration = 1.4;
    animation.delegate = self;
    animation.autoreverses = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [ball_1.layer addAnimation:animation forKey:@"animation"];
    
    UIBezierPath *circlePath_2 = [UIBezierPath bezierPath];
    [circlePath_2 moveToPoint:CGPointMake(WIDTH/2+BALL_DIAMETER, HEIGHT/2)];
    
    [circlePath_2 addArcWithCenter:CGPointMake(WIDTH/2, HEIGHT/2) radius:BALL_DIAMETER startAngle:(0*M_PI)/180 endAngle:(180*M_PI)/180 clockwise:NO];
    UIBezierPath *circlePath_2_2 = [UIBezierPath bezierPath];
    [circlePath_2_2 addArcWithCenter:CGPointMake(WIDTH/2, HEIGHT/2) radius:BALL_DIAMETER startAngle:(180 *M_PI)/180 endAngle:(360*M_PI)/180 clockwise:NO];
    [circlePath_2 appendPath:circlePath_2_2];
    
    
    CAKeyframeAnimation *animation_2=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_2.path = circlePath_2.CGPath;
    animation_2.removedOnCompletion = NO;
    animation_2.fillMode = kCAFillModeForwards;
    animation_2.repeatCount = 1;
    //    animation_2.beginTime = 0.1;
    animation_2.duration =1.4 ;
    animation_2.autoreverses = NO;
    animation_2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [ball_3.layer addAnimation:animation_2 forKey:@"Rotation"];
    
    
}

-(void)animationDidStart:(CAAnimation *)anim{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        ball_1.transform = CGAffineTransformIdentity;
        ball_2.transform = CGAffineTransformIdentity;
        ball_3.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState animations:^{
            ball_1.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self startLoadingAnimation];
}

-(void)dismissHUD{
    [UIView animateWithDuration:1 delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformScale(self.transform, 1.5, 1.5);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    switch (count++%2) {
        case 0:
            [self showHUD];
            break;
            
        default:
            [self dismissHUD];
            break;
    }
}

@end
