//
//  DynamicActionBlockDemoView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/7/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "DynamicActionBlockDemoView.h"

@interface DynamicActionBlockDemoView()

@property (strong,nonatomic) UIDynamicAnimator *animator;
@property (strong,nonatomic) UIGravityBehavior *panGravity;
@property (strong,nonatomic) UIGravityBehavior *viewsGravity;
@property (strong,nonatomic) CAShapeLayer *customLayer;
@property (strong,nonatomic) UIView *panView;
@property (strong,nonatomic) UIImageView *ballImageView;
@property (strong,nonatomic) UIView *middleView;
@property (strong,nonatomic) UIView *topView;
@property (strong,nonatomic) UIView *bottomView;

@end

@implementation DynamicActionBlockDemoView

-(void)config{
    _panView = [[UIView alloc]initWithFrame:self.bounds];
    [_panView setAlpha:0.5];
    [self addSubview:_panView];
    [_panView.layer setShadowOffset:CGSizeMake(-1, 2)];
    [_panView.layer setShadowOpacity:0.5];
    [_panView.layer setShadowRadius:5.0];
    [_panView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_panView.layer setMasksToBounds:NO];
    [_panView.layer setShadowPath:[UIBezierPath bezierPathWithRect:_panView.bounds].CGPath];
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panTheView:)];
//    [_panView addGestureRecognizer:pan];
    
//    CAGradientLayer *grd = []
}


@end
