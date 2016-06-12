//
//  CustomTransition.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 5/26/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "CustomTransition.h"
#import "LTDisplayVC.h"
#import "SecondViewController.h"
#import "PingTransitionDemoView.h"

@interface CustomTransition()

@property (nonatomic,strong)id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation CustomTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.7f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    
    LTDisplayVC *fromVC = (LTDisplayVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *contView = [transitionContext containerView];
    PingTransitionDemoView *PTView = (PingTransitionDemoView *)fromVC.view;
    NSLog(@"ReferFromVC:%@",fromVC);
    NSLog(@"ReferPTView:%@",PTView);
    UIButton *button = PTView.openBTN;
    
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    [contView addSubview:fromVC.view];
    [contView addSubview:toVC.view];
    
//    if (button == nil) {
//        NSLog(@"靠，button 是空的");
//    }
//    NSLog(@"button:%@",button);
//    CGRect rect1 = button.frame;
//    NSLog(@"button:%f,%f,%f,%f",rect1.origin.x,rect1.origin.y,rect1.size.width,rect1.size.height);
//    CGRect rect2 = toVC.view.bounds;
//    NSLog(@"toVC.view:%f,%f,%f,%f",rect2.origin.x,rect2.origin.y,rect2.size.width,rect2.size.height);
    
    CGPoint finalPoint;
    if (button.frame.origin.x > toVC.view.bounds.size.width/2) {
        if (button.frame.origin.y < toVC.view.bounds.size.height/2) {
            finalPoint = CGPointMake(button.center.x - 0, button.center.y - CGRectGetMaxY(toVC.view.bounds)+30);
        } else {
            finalPoint = CGPointMake(button.center.x - 0, button.center.y - 0);
        }
    }else{
        if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
            //第二象限
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - CGRectGetMaxY(toVC.view.bounds)+30);
        }else{
            //第三象限
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - 0);
        }
    }
    
    CGFloat radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y));
    
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(maskFinalBP.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end



