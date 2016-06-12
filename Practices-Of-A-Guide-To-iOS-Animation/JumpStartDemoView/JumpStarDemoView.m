//
//  JumpStartDemoView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/5/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "JumpStarDemoView.h"

#define jumpDuration 0.125
#define downDuration 0.125

@interface JumpStarDemoView()

@property (nonatomic,strong)UIImageView *startView;
@property (nonatomic,strong)UIImageView *shadowView;

@end

@implementation JumpStarDemoView{
    BOOL animating;
}

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)config{
    self.backgroundColor = [UIColor yellowColor];
    if (self.startView == nil) {
        self.startView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - 20/2, self.bounds.size.height/2 - 20/2, 20, 20)];
        self.startView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.startView];
    }
    if (self.shadowView  == nil) {
        self.shadowView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - 15/2, self.bounds.size.height/2 + 13, 15, 5)];
        self.shadowView.alpha = 0.4;
        self.shadowView.image = [UIImage imageNamed:@"shadow_new"];
        [self addSubview:self.shadowView];
    }
    
    self.markedImage = [UIImage imageNamed:@"icon_star_incell"];
    self.non_markedImage = [UIImage imageNamed:@"blue_dot"];
    self.state = non_Mark;
}


//- (void)layoutSubviews{
//    [super layoutSubviews];
//    self.backgroundColor = [UIColor clearColor];
//    if (self.startView == nil) {
//        self.startView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - (self.bounds.size.width - 6)/2, 0, self.bounds.size.width-2, self.bounds.size.height - 6)];
//        self.startView.contentMode = UIViewContentModeScaleToFill;
//        [self addSubview:self.startView];
//    }
//    if (self.shadowView  == nil) {
//        self.shadowView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - 10/2, self.bounds.size.height - 3, 10, 3)];
//        self.shadowView.alpha = 0.4;
//        self.shadowView.image = [UIImage imageNamed:@"shadow_new"];
//        [self addSubview:self.shadowView];
//    }
//    
//}

- (void)setState:(STATE)state{
    _state = state;
    self.startView.image = _state == Mark? _markedImage : _non_markedImage;
}

- (void)animate{
    if (animating == YES) {
        return;
    }
    
    animating = YES;
    CABasicAnimation *transformAnimate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    transformAnimate.fromValue = @(0);
    transformAnimate.toValue = @(M_PI_2);
    transformAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *positionAnimate = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnimate.fromValue = @(self.startView.center.y);
    positionAnimate.toValue = @(self.startView.center.y -14);
    positionAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *animateGroup = [CAAnimationGroup animation];
    animateGroup.duration = jumpDuration;
    animateGroup.fillMode = kCAFillModeForwards;
    animateGroup.removedOnCompletion = NO;
    animateGroup.delegate = self;
    animateGroup.animations = @[transformAnimate,positionAnimate];
    
    [self.startView.layer addAnimation:animateGroup forKey:@"jumpUp"];
}

-(void)animationDidStart:(CAAnimation *)anim{
    if ([anim isEqual:[self.startView.layer animationForKey:@"jumpUp"]]) {
        [UIView animateWithDuration:jumpDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            _shadowView.alpha = 0.2;
            _shadowView.bounds = CGRectMake(0, 0, _shadowView.bounds.size.width*1.6, _shadowView.bounds.size.height);
        } completion:nil];
    } else if([anim isEqual:[self.startView.layer animationForKey:@"jumpDown"]]){
        [UIView animateWithDuration:jumpDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            _shadowView.alpha = 0.4;
            _shadowView.bounds = CGRectMake(0, 0, _shadowView.bounds.size.width/1.6, _shadowView.bounds.size.height);
        } completion:NULL];
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim isEqual:[self.startView.layer animationForKey:@"jumpUp"]]) {
        
        self.state = self.state==Mark?non_Mark:Mark;
        NSLog(@"state:%ld",_state);
        CABasicAnimation *transformAnima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        transformAnima.fromValue = @(M_PI_2);
        transformAnima.toValue = @(M_PI);
        transformAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
        positionAnima.fromValue = @(self.startView.center.y - 14);
        positionAnima.toValue = @(self.startView.center.y);
        positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        CAAnimationGroup *animGroup = [CAAnimationGroup animation];
        animGroup.duration = downDuration;
        animGroup.fillMode = kCAFillModeForwards;
        animGroup.removedOnCompletion = NO;
        animGroup.delegate = self;
        animGroup.animations = @[transformAnima,positionAnima];
        
        [self.startView.layer addAnimation:animGroup forKey:@"jumpDown"];
        
    }else if([anim isEqual:[self.startView.layer animationForKey:@"jumpDown"]]){
        
        [self.startView.layer removeAllAnimations];
        animating = NO;
    }

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self animate];
}

@end
