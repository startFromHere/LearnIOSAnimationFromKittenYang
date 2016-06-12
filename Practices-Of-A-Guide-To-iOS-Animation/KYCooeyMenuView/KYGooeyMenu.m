//
//  KYGooeyMenu.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/12/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "KYGooeyMenu.h"
#import "Cross.h"
#import "KYSpringLayerAnimation.h"

@interface KYGooeyMenu()

@property (nonatomic,strong)UIView *containerView;

@end

@implementation KYGooeyMenu {
    NSMutableDictionary *pointsDic;
    NSMutableArray *menus;
    NSMutableArray *menuLayers;
    CGRect menuFrame;
    int menuCount;
    UIColor *menuColor;
    CGFloat R;
    CGFloat r;
    CGFloat distance;
    BOOL isOpened;
    CAShapeLayer *verticalLineLayer;
    
    NSArray *values1_0_right;
    NSArray *values1_0_left;
    NSArray *values0_1_left;
    NSArray *values0_1_right;
    
    Cross *cross;
    BOOL once;
}

-(id)initWithOrigin:(CGPoint)origin andDiameter:(CGFloat)diameter andSuperView:(UIView *)superView themeColor:(UIColor *)themeColor{
    menuFrame = CGRectMake(origin.x, origin.y, diameter, diameter);
    self = [super initWithFrame:menuFrame];
    
    if (self) {
        pointsDic = [NSMutableDictionary dictionary];
        menuColor = themeColor;
        isOpened = NO;
        self.containerView = superView;
        [self.containerView addSubview:self];
        once = NO;
        [self addSomeViews];
    }
    return self;
}

-(void)addSomeViews{
    self.mainView = [[UIView alloc]initWithFrame:menuFrame];
    self.mainView.backgroundColor = menuColor;
    self.mainView.layer.cornerRadius = self.mainView.bounds.size.width / 2;
    self.mainView.layer.masksToBounds = YES;
    [self.containerView addSubview:self.mainView];
    
    cross = [[Cross alloc] init];
    cross.center = CGPointMake(self.mainView.bounds.size.width / 2, self.mainView.bounds.size.height / 2);
    cross.bounds = CGRectMake(0, 0, menuFrame.size.width/2, menuFrame.size.width/2);
    [self.mainView addSubview:cross];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToSwitchOpenOrClose)];
    [self.mainView addGestureRecognizer:tapGes];
}

-(void)setUpSomeDatas{
    R = self.mainView.bounds.size.width / 2;
    r = self.radius;
    
    distance = R + r + self.extraDistance;
    CGFloat degree = (180/(menuCount+1)*(M_PI/180));
    
    CGPoint originPoint = self.mainView.center;
    for (int i=0; i < menuCount; i++) {
        CGFloat cosDegree = cosf(degree * (i+1));
        CGFloat sinDegree = sinf(degree * (i+1));
        
        CGPoint center = CGPointMake(originPoint.x + distance*cosDegree, originPoint.y - distance*sinDegree);
        NSLog(@"centers:%@",NSStringFromCGPoint(center));
        [pointsDic setObject:[NSValue valueWithCGPoint:center] forKey:[NSString stringWithFormat:@"center%d",i+1]];
        
        UIView *item = [[UIView alloc]initWithFrame:CGRectZero];
        item.backgroundColor = menuColor;
        item.tag = i+1;
        item.center = self.mainView.center;
        item.bounds = CGRectMake(0, 0, r * 2, r * 2);
        item.layer.cornerRadius = item.bounds.size.width / 2;
        item.layer.masksToBounds = YES;
        
        CGFloat imageWidth = (item.frame.size.width / 2) * sin(M_PI_4) * 2;
        UIImageView *menuImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
        menuImage.center = CGPointMake(item.frame.size.width/2, item.frame.size.height/2);
        [item addSubview:menuImage];
        
        UITapGestureRecognizer *menuTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(menuTap:)];
        [item addGestureRecognizer:menuTap];
        
        [self.containerView insertSubview:item belowSubview:self.mainView];
        [menus addObject:item];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = menuColor.CGColor;
        [self.containerView.layer insertSublayer:shapeLayer atIndex:0];
        [menuLayers addObject:shapeLayer];
        
    }
    
    
    //Setup key frames
    CGFloat positionX = 50.0f;
    values1_0_right = @[
                        (id) [self getRightLinePathWithAmount:(positionX * 0.6)],
                        (id) [self getRightLinePathWithAmount:-(positionX * 0.4)],
                        (id) [self getRightLinePathWithAmount:(positionX * 0.25)],
                        (id) [self getRightLinePathWithAmount:-(positionX * 0.15)],
                        (id) [self getRightLinePathWithAmount:(positionX * 0.05)],
                        (id) [self getRightLinePathWithAmount:0.0]
                        ];
    values1_0_left = @[
                       (id) [self getLeftLinePathWithAmount:(positionX * 0.35)],
                       (id) [self getLeftLinePathWithAmount:-(positionX * 0.15)],
                       (id) [self getLeftLinePathWithAmount:(positionX * 0.15)],
                       (id) [self getLeftLinePathWithAmount:-(positionX * 0.05)],
                       (id) [self getLeftLinePathWithAmount:0.0]
                       ];
    
    values0_1_right = @[
                        (id) [self getRightLinePathWithAmount:0.0],
                        (id) [self getRightLinePathWithAmount:(positionX * 0.15)],
                        (id) [self getRightLinePathWithAmount:-(positionX * 0.35)],
                        (id) [self getRightLinePathWithAmount:(positionX * 0.6)],
                        (id) [self getRightLinePathWithAmount:-(positionX * 0.35)],
                        (id) [self getRightLinePathWithAmount:(positionX * 0.15)],
                        (id) [self getRightLinePathWithAmount:0.0]
                        ];
    
    values0_1_left = @[
                       (id) [self getLeftLinePathWithAmount:0.0],
                       (id) [self getLeftLinePathWithAmount:-(positionX * 0.15)],
                       (id) [self getLeftLinePathWithAmount:(positionX * 0.35)],
                       (id) [self getLeftLinePathWithAmount:-(positionX * 0.15)],
                       (id) [self getLeftLinePathWithAmount:0.0]
                       ];
}

