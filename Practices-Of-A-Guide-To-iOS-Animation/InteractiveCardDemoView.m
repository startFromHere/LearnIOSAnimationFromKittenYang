//
//  InteractiveCardDemoView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 5/27/16.
//  Copyright © 2016 LT. All rights reserved.
//

#define ANIMATIONDURATION 0.5
#define ANIMATEDAMPING 0.7
#define SCROLLDISTANCE 200.0

#import "InteractiveCardDemoView.h"

@implementation InteractiveCardDemoView{
    UIImageView *interactiveView;
    UIVisualEffectView *blurView;
}

-(void)config{
    [self setUpDimmingView];
    [self setUpEffectiveView];

    self.layer.cornerRadius = 7.0f;
    self.layer.masksToBounds = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
    [self addGestureRecognizer:pan];
}

-(void)panGestureRecognized:(UIPanGestureRecognizer *)pan{
    static CGPoint initialPoint;
    CGFloat factorOfAngle = 0.0f;
    CGFloat factorOfScale = 0.0f;
    CGPoint transition = [pan translationInView:interactiveView.superview];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        initialPoint = interactiveView.center;
    } else if(pan.state == UIGestureRecognizerStateChanged){
        interactiveView.center = CGPointMake(initialPoint.x, initialPoint.y + transition.y);
        CGFloat Y = MIN(SCROLLDISTANCE,MAX(0, ABS(transition.y)));
        
        factorOfAngle = MAX(0, -4/(SCROLLDISTANCE*SCROLLDISTANCE)*Y*(Y-SCROLLDISTANCE));
        factorOfScale = MAX(0, -1/(SCROLLDISTANCE*SCROLLDISTANCE)*Y*(Y-2*SCROLLDISTANCE));
        
        CATransform3D t = CATransform3DIdentity;
        t.m34 = 1.0/-1000;
        t = CATransform3DRotate(t, factorOfAngle*(M_PI/5), transition.y>0?-1:1, 0, 0);
        t = CATransform3DScale(t, 1-factorOfScale*0.2, 1-factorOfScale*0.2, 0);
        
        interactiveView.layer.transform = t;
        blurView.alpha = 1.0 - Y / SCROLLDISTANCE;
    } else if(pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled){
        [UIView animateWithDuration:ANIMATIONDURATION delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            interactiveView.layer.transform = CATransform3DIdentity;
            interactiveView.center = initialPoint;
            blurView.alpha = 1.0f;
        } completion:nil];
    }
}

-(void)setUpDimmingView{
    blurView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    blurView.frame = self.bounds;
    [self addSubview:blurView];
}

-(void)setUpEffectiveView{
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:backView];
    
    interactiveView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic01"]];
    interactiveView.center = self.center;
    interactiveView.bounds = CGRectMake(0, 0, 200, 150);
    [backView addSubview:interactiveView];
}


@end
