//
//  CustomConvertTransition.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 5/27/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "CustomConvertTransition.h"
#import "LTDisplayVC.h"
#import "SecondViewController.h"
#import "PingTransitionDemoView.h"

@interface CustomConvertTransition()

@property(nonatomic,strong)id<UIViewControllerContextTransitioning>transitionContext;

@end

@implementation CustomConvertTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.7f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    
    SecondViewController *fromVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    LTDisplayVC *toVC = (LTDisplayVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *contView = [transitionContext containerView];
    PingTransitionDemoView *PTView = (PingTransitionDemoView *)toVC.view;
    UIButton *button = PTView.openBTN;
    
    
    [contView addSubview:toVC.view];
    [contView addSubview:fromVC.view];
    
    
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:button.frame];
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
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalPath.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(finalPath.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"pathInvert"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}


@end