- (CGPathRef) getRightLinePathWithAmount:(CGFloat)amount {
    UIBezierPath *verticalLine = [UIBezierPath bezierPath];
    CGPoint pointB = CGPointMake(self.mainView.center.x, self.mainView.center.y - self.mainView.bounds.size.height/2);
    CGPoint pointC = CGPointMake(self.mainView.center.x + self.mainView.bounds.size.width/2, self.mainView.center.y);
    CGPoint pointP = CGPointMake(self.mainView.frame.origin.x + self.mainView.bounds.size.width + amount * cosf(45 *(M_PI/180)),self.mainView.frame.origin.y - amount * cosf(45 *(M_PI/180)));
    
    [verticalLine moveToPoint:pointC];
    [verticalLine addQuadCurveToPoint:pointB controlPoint:pointP];
    [verticalLine addArcWithCenter:self.mainView.center radius:R startAngle:M_PI_2 endAngle:M_PI clockwise:NO];
    [verticalLine addArcWithCenter:self.mainView.center radius:R startAngle:M_PI endAngle:2*M_PI clockwise:NO];
    
    return [verticalLine CGPath];
}

- (CGPathRef) getLeftLinePathWithAmount:(CGFloat)amount {
    UIBezierPath *verticalLine = [UIBezierPath bezierPath];
    CGPoint pointA = CGPointMake(self.mainView.center.x - self.mainView.bounds.size.width/2, self.mainView.center.y) ;
    CGPoint pointB = CGPointMake(self.mainView.center.x, self.mainView.center.y - self.mainView.bounds.size.height/2);
    CGPoint pointO = CGPointMake(self.mainView.frame.origin.x - amount * cosf(45 *(M_PI/180)), self.mainView.frame.origin.y - amount * cosf(45 *(M_PI/180)));
    
    [verticalLine moveToPoint:pointB];
    [verticalLine addQuadCurveToPoint:pointA controlPoint:pointO];
    [verticalLine addArcWithCenter:self.mainView.center radius:R startAngle:M_PI endAngle:2*M_PI clockwise:NO];
    [verticalLine addArcWithCenter:self.mainView.center radius:R startAngle:0 endAngle:M_PI_2 clockwise:NO];
    
    return [verticalLine CGPath];
}


#pragma mark -- tap the item
-(void)menuTap:(UITapGestureRecognizer *)tapGes{
    
    for (int i = 0; i<menuCount; i++) {
        if ((tapGes.view.tag == i+1) && [self.menuDelegate respondsToSelector:@selector(menuDidSelected:)]) {
            [self.menuDelegate menuDidSelected:i+1];
        }
    }
    
    [self tapToSwitchOpenOrClose];
}


