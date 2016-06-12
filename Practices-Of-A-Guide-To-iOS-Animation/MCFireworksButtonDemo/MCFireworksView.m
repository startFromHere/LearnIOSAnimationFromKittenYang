//
//  MCFireworksView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 5/30/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "MCFireworksView.h"

@interface MCFireworksView()

@property (strong, nonatomic) NSArray *emitterCells;
@property (strong,nonatomic) CAEmitterLayer *explosionLayer;

@end

@implementation MCFireworksView

- (void)setup{
    self.clipsToBounds = NO;
    self.userInteractionEnabled = NO;
    
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosion";
    explosionCell.alphaRange = 0.20;
    explosionCell.alphaSpeed = -1.0;
    
    explosionCell.lifetime = 0.7;
    explosionCell.lifetimeRange = 0.3;
    explosionCell.birthRate = 0;
    explosionCell.velocity = 40.0;
    explosionCell.velocityRange = 10.00;
    explosionCell.emissionRange = M_PI_4;
    explosionCell.scale = 0.05;
    explosionCell.scaleRange = 0.02;
    
    _explosionLayer = [CAEmitterLayer layer];
    _explosionLayer.name = @"emiterLayer";
    _explosionLayer.emitterShape = kCAEmitterLayerCircle;
    _explosionLayer.emitterMode = kCAEmitterLayerOutline;
    _explosionLayer.emitterPosition = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _explosionLayer.emitterSize = CGSizeMake(25, 0);
    _explosionLayer.emitterCells = @[explosionCell];
    _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    _explosionLayer.masksToBounds = NO;
    
    [self.layer addSublayer:_explosionLayer];
    self.emitterCells = @[explosionCell];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.explosionLayer.emitterPosition = center;
}

#pragma mark - Methods

- (void)animate{
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, .2 * NSEC_PER_SEC);
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        [self explode];
    });
}

- (void)explode{
    self.explosionLayer.beginTime = CACurrentMediaTime();
    [self.explosionLayer setValue:@500 forKeyPath:@"emitterCells.explosion.birthRate"];
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        [self stop];
    });
}

- (void)stop{
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}


#pragma mark - Properties

- (void)setParticleImage:(UIImage *)particleImage{
    _particleImage = particleImage;
    for (CAEmitterCell *cell in self.emitterCells) {
        cell.contents = (id)[particleImage CGImage];
    }
}

@end