#pragma mark -- tap the menu
-(void)tapToSwitchOpenOrClose{
    
    if (!once) {
        [self setUpSomeDatas];
        //        NSAssert(self.menuImagesArray.count == menuCount, @"Images' count is not equal with menus' count");
        once = YES;
    }
    
    if (verticalLineLayer == nil) {
        verticalLineLayer = [CAShapeLayer layer];
        verticalLineLayer.fillColor = [menuColor CGColor];
        [self.containerView.layer insertSublayer:verticalLineLayer below:self.mainView.layer];
    }
    
    if (isOpened == NO) {
        
        //        CAKeyframeAnimation *morph_right = [KYSpringLayerAnimation createSpring:@"path" duration:0.4f usingSpringWithDamping:0.5f initialSpringVelocity:3.0f fromValue:@(1) toValue:@(1)];
        
        CAKeyframeAnimation *morph_right = [CAKeyframeAnimation animationWithKeyPath:@"path"];
        morph_right.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        morph_right.values = values0_1_right;
        morph_right.duration = 0.4f;
        morph_right.removedOnCompletion = NO;
        morph_right.fillMode = kCAFillModeForwards;
        morph_right.delegate = self;
        [verticalLineLayer addAnimation:morph_right forKey:@"bounce_0_1_right"];
        
        
        for (UIView *item in menus) {
            
            item.hidden = NO;
            [UIView animateWithDuration:1.0f delay:0.05*item.tag usingSpringWithDamping:0.4f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
                
                NSValue *pointValue = [pointsDic objectForKey:[NSString stringWithFormat:@"center%d",(int)item.tag]];
                CGPoint terminalPoint = [pointValue CGPointValue];
                item.center = terminalPoint;
                cross.transform = CGAffineTransformMakeRotation(45*(M_PI/180));
                
            } completion:nil];
        }
        
        isOpened = YES;
        
        
    }else{
        
        for (UIView *item in menus) {
            
            [UIView animateWithDuration:0.3f delay:0.05*item.tag options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
                CGPoint terminalPoint = self.mainView.center;
                item.center = terminalPoint;
                cross.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                //                item.hidden = YES;
            }];
            
            CAKeyframeAnimation *morph_left = [CAKeyframeAnimation animationWithKeyPath:@"path"];
            morph_left.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            morph_left.beginTime = CACurrentMediaTime()+0.1f;
            morph_left.values = values1_0_right;
            morph_left.duration = 0.4f;
            morph_left.removedOnCompletion = NO;
            morph_left.fillMode = kCAFillModeForwards;
            morph_left.delegate = self;
            [verticalLineLayer addAnimation:morph_left forKey:@"bounce_1_0_right"];
            
        }
        
        isOpened = NO;
        
    }
    
}

- (void)animationDidStart:(CAAnimation *)anim{
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (anim == [verticalLineLayer animationForKey:@"bounce_0_1_right"]) {
        CAKeyframeAnimation *morph_left = [CAKeyframeAnimation animationWithKeyPath:@"path"];
        morph_left.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        //        morph_left.beginTime = CACurrentMediaTime()+0.3f;
        morph_left.values = values0_1_left;
        morph_left.duration = 0.4f;
        morph_left.removedOnCompletion = NO;
        morph_left.fillMode = kCAFillModeForwards;
        morph_left.delegate = self;
        [verticalLineLayer addAnimation:morph_left forKey:@"bounce_0_1_left"];
        
    }else if(anim == [verticalLineLayer animationForKey:@"bounce_1_0_right"]){
        CAKeyframeAnimation *morph_right = [CAKeyframeAnimation animationWithKeyPath:@"path"];
        morph_right.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        //        morph_right.beginTime = CACurrentMediaTime()+0.3f;
        morph_right.values = values1_0_left;
        morph_right.duration = 0.4f;
        morph_right.removedOnCompletion = NO;
        morph_right.fillMode = kCAFillModeForwards;
        morph_right.delegate = self;
        
        [verticalLineLayer addAnimation:morph_right forKey:@"bounce_1_0_left"];
        
    }else if(anim == [verticalLineLayer animationForKey:@"bounce_1_0_left"] || [verticalLineLayer animationForKey:@"bounce_0_1_left"]){
        [verticalLineLayer removeFromSuperlayer];
        verticalLineLayer = nil;
    }
    
}


@end
